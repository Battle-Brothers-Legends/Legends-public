from .client import *


class NexusUploadTask:
	def __init__(self, api_key: str, mod_id: int):
		self.client = NexusV3Client(api_key, "battlebrothers", mod_id)
		self.s3client = S3FileTransferClient()

	def run(self, file_path, description: str, filename: str | None = None, version: str | None = None):
		if not os.path.isfile(file_path):
			print(f"{file_path} does not exist")
			exit(1)

		file_size = os.path.getsize(file_path)
		_filename = os.path.basename(file_path)
		_version = _filename.rsplit('.', 1)[0].rsplit('-', 1)[-1]

		if filename:
			_filename = filename

		if version:
			_version = version

		mod_info = self.client.get_mod()
		active_group = self._get_active_group(mod_info, filename)

		if file_size < 100 * 1024 * 1024:
			state = self._upload_small(file_path)
		else:
			state = self._upload_large(file_path)
		state = self.client.finalize_upload(state)

		print("Waiting for nexus to confirm transaction...")
		if active_group is None:
			self.client.create_new_file(CreateNewFileRequest(state.id, mod_info.id, _filename, _version, description, FileCategory.MAIN))
			print(f"{file_path} has been uploaded as new file")
		else:
			self.client.update_file(UpdateFileRequest(state.id, _filename, _version, description, FileCategory.MAIN), active_group.id)
			print(f"{file_path} has been uploaded as an update")

	def _upload_small(self, file_path) -> UploadState:
		# uploads files < 100MB as per nexus docs
		upload_request = self.client.create_upload(UploadRequest(os.path.getsize(file_path), os.path.basename(file_path)))
		self.s3client.upload_single_part(upload_request, file_path)
		return self.client.get_upload_state(upload_request)

	def _upload_large(self, file_path) -> UploadState:
		# uploads files >= 100MB as per nexus docs
		upload_request = self.client.create_upload_multipart(UploadRequest(os.path.getsize(file_path), os.path.basename(file_path)))
		self.s3client.upload_multipart_chunks(upload_request, file_path)
		return self.client.get_upload_state(upload_request)

	def _get_active_group(self, mod_info: ModInfo, filename: str) -> FileUpdateGroup | None:
		filename = filename.rsplit('-', 1)[0]
		groups = sorted(
			self.client.get_upload_groups(mod_info).groups,
			key=lambda x: x.last_file_uploaded_at,
			reverse=True
		)
		active_groups = [g for g in groups if g.is_active and filename in g.name]
		if len(active_groups) > 0:
			return active_groups[0]
		return None
