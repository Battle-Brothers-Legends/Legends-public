from .nexus_model import *
from . import LazyFileReader
from tqdm import tqdm
import os, requests


class S3FileTransferClient:
	def __init__(self):
		self.session = requests.Session()

	def upload_single_part(self, request: SingleUploadResponse, file_path: str):
		print(f"Uploading File {file_path}")

		file_size = os.path.getsize(file_path)

		with open(file_path, 'rb') as f, tqdm(
				total=file_size, unit="B", unit_scale=True, unit_divisor=1024, desc=""
		) as pbar:
			stream = LazyFileReader(f, pbar, file_size)
			response = self.session.put(
				url=request.presigned_url,
				data=stream,
				headers={
					'Content-Length': str(file_size),
					'Content-Type': 'application/octet-stream'
				}
			)
			response.raise_for_status()

	def upload_multipart_chunks(self, request: MultipartUploadResponse, file_path: str):
		print(f"Uploading File {file_path}")
		completed_parts = []
		chunk_size = request.parts_size
		file_size = os.path.getsize(file_path)
		num_parts = len(request.parts_presigned_url)

		with open(file_path, 'rb') as f, tqdm(
				total=file_size, unit="B", unit_scale=True, unit_divisor=1024, desc=""
		) as pbar:
			for idx, part_url in enumerate(request.parts_presigned_url):
				f.seek(idx * chunk_size)
				part_size = min(chunk_size, file_size - (idx * chunk_size))
				stream = LazyFileReader(f, pbar, part_size)

				pbar.set_postfix(part=f"{idx + 1}/{num_parts}", refresh=True)

				resp = self.session.put(
					url=part_url,
					data=stream,
					headers={
						'Content-Length': str(part_size),
						'Content-Type': 'application/octet-stream'
					}
				)
				resp.raise_for_status()

				etag = resp.headers.get('ETag')
				completed_parts.append({
					"PartNumber": idx + 1,
					"ETag": etag
				})

		xml = self._generate_complete_xml(completed_parts)

		response = requests.post(request.complete_presigned_url, data=xml, headers={'Content-Type': 'text/xml'})
		response.raise_for_status()

	@staticmethod
	def _generate_complete_xml(completed_parts: list) -> str:
		xml_parts = []
		for p in completed_parts:
			xml_parts.append(
				f"  <Part>\n"
				f"    <PartNumber>{p['PartNumber']}</PartNumber>\n"
				f"    <ETag>{p['ETag']}</ETag>\n"
				f"  </Part>"
			)
		body = "\n".join(xml_parts)
		return f"<CompleteMultipartUpload>\n{body}\n</CompleteMultipartUpload>"
