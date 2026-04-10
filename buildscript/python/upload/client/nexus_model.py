from dataclasses import dataclass
from datetime import datetime
from enum import Enum
from typing import List, Optional


class FileCategory(str, Enum):
	MAIN = "main"
	OPTIONAL = "optional"
	MISCELLANEOUS = "miscellaneous"


@dataclass
class ApiError(BaseException):
	message: str


@dataclass
class ModInfo:
	id: str
	game_scoped_id: str
	game_id: str
	name: Optional[str]


@dataclass
class FileUpdateGroup:
	id: str
	name: str
	is_active: bool
	last_file_uploaded_at: datetime
	versions_count: int


@dataclass
class FileUpdateGroups:
	groups: List[FileUpdateGroup]


@dataclass
class UploadState:
	id: str
	user_id: str
	state: str


@dataclass
class UploadRequest:
	size_bytes: int
	filename: str


@dataclass
class SingleUploadResponse:
	presigned_url: str
	id: str
	user_id: str
	state: str


@dataclass
class MultipartUploadResponse:
	parts_size: int
	parts_presigned_url: List[str]
	complete_presigned_url: str
	id: str
	user_id: str
	state: str


@dataclass
class CreateNewFileRequest:
	upload_id: str
	mod_id: str
	name: str
	version: str
	description: str
	file_category: FileCategory


@dataclass
class UpdateFileRequest:
	upload_id: str
	name: str
	version: str
	description: str
	file_category: FileCategory


@dataclass
class NewFileResponse:
	id: str
	game_scoped_id: str
	name: str
	file_category: FileCategory

