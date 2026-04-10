from dataclasses import dataclass
from datetime import datetime
from enum import Enum
from typing import List, Optional


@dataclass
class ApiError(BaseException):
	message: str


@dataclass
class CreateDraftReleaseRequest:
	tag_name: str
	target_commitish: str
	name: str
	body: str
	draft: bool
	prerelease: bool
	generate_release_notes: bool

@dataclass
class CreateDraftReleaseResponse:
	id: int
	upload_url: str

@dataclass
class ListAssetsRequest:
	owner: str
	repo: str
	release_id: str

@dataclass
class ListAssetsResponse:
	id: int
	name: str
	state: str
	size: int

