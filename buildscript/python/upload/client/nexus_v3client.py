from dataclasses import asdict
from .nexus_model import *
import dacite
import requests


class NexusV3Client:
	def __init__(self, api_key, game, mod_id):
		self.config = dacite.Config(type_hooks={
			datetime: datetime.fromisoformat,
			FileCategory: FileCategory
		})
		self.base_url = "https://api.nexusmods.com/v3"
		self.game = game
		self.mod_id = mod_id
		self.headers = {
			"apikey": api_key,
			"Accept": "application/json",
			"Content-Type": "application/json"
		}

	def get_mod(self) -> ModInfo:
		response = requests.get(f"{self.base_url}/games/{self.game}/mods/{self.mod_id}", headers=self.headers)
		if response.status_code == 200:
			return dacite.from_dict(data_class=ModInfo, data=response.json()['data'], config=self.config)
		else:
			raise dacite.from_dict(data_class=ApiError, data=response.json(), config=self.config)

	def get_upload_groups(self, mod: ModInfo) -> FileUpdateGroups:
		response = requests.get(f"{self.base_url}/mods/{mod.id}/file-update-groups", headers=self.headers)
		if response.status_code == 200:
			return dacite.from_dict(data_class=FileUpdateGroups, data=response.json()['data'], config=self.config)
		else:
			raise dacite.from_dict(data_class=ApiError, data=response.json(), config=self.config)

	def get_upload_state(self, upload: SingleUploadResponse | MultipartUploadResponse) -> UploadState:
		response = requests.get(f"{self.base_url}/uploads/{upload.id}", headers=self.headers)
		if response.status_code == 200:
			return dacite.from_dict(data_class=UploadState, data=response.json()['data'], config=self.config)
		else:
			raise dacite.from_dict(data_class=ApiError, data=response.json(), config=self.config)

	def create_upload(self, request: UploadRequest) -> SingleUploadResponse:
		response = requests.post(f"{self.base_url}/uploads", headers=self.headers, json=asdict(request))
		if response.status_code == 201:
			return dacite.from_dict(data_class=SingleUploadResponse, data=response.json()['data'], config=self.config)
		else:
			raise dacite.from_dict(data_class=ApiError, data=response.json(), config=self.config)

	def create_upload_multipart(self, request: UploadRequest) -> MultipartUploadResponse:
		response = requests.post(f"{self.base_url}/uploads/multipart", headers=self.headers, json=asdict(request))
		if response.status_code == 201:
			return dacite.from_dict(data_class=MultipartUploadResponse, data=response.json()['data'], config=self.config)
		else:
			raise dacite.from_dict(data_class=ApiError, data=response.json(), config=self.config)

	def finalize_upload(self, state: UploadState) -> UploadState:
		response = requests.post(f"{self.base_url}/uploads/{state.id}/finalise", headers=self.headers)
		if response.status_code == 200:
			return dacite.from_dict(data_class=UploadState, data=response.json()['data'], config=self.config)
		else:
			raise dacite.from_dict(data_class=ApiError, data=response.json(), config=self.config)

	def create_new_file(self, request: CreateNewFileRequest) -> NewFileResponse:
		response = requests.post(f"{self.base_url}/mod-files", headers=self.headers, json=asdict(request))
		if response.status_code == 201:
			return dacite.from_dict(data_class=NewFileResponse, data=response.json()['data'], config=self.config)
		else:
			raise dacite.from_dict(data_class=ApiError, data=response.json(), config=self.config)

	def update_file(self, request: UpdateFileRequest, group_id: str) -> NewFileResponse:
		response = requests.post(f"{self.base_url}/mod-file-update-groups/{group_id}/versions", headers=self.headers, json=asdict(request))
		if response.status_code == 201:
			return dacite.from_dict(data_class=NewFileResponse, data=response.json()['data'], config=self.config)
		else:
			raise dacite.from_dict(data_class=ApiError, data=response.json(), config=self.config)
