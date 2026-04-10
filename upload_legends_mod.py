from pathlib import Path
from buildscript.lib import VersionExtractor, load_config
from buildscript.python.upload import NexusUploadTask, GithubUploadTask, ApiError
import subprocess
import build_legends_mod

def commits(tag: str) -> str:
	messages = subprocess.check_output(["git", "log", f"{tag}..HEAD", "--no-merges", "--format=%s", "--reverse"], encoding="utf-8").strip()
	return "\n".join([f"- {m}" for m in messages.split("\n")])

def main():
	config = load_config(Path(__file__).parent / ".build_config.py")
	version_extractor = VersionExtractor(Path.cwd())

	base_version = version_extractor.get_base_version()
	current_version = version_extractor.extract_version()

	bb_dir = Path(config.BB_DIR)

	file = bb_dir / version_extractor.artifact_name_mod()
	assets_file = bb_dir / version_extractor.artifact_name_assets()

	build_legends_mod.main()

	if config.NEXUS_TOKEN is not None:
		nexus_task = NexusUploadTask(config.NEXUS_TOKEN, 60)
		try:
			nexus_task.run(assets_file, f"""
This is an asset library required to play the Legends mod.

It can be installed by just dropped it into data. DO NOT UNZIP.
			""".strip())
			nexus_task.run(file, f"""
REQUIRES VERSION 1.5.1.0+ OF VANILLA GAME
	
SAVE COMPATIBLE WITH {base_version}+

DO NOT UNZIP YOUR MOD FILES

You need {version_extractor.artifact_name_assets()} to play!

To install: drop into 'data' Battle Brothers folder
			""".strip())
		except ApiError as e:
			print(e.message)
	else:
		print("NEXUS_TOKEN not found in config, skipping upload")

	if config.GITHUB_TOKEN is not None:
		build_name = version_extractor.extract_build_name()
		parts = current_version.split(".")
		previous_version = f"{'.'.join(parts[:-1])}.{int(parts[-1]) - 1}"
		desc = f"""
# {current_version} - {build_name}

`SAVE COMPATIBLE WITH {base_version}+`
`DO NOT UNZIP YOUR MOD FILES`
`REMOVE ALL YOUR PREVIOUS OFFICIAL LEGENDS PATCHES AND VERSIONS`

Replace the `mod_legends-{previous_version}.zip` with `{version_extractor.artifact_name_mod()}`
You need `{version_extractor.artifact_name_assets()}` to play. Download both zips.

## Fixes
{commits(previous_version)}
		""".strip()

		github_task = GithubUploadTask(config.GITHUB_TOKEN, owner="Battle-Brothers-Legends", repo="Legends-public")
		try:
			github_task.run([assets_file, file], desc, branch=f"release/{base_version}", releaseName=f"{build_name} {current_version}")
		except ApiError as e:
			print(e.message)
	else:
		print("GITHUB_TOKEN not found in config, skipping upload")


if __name__ == "__main__":
	main()
