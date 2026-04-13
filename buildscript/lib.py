#!/usr/bin/env python3
"""
Shared library for Legends build scripts
Contains common functions and utilities used across build scripts
"""
from dataclasses import dataclass, fields
from pathlib import Path
import os
import sys
import subprocess
import shutil
import re
import platform
import importlib.util

@dataclass
class Config:
	REPO_DIR: str = "Legends-public"
	BB_DIR: str = None
	BUILD_DIR: str = "./build"
	NEXUS_TOKEN: str = None # nexus personal api key
	GITHUB_TOKEN: str = None # github token for uploads
	GITHUB_OPEN_RELEASE: bool = False # open browser with release page after upload successful

def load_config(config_path: Path) -> Config:
	"""Load configuration from .build_config.py if it exists"""
	config = Config()
	if config_path.exists():
		try:
			spec = importlib.util.spec_from_file_location("config", config_path)
			config_module = importlib.util.module_from_spec(spec)
			spec.loader.exec_module(config_module)

			# Only update fields that actually exist in our Dataclass
			for field in fields(Config):
				if hasattr(config_module, field.name):
					setattr(config, field.name, getattr(config_module, field.name))
		except Exception:
			pass
	return config


class BuildError(Exception):
	"""Base exception for build errors"""
	pass


class BuildUtils:
	"""Utility class with common build functions"""

	@staticmethod
	def get_platform_paths():
		"""Get platform-specific default paths"""
		if platform.system() == "Windows":
			return {
				"bb_dir": r"c:\Steam\steamapps\common\Battle Brothers\data",
				"exe_ext": ".exe",
				"bat_ext": ".bat"
			}
		else:
			bb_dir = os.path.expanduser("~/.local/share/Steam/steamapps/common/Battle Brothers/data")
			return {
				"bb_dir": bb_dir,
				"exe_ext": ".sh",
				"bat_ext": ".sh"
			}

	@staticmethod
	def handle_exit(result, context=""):
		"""Handle subprocess exit codes"""
		if result.returncode != 0:
			error_msg = f"Failed to {context if context else 'execute command'}!"
			print(error_msg)
			if hasattr(result, 'stderr') and result.stderr:
				print(f"Error output: {result.stderr}")
			raise BuildError(error_msg)

	@staticmethod
	def run_command(cmd, cwd=None, capture_output=True, text=True, context="", encoding='utf-8', errors='replace'):
		"""Run a command and handle errors"""
		try:
			result = subprocess.run(cmd, capture_output=capture_output, text=text, cwd=cwd)
			if context:
				BuildUtils.handle_exit(result, context)
			return result
		except FileNotFoundError as e:
			raise BuildError(f"Command not found: {cmd[0]} - {e}")
		except Exception as e:
			raise BuildError(f"Failed to run command {cmd}: {e}")

	@staticmethod
	def safe_copy_tree(src, dest, ignore_errors=False):
		"""Safely copy a directory tree"""
		src_path = Path(src)
		dest_path = Path(dest)

		if not src_path.exists():
			if ignore_errors:
				print(f"Warning: Source directory {src_path} does not exist")
				return
			else:
				raise BuildError(f"Source directory {src_path} does not exist")

		try:
			dest_path.parent.mkdir(parents=True, exist_ok=True)
			if dest_path.exists():
				shutil.rmtree(dest_path)
			shutil.copytree(src_path, dest_path)
		except Exception as e:
			if ignore_errors:
				print(f"Warning: Failed to copy {src_path} to {dest_path}: {e}")
			else:
				raise BuildError(f"Failed to copy {src_path} to {dest_path}: {e}")

	@staticmethod
	def safe_copy_file(src, dest, ignore_errors=False):
		"""Safely copy a file"""
		src_path = Path(src)
		dest_path = Path(dest)

		if not src_path.exists():
			if ignore_errors:
				print(f"Warning: Source file {src_path} does not exist")
				return
			else:
				raise BuildError(f"Source file {src_path} does not exist")

		try:
			dest_path.parent.mkdir(parents=True, exist_ok=True)
			shutil.copy2(src_path, dest_path)
		except Exception as e:
			if ignore_errors:
				print(f"Warning: Failed to copy {src_path} to {dest_path}: {e}")
			else:
				raise BuildError(f"Failed to copy {src_path} to {dest_path}: {e}")

	@staticmethod
	def create_zip_archive(zip_path, items, use_7z=True):
		"""Create a zip archive using 7z or Python's zipfile as fallback"""
		zip_path = Path(zip_path)

		if use_7z:
			try:
				cmd = ["7z", "a", "-tzip", str(zip_path)] + [str(item) for item in items]
				result = subprocess.run(cmd, capture_output=True, text=True, encoding='utf-8', errors='replace')
				if result.returncode == 0:
					return
			except FileNotFoundError:
				pass  # Fall through to zipfile

		# Use Python's zipfile as fallback
		import zipfile
		print(f"Using Python zipfile to create {zip_path}")

		with zipfile.ZipFile(zip_path, 'w', zipfile.ZIP_DEFLATED) as zf:
			for item in items:
				item_path = Path(item)
				if item_path.is_file():
					zf.write(item_path, item_path)
				elif item_path.is_dir():
					for root, dirs, files in os.walk(item_path):
						for file in files:
							file_path = Path(root) / file
							arc_path = file_path.relative_to(item_path.parent)
							zf.write(file_path, arc_path)

	@staticmethod
	def add_to_zip_archive(zip_path, items, use_7z=True):
		"""Add items to an existing zip archive"""
		zip_path = Path(zip_path)

		if use_7z:
			try:
				cmd = ["7z", "a", str(zip_path)] + [str(item) for item in items]
				result = subprocess.run(cmd, capture_output=True, text=True, encoding='utf-8', errors='replace')
				if result.returncode == 0:
					return
			except FileNotFoundError:
				pass  # Fall through to zipfile

		# Use Python's zipfile as fallback
		import zipfile
		print(f"Using Python zipfile to add to {zip_path}")

		with zipfile.ZipFile(zip_path, 'a', zipfile.ZIP_DEFLATED) as zf:
			for item in items:
				item_path = Path(item)
				if item_path.is_file():
					zf.write(item_path, item_path)
				elif item_path.is_dir():
					for root, dirs, files in os.walk(item_path):
						for file in files:
							file_path = Path(root) / file
							arc_path = file_path.relative_to(item_path.parent)
							zf.write(file_path, arc_path)


class VersionExtractor:
	"""Class for extracting version information from Legends files"""

	def __init__(self, current_dir=None):
		self.current_dir = Path(current_dir) if current_dir else Path.cwd()
		self.register_file = self.current_dir / "scripts" / "!mods_preload" / "register_legends.nut"
		if not self.register_file.exists():
			raise BuildError("Could not find register_legends.nut to extract version")


	def extract_build_name(self):
		"""Extract build name from register_legends.nut"""
		with open(self.register_file, 'r') as f:
			content = f.read()
			match = re.search(r'BuildName\s*=\s*\"([^\"]+)\"', content)
			if match:
				return match.group(1)
			else:
				raise BuildError("Could not extract build name from register_legends.nut")

	def extract_version(self):
		"""Extract current version from register_legends.nut"""
		with open(self.register_file, 'r') as f:
			content = f.read()
			match = re.search(r'Version\s*=\s*"([0-9]+\.[0-9]+\.[0-9]+(?:-[^"]+)?)"', content)
			if match:
				return match.group(1)
			else:
				raise BuildError("Could not extract version from register_legends.nut")

	def get_legends_assets_version(self):
		"""Extract legends assets version from register_legends.nut"""
		with open(self.register_file, 'r') as f:
			content = f.read()
			match = re.search(r'mod_legends_assets\(>=([0-9]+\.[0-9]+\.[0-9]+(?:-[^)]+)?)\)', content)
			if match:
				return match.group(1)
			else:
				raise BuildError("Could not extract assets version from register_legends.nut")

	def get_base_version(self):
		"""Returns base version with .0 relative to current"""
		parts = self.get_legends_assets_version().split('.')
		return f"{parts[0]}.{parts[1]}.0"

	def artifact_name_mod(self):
		"""Generate mod artifact name"""
		version = self.extract_version()
		return f"mod_legends-{version}.zip"

	def artifact_name_assets(self):
		"""Generate assets artifact name"""
		assets_version = self.get_legends_assets_version()
		return f"mod_legends-assets-{assets_version}.zip"

	def build_assets_script(self):
		"""Build asset mod script dynamically"""
		assets_version = self.get_legends_assets_version()
		script_content = f"""::LegendsAssets <- {{
	ID = "mod_legends_assets",
	Version = "{assets_version}",
	Name = "Legends assets"
}};
::mods_registerMod(::LegendsAssets.ID, ::LegendsAssets.Version, ::LegendsAssets.Name);"""
		return script_content


class GitUtils:
	"""Utility class for Git operations"""

	def __init__(self, repo_dir=None):
		self.repo_dir = Path(repo_dir) if repo_dir else Path.cwd()

	def get_git_status(self):
		"""Get git status output"""
		try:
			result = subprocess.run(["git", "status", "-s"],
								  capture_output=True, text=True, cwd=self.repo_dir, encoding='utf-8', errors='replace')
			if result.returncode != 0:
				print("Warning: Could not get git status")
				return ""
			return result.stdout
		except FileNotFoundError:
			print("Warning: git not found, skipping git status check")
			return ""

	def get_commit_hash(self, ref):
		"""Get commit hash for a given reference"""
		try:
			result = subprocess.run(["git", "rev-parse", ref],
								  capture_output=True, text=True, cwd=self.repo_dir, encoding='utf-8', errors='replace')
			if result.returncode == 0:
				return result.stdout.strip()
			else:
				return ""
		except FileNotFoundError:
			print("Warning: git not found")
			return ""

	def get_modified_files(self, since_ref=None):
		"""Get list of modified files since a reference"""
		if not since_ref:
			return []

		try:
			result = subprocess.run(["git", "diff", "--name-only", since_ref, "HEAD"],
								  capture_output=True, text=True, cwd=self.repo_dir, encoding='utf-8', errors='replace')
			if result.returncode == 0:
				return result.stdout.strip().split('\n') if result.stdout.strip() else []
			else:
				print("Warning: Could not get git diff")
				return []
		except FileNotFoundError:
			print("Warning: git not found")
			return []


class BrushUtils:
	"""Utility class for brush-related operations"""

	def __init__(self, current_dir=None, repo_dir="battlebrothers"):
		self.current_dir = Path(current_dir) if current_dir else Path.cwd()
		self.repo_dir = repo_dir
		self.bin_dir = self.current_dir.parent / "bin"

		platform_info = BuildUtils.get_platform_paths()
		self.exe_ext = platform_info["exe_ext"]

	def get_helmet_brushes(self):
		"""Get list of helmet brush directories"""
		helmet_brushes = []
		helmet_dir = self.current_dir / "unpacked" / "legend_helmets"

		if helmet_dir.exists():
			for subdir in helmet_dir.iterdir():
				if subdir.is_dir() and subdir.name.isdigit():
					helmet_brushes.append(f"legend_helmets/{subdir.name}")

		return helmet_brushes

	def get_armor_brushes(self):
		"""Get list of armor brush directories"""
		armor_brushes = []
		armor_dir = self.current_dir / "unpacked" / "legend_armor"

		if armor_dir.exists():
			for subdir in armor_dir.iterdir():
				if subdir.is_dir() and subdir.name.isdigit():
					armor_brushes.append(f"legend_armor/{subdir.name}")

		return armor_brushes

	def check_for_error(self, output, brush_name):
		"""Check output for ERROR messages"""
		if "ERROR" in output:
			for line in output.split('\n'):
				print(line)
			raise BuildError(f"Failed to build Legends brush {brush_name}")

	def build_brush(self, brush_path):
		"""Build a single brush using bbrusher"""
		print(f"Building {brush_path} brush...")

		bbrusher_exe = self.bin_dir / f"bbrusher{self.exe_ext}"
		if not bbrusher_exe.exists():
			raise BuildError(f"bbrusher executable not found at {bbrusher_exe}")

		# Convert forward slashes to underscores for brush name
		brush_name = brush_path.replace("/", "_")
		brush_file = self.current_dir / "brushes" / f"{brush_name}.brush"
		unpacked_dir = self.current_dir / "unpacked" / brush_path

		if not unpacked_dir.exists():
			print(f"Warning: Unpacked directory {unpacked_dir} does not exist, skipping {brush_path}")
			return

		# Ensure brushes directory exists
		brush_file.parent.mkdir(parents=True, exist_ok=True)

		try:
			# Change to bin directory
			original_cwd = os.getcwd()
			os.chdir(self.bin_dir)

			# Run bbrusher command
			cmd = [
				str(bbrusher_exe), "pack",
				"--gfxPath", f"../{self.repo_dir}/",
				str(brush_file), str(unpacked_dir)
			]

			result = subprocess.run(cmd, capture_output=True, text=True, encoding='utf-8', errors='replace')

			# Change back to original directory
			os.chdir(original_cwd)

			self.check_for_error(result.stdout, brush_path)

			return result.stdout

		except Exception as e:
			os.chdir(original_cwd)  # Ensure we change back even on error
			raise BuildError(f"Failed to build brush {brush_path}: {e}")


class PythonScriptRunner:
	"""Utility class for running Python scripts"""

	def __init__(self, current_dir=None):
		self.current_dir = Path(current_dir) if current_dir else Path.cwd()

	def run_script(self, script_path, args=None, context=""):
		"""Run a Python script and handle errors"""
		script_full_path = self.current_dir / script_path
		print(f"Running {script_path}...")

		if not script_full_path.exists():
			raise BuildError(f"Python script {script_path} not found")

		cmd = [sys.executable, str(script_full_path)]
		if args:
			cmd.extend(args)

		try:
			result = subprocess.run(cmd, capture_output=True, text=True, cwd=self.current_dir)
			BuildUtils.handle_exit(result, context)
			return result.stdout
		except Exception as e:
			raise BuildError(f"Failed to run Python script {script_path}: {e}")


# Convenience functions that use the utility classes
def get_platform_paths():
	"""Get platform-specific default paths"""
	return BuildUtils.get_platform_paths()

def safe_copy_tree(src, dest, ignore_errors=False):
	"""Safely copy a directory tree"""
	return BuildUtils.safe_copy_tree(src, dest, ignore_errors)

def safe_copy_file(src, dest, ignore_errors=False):
	"""Safely copy a file"""
	return BuildUtils.safe_copy_file(src, dest, ignore_errors)

def create_zip_archive(zip_path, items, use_7z=True):
	"""Create a zip archive"""
	return BuildUtils.create_zip_archive(zip_path, items, use_7z)

def add_to_zip_archive(zip_path, items, use_7z=True):
	"""Add items to an existing zip archive"""
	return BuildUtils.add_to_zip_archive(zip_path, items, use_7z)
