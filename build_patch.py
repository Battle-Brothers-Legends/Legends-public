#!/usr/bin/env python3
"""
OS-agnostic patch build script for Legends mod
Replaces build_patch.sh with cross-platform Python implementation
"""

import os
import sys
import subprocess
import shutil
import argparse
from pathlib import Path
import platform


class PatchBuildError(Exception):
    """Custom exception for patch build errors"""

    pass


class PatchBuilder:
    def __init__(self, source=None, build_dir=None):
        self.current_dir = Path.cwd()
        self.log_file = self.current_dir / "log.txt"

        if build_dir is None:
            build_dir = "./build"
        self.build_dir = Path(build_dir)

        # Get latest tag for assets version
        self.latest_tag = self.get_legends_assets_version()

        # Get commit hash if source not provided
        if source is None:
            source = self.get_commit_hash(self.latest_tag)
        self.source = source

        print(f"Source: {self.source}")
        print(f"Build directory: {self.build_dir}")
        print(f"Latest tag: {self.latest_tag}")

    def handle_exit(self, result, context=""):
        """Handle subprocess exit codes"""
        if result.returncode != 0:
            error_msg = f"Failed to build {context if context else 'patch'}!"
            print(error_msg)
            if result.stderr:
                print(f"Error output: {result.stderr}")
            raise PatchBuildError(error_msg)

    def get_legends_assets_version(self):
        """Extract legends assets version from register_legends.nut"""
        register_file = self.current_dir / "scripts" / "!mods_preload" / "register_legends.nut"
        if not register_file.exists():
            raise PatchBuildError("Could not find register_legends.nut to extract assets version")

        with open(register_file, "r") as f:
            content = f.read()
            # Look for mod_legends_assets(>=X.Y.Z) pattern
            import re

            match = re.search(r"mod_legends_assets\(>=([0-9]+\.[0-9]+\.[0-9]+)\)", content)
            if match:
                return match.group(1)
            else:
                raise PatchBuildError("Could not extract assets version from register_legends.nut")

    def get_commit_hash(self, tag):
        """Get commit hash for a given tag"""
        try:
            result = subprocess.run(
                ["git", "rev-parse", tag],
                capture_output=True,
                text=True,
                cwd=self.current_dir,
            )
            if result.returncode == 0:
                return result.stdout.strip()
            else:
                return ""
        except FileNotFoundError:
            print("Warning: git not found")
            return ""

    def extract_version(self):
        """Extract current version from register_legends.nut"""
        register_file = self.current_dir / "scripts" / "!mods_preload" / "register_legends.nut"
        if not register_file.exists():
            raise PatchBuildError("Could not find register_legends.nut to extract version")

        with open(register_file, "r") as f:
            content = f.read()
            # Look for Version = "X.Y.Z" pattern
            import re

            match = re.search(r'Version = "([0-9]+\.[0-9]+\.[0-9]+)"', content)
            if match:
                return match.group(1)
            else:
                raise PatchBuildError("Could not extract version from register_legends.nut")

    def artifact_name_mod(self):
        """Generate mod artifact name"""
        version = self.extract_version()
        return f"mod_legends-{version}.zip"

    def run_python_script(self, script_path, context=""):
        """Run a Python script and handle errors"""
        script_full_path = self.current_dir / script_path
        print(f"Running {script_path}...")

        if not script_full_path.exists():
            raise PatchBuildError(f"Python script {script_path} not found")

        try:
            result = subprocess.run(
                [sys.executable, str(script_full_path), str(self.current_dir)],
                capture_output=True,
                text=True,
                cwd=self.current_dir,
            )
            self.handle_exit(result, context)
            return result.stdout
        except FileNotFoundError:
            raise PatchBuildError(f"Python script {script_path} not found")

    def build_helmets(self):
        """Build helmet scripts"""
        print("Building helmets...")

        # Remove and recreate helmet scripts directory
        helmet_scripts_dir = self.current_dir / "helmet_scripts"
        if helmet_scripts_dir.exists():
            shutil.rmtree(helmet_scripts_dir)
        helmet_scripts_dir.mkdir(exist_ok=True)

        # Run helmet generation script
        self.run_python_script("buildscript/python/make_legend_helmets.py", "helmet generation")

        # Copy helmet scripts to build directory
        build_helmet_dir = self.build_dir / "scripts" / "items" / "legend_helmets"
        build_helmet_dir.mkdir(parents=True, exist_ok=True)

        if helmet_scripts_dir.exists() and any(helmet_scripts_dir.iterdir()):
            shutil.copytree(helmet_scripts_dir, build_helmet_dir, dirs_exist_ok=True)

    def build_armor(self):
        """Build armor scripts"""
        print("Building armors...")

        # Remove and recreate armor scripts directory
        armor_scripts_dir = self.current_dir / "legend_armor_scripts"
        if armor_scripts_dir.exists():
            shutil.rmtree(armor_scripts_dir)
        armor_scripts_dir.mkdir(exist_ok=True)

        # Run armor generation script
        self.run_python_script("buildscript/python/make_legend_armor.py", "armor generation")

        # Copy armor scripts to build directory
        build_armor_dir = self.build_dir / "scripts" / "items" / "legend_armor"
        build_armor_dir.mkdir(parents=True, exist_ok=True)

        if armor_scripts_dir.exists() and any(armor_scripts_dir.iterdir()):
            shutil.copytree(armor_scripts_dir, build_armor_dir, dirs_exist_ok=True)

    def build_enemies(self):
        """Build enemies"""
        print("Building enemies...")
        self.run_python_script("buildscript/python/make_legend_enemies.py", "enemies generation")

    def copy_mod_directories(self):
        """Copy mod directories to build directory"""
        directories = ["mod_legends", "scripts", "ui"]

        for dir_name in directories:
            src_dir = self.current_dir / dir_name
            dest_dir = self.build_dir / dir_name

            if src_dir.exists():
                print(f"Copying {dir_name} to {dest_dir} ...")
                if dest_dir.exists():
                    # For scripts directory, merge instead of replace to preserve generated content
                    if dir_name == "scripts":
                        # Use the merge function from build_legends_mod
                        self._merge_directories(src_dir, dest_dir)
                    else:
                        shutil.rmtree(dest_dir)
                        shutil.copytree(src_dir, dest_dir)
                else:
                    shutil.copytree(src_dir, dest_dir)

    def _merge_directories(self, src_dir, dest_dir):
        """Merge source directory into destination, preserving existing content"""
        for item in src_dir.rglob("*"):
            if item.is_file():
                # Calculate relative path and destination
                rel_path = item.relative_to(src_dir)
                dest_item = dest_dir / rel_path

                # Create parent directories if they don't exist
                dest_item.parent.mkdir(parents=True, exist_ok=True)

                # Copy the file (overwrites existing files)
                shutil.copy2(item, dest_item)

    def create_initial_zip(self):
        """Create initial zip archive"""
        zip_archive = self.artifact_name_mod()

        # Change to build directory
        original_cwd = os.getcwd()
        os.chdir(self.build_dir)

        try:
            # Check if 7z is available, otherwise use Python's zipfile
            try:
                with open(self.log_file, "a") as log:
                    result = subprocess.run(
                        [
                            "7z",
                            "a",
                            "-tzip",
                            zip_archive,
                            "mod_legends",
                            "scripts",
                            "ui",
                        ],
                        stdout=log,
                        stderr=subprocess.STDOUT,
                        text=True,
                    )

                if result.returncode != 0:
                    raise subprocess.CalledProcessError(result.returncode, "7z")

            except (FileNotFoundError, subprocess.CalledProcessError):
                # Fall back to Python zipfile
                print("7z not found, using Python zipfile...")
                import zipfile

                with zipfile.ZipFile(zip_archive, "w", zipfile.ZIP_DEFLATED) as zf:
                    for root, dirs, files in os.walk("."):
                        for file in files:
                            file_path = Path(root) / file
                            if any(
                                str(file_path).startswith(d)
                                for d in ["mod_legends", "scripts", "ui"]
                            ):
                                zf.write(file_path, file_path)

            # Move zip to build directory root
            shutil.move(zip_archive, f"../{zip_archive}")

        finally:
            os.chdir(original_cwd)

        return zip_archive

    def add_scripts_to_zip(self, zip_archive):
        """Add scripts directory to existing zip"""
        # Change to build directory
        original_cwd = os.getcwd()
        os.chdir(self.build_dir)

        try:
            # Check if 7z is available, otherwise use Python's zipfile
            try:
                with open(self.log_file, "a") as log:
                    result = subprocess.run(
                        ["7z", "a", "-tzip", zip_archive, "scripts"],
                        stdout=log,
                        stderr=subprocess.STDOUT,
                        text=True,
                    )

                if result.returncode != 0:
                    raise subprocess.CalledProcessError(result.returncode, "7z")

            except (FileNotFoundError, subprocess.CalledProcessError):
                # Fall back to Python zipfile
                print("7z not found, using Python zipfile...")
                import zipfile

                with zipfile.ZipFile(zip_archive, "a", zipfile.ZIP_DEFLATED) as zf:
                    for root, dirs, files in os.walk("scripts"):
                        for file in files:
                            file_path = Path(root) / file
                            zf.write(file_path, file_path)

        finally:
            os.chdir(original_cwd)

    def get_modified_files(self):
        """Get list of modified files since source commit"""
        if not self.source:
            return []

        try:
            result = subprocess.run(
                ["git", "diff", "--name-only", self.source, "HEAD"],
                capture_output=True,
                text=True,
                cwd=self.current_dir,
            )
            if result.returncode == 0:
                return result.stdout.strip().split("\n") if result.stdout.strip() else []
            else:
                print("Warning: Could not get git diff")
                return []
        except FileNotFoundError:
            print("Warning: git not found")
            return []

    def copy_assets(self, zip_archive):
        """Copy assets if they have been modified"""
        modified_files = self.get_modified_files()

        # Filter files that are in 'gfx' or 'sounds' directories
        filtered_files = [f for f in modified_files if f.startswith(("gfx/", "sounds/"))]

        if filtered_files:
            print("Modified asset files found, adding to archive...")

            # Create temporary asset directories in build
            for file_path in filtered_files:
                src_file = self.current_dir / file_path
                dest_file = self.build_dir / file_path

                if src_file.exists():
                    dest_file.parent.mkdir(parents=True, exist_ok=True)
                    shutil.copy2(src_file, dest_file)

            # Add to zip
            original_cwd = os.getcwd()
            os.chdir(self.build_dir)

            try:
                asset_dirs = set()
                for file_path in filtered_files:
                    asset_dirs.add(file_path.split("/")[0])

                # Check if 7z is available, otherwise use Python's zipfile
                try:
                    for asset_dir in asset_dirs:
                        if Path(asset_dir).exists():
                            result = subprocess.run(
                                ["7z", "a", "-tzip", zip_archive, asset_dir],
                                capture_output=True,
                                text=True,
                            )

                except (FileNotFoundError, subprocess.CalledProcessError):
                    # Fall back to Python zipfile
                    import zipfile

                    with zipfile.ZipFile(zip_archive, "a", zipfile.ZIP_DEFLATED) as zf:
                        for asset_dir in asset_dirs:
                            if Path(asset_dir).exists():
                                for root, dirs, files in os.walk(asset_dir):
                                    for file in files:
                                        file_path = Path(root) / file
                                        zf.write(file_path, file_path)

            finally:
                os.chdir(original_cwd)

    def build(self):
        """Main build process"""
        try:
            print("Starting patch build process...")

            # Remove and recreate build directory
            if self.build_dir.exists():
                shutil.rmtree(self.build_dir)
            self.build_dir.mkdir(parents=True)

            # Build components
            self.build_helmets()
            self.build_armor()
            self.build_enemies()

            # Copy mod directories
            self.copy_mod_directories()

            # Create initial zip
            zip_archive = self.create_initial_zip()

            # Move zip to build directory and add scripts
            zip_path = self.build_dir / zip_archive
            shutil.move(self.current_dir / zip_archive, zip_path)
            self.add_scripts_to_zip(str(zip_path))

            # Move final zip back to current directory
            final_zip_path = self.current_dir / zip_archive
            shutil.move(zip_path, final_zip_path)

            # Copy assets if modified
            self.copy_assets(str(final_zip_path))

            print(f"Patch build completed successfully! Created: {zip_archive}")

        except PatchBuildError as e:
            print(f"Patch build failed: {e}")
            sys.exit(1)
        except Exception as e:
            print(f"Unexpected error: {e}")
            sys.exit(1)


def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(description="Build patch for Legends mod")
    parser.add_argument("source", nargs="?", help="Source commit hash or branch")
    parser.add_argument(
        "build_dir",
        nargs="?",
        default="./build",
        help="Build directory (default: ./build)",
    )

    args = parser.parse_args()

    builder = PatchBuilder(args.source, args.build_dir)
    builder.build()


if __name__ == "__main__":
    main()
