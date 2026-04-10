from .client import *


class GithubUploadTask:
	def __init__(self, api_key: str, owner: str, repo: str):
		self.client = GithubClient(api_key, owner, repo)
		self.fileClient = GithubFileTransferClient(api_key)

	def run(
			self,
			files: list[str],
			description: str,
			branch: str,
			releaseName: str,
			version: str | None = None,
			draft: bool = True,
			prerelease: bool = False,
			generateNotes: bool = False,
	):

		for file in files:
			if not os.path.isfile(file):
				print(f"{file} does not exist")
				exit(1)

		_filename = os.path.basename(files[0])
		_version = _filename.rsplit('.', 1)[0].rsplit('-', 1)[-1]

		if version:
			_version = version

		release = self.client.create_draft(CreateDraftReleaseRequest(_version, branch, releaseName, description, draft, prerelease, generateNotes))

		for file in files:
			self.fileClient.upload_file(release, file, os.path.basename(file))
			print(f"{file} has been uploaded")
