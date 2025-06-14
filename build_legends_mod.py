#!/usr/bin/env python3
"""
OS-agnostic main build script for Legends mod
Replaces build_legends_mod.sh with cross-platform Python implementation
"""

import os
import sys
import subprocess
import shutil
import argparse
from pathlib import Path
import platform


class LegendsModBuildError(Exception):
    """Custom exception for legends mod build errors"""

    pass


class LegendsModBuilder:
    def __init__(self, bb_dir=None, repo_dir="Legends-public", build_dir=None):
        # Set default paths based on OS
        if bb_dir is None:
            if platform.system() == "Windows":
                bb_dir = r"c:\Steam\steamapps\common\Battle Brothers\data"
            else:
                bb_dir = os.path.expanduser(
                    "~/.local/share/Steam/steamapps/common/Battle Brothers/data"
                )

        if build_dir is None:
            build_dir = "./build"

        self.bb_dir = Path(bb_dir)
        self.repo_dir = repo_dir
        self.build_dir = Path(build_dir)
        self.current_dir = Path.cwd()

        print(f"Battle Brothers directory: {self.bb_dir}")
        print(f"Repository directory: {self.repo_dir}")
        print(f"Build directory: {self.build_dir}")
        print(f"Current directory: {self.current_dir}")

    def handle_exit(self, result, context=""):
        """Handle subprocess exit codes"""
        if result.returncode != 0:
            error_msg = f"Failed to build {context if context else 'Legends mod'}!"
            print(error_msg)
            if result.stderr:
                print(f"Error output: {result.stderr}")
            raise LegendsModBuildError(error_msg)

    def extract_version(self):
        """Extract current version from register_legends.nut"""
        register_file = self.current_dir / "scripts" / "!mods_preload" / "register_legends.nut"
        if not register_file.exists():
            raise LegendsModBuildError("Could not find register_legends.nut to extract version")

        with open(register_file, "r") as f:
            content = f.read()
            # Look for Version = "X.Y.Z" pattern
            import re

            match = re.search(r'Version = "([0-9]+\.[0-9]+\.[0-9]+)"', content)
            if match:
                return match.group(1)
            else:
                raise LegendsModBuildError("Could not extract version from register_legends.nut")

    def get_legends_assets_version(self):
        """Extract legends assets version from register_legends.nut"""
        register_file = self.current_dir / "scripts" / "!mods_preload" / "register_legends.nut"
        if not register_file.exists():
            raise LegendsModBuildError(
                "Could not find register_legends.nut to extract assets version"
            )

        with open(register_file, "r") as f:
            content = f.read()
            # Look for mod_legends_assets(>=X.Y.Z) pattern
            import re

            match = re.search(r"mod_legends_assets\(>=([0-9]+\.[0-9]+\.[0-9]+)\)", content)
            if match:
                return match.group(1)
            else:
                raise LegendsModBuildError(
                    "Could not extract assets version from register_legends.nut"
                )

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

    def artifact_name_mod(self):
        """Generate mod artifact name"""
        version = self.extract_version()
        return f"mod_legends-{version}.zip"

    def artifact_name_assets(self):
        """Generate assets artifact name"""
        assets_version = self.get_legends_assets_version()
        return f"mod_legends-assets-{assets_version}.zip"

    def copy_dead_assets(self):
        """Copy dead arrow and javelin assets"""
        dead_arrows_src = self.current_dir / "unpacked" / "dead_arrows.png"
        dead_javelin_src = self.current_dir / "unpacked" / "dead_javelin.png"
        dest_dir = self.current_dir / "unpacked" / "legend_characters" / "entity" / "bodies"

        dest_dir.mkdir(parents=True, exist_ok=True)

        if dead_arrows_src.exists():
            shutil.copy2(dead_arrows_src, dest_dir)
        if dead_javelin_src.exists():
            shutil.copy2(dead_javelin_src, dest_dir)

    def build_brushes(self):
        """Build brushes using the brush builder"""
        print("Building brushes...")
        try:
            # Import and use the brush builder
            from build_brushes import BrushBuilder

            brush_builder = BrushBuilder(str(self.build_dir), self.repo_dir)
            brush_builder.build()
        except ImportError:
            # Fall back to running as subprocess
            result = subprocess.run(
                [
                    sys.executable,
                    "build_brushes.py",
                    str(self.build_dir),
                    self.repo_dir,
                ],
                cwd=self.current_dir,
            )
            self.handle_exit(result, "brush building")

    def copy_directories(self):
        """Copy required directories to build directory"""
        directories = [
            ("sounds", "sounds"),
            ("gfx", "gfx"),
            ("mod_legends", "mod_legends"),
            ("scripts", "scripts"),
            ("ui", "ui"),
            ("preload", "preload"),
        ]

        for src_name, dest_name in directories:
            src_dir = self.current_dir / src_name
            dest_dir = self.build_dir / dest_name

            if src_dir.exists():
                print(f"Copying {src_name} to {dest_dir} ...")
                if dest_dir.exists():
                    # For scripts directory, merge instead of replace to preserve legend_armor/legend_helmets
                    if dest_name == "scripts":
                        # Copy with merge - preserve existing content
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

                # Copy the file
                shutil.copy2(item, dest_item)

    def create_zip_archives(self):
        """Create zip archives for mod and assets"""
        # Change to build directory
        original_cwd = os.getcwd()
        os.chdir(self.build_dir)

        try:
            zip_name_assets = self.artifact_name_assets()
            zip_name_mod = self.artifact_name_mod()

            # Check if 7z is available, otherwise use Python's zipfile
            try:
                # Create assets zip
                result = subprocess.run(
                    [
                        "7z",
                        "a",
                        "-tzip",
                        zip_name_assets,
                        "brushes",
                        "gfx",
                        "sounds",
                        "preload",
                    ],
                    capture_output=True,
                    text=True,
                )

                if result.returncode != 0:
                    raise subprocess.CalledProcessError(result.returncode, "7z")

                # Create mod zip
                result = subprocess.run(
                    ["7z", "a", "-tzip", zip_name_mod, "mod_legends", "scripts", "ui"],
                    capture_output=True,
                    text=True,
                )

                if result.returncode != 0:
                    raise subprocess.CalledProcessError(result.returncode, "7z")

            except (FileNotFoundError, subprocess.CalledProcessError):
                # Fall back to Python zipfile
                print("7z not found, using Python zipfile...")
                import zipfile

                # Create assets zip
                with zipfile.ZipFile(zip_name_assets, "w", zipfile.ZIP_DEFLATED) as zf:
                    for root, dirs, files in os.walk("."):
                        for file in files:
                            file_path = Path(root) / file
                            if any(
                                str(file_path).startswith(d)
                                for d in ["brushes", "gfx", "sounds", "preload"]
                            ):
                                zf.write(file_path, file_path)

                # Create mod zip
                with zipfile.ZipFile(zip_name_mod, "w", zipfile.ZIP_DEFLATED) as zf:
                    for root, dirs, files in os.walk("."):
                        for file in files:
                            file_path = Path(root) / file
                            if any(
                                str(file_path).startswith(d)
                                for d in ["mod_legends", "scripts", "ui"]
                            ):
                                zf.write(file_path, file_path)

            # Create assets script and add to assets zip
            assets_script_content = self.build_assets_script()

            # Remove scripts directory and recreate with just the assets script
            if Path("scripts").exists():
                shutil.rmtree("scripts")

            scripts_dir = Path("scripts") / "!mods_preload"
            scripts_dir.mkdir(parents=True)

            with open(scripts_dir / "mod_legends_assets.nut", "w") as f:
                f.write(assets_script_content)

            # Add scripts to assets zip
            try:
                result = subprocess.run(
                    ["7z", "a", zip_name_assets, "scripts"],
                    capture_output=True,
                    text=True,
                )
            except FileNotFoundError:
                # Use Python zipfile
                with zipfile.ZipFile(zip_name_assets, "a", zipfile.ZIP_DEFLATED) as zf:
                    for root, dirs, files in os.walk("scripts"):
                        for file in files:
                            file_path = Path(root) / file
                            zf.write(file_path, file_path)

            # Move zip files to BB directory
            shutil.move(zip_name_assets, self.bb_dir / zip_name_assets)
            shutil.move(zip_name_mod, self.bb_dir / zip_name_mod)

            print(f"Created {zip_name_assets} and {zip_name_mod} in {self.bb_dir}")

        finally:
            os.chdir(original_cwd)

    def build(self):
        """Main build process"""
        try:
            print("Starting Legends mod build process...")

            # Remove and recreate build directory
            if self.build_dir.exists():
                shutil.rmtree(self.build_dir)
            self.build_dir.mkdir(parents=True)

            # Copy dead assets
            self.copy_dead_assets()

            # Copy directories first (to establish base structure)
            self.copy_directories()

            # Build brushes (which will add legend_armor/legend_helmets to existing scripts)
            self.build_brushes()

            # Create zip archives
            self.create_zip_archives()

            print("Legends mod build completed successfully!")

        except LegendsModBuildError as e:
            print(f"Legends mod build failed: {e}")
            sys.exit(1)
        except Exception as e:
            print(f"Unexpected error: {e}")
            sys.exit(1)


def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(description="Build complete Legends mod")
    parser.add_argument("bb_dir", nargs="?", help="Battle Brothers data directory")
    parser.add_argument(
        "repo_dir",
        nargs="?",
        default="Legends-public",
        help="Repository directory name (default: Legends-public)",
    )
    parser.add_argument(
        "build_dir",
        nargs="?",
        default="./build",
        help="Build directory (default: ./build)",
    )

    args = parser.parse_args()

    builder = LegendsModBuilder(args.bb_dir, args.repo_dir, args.build_dir)
    builder.build()


if __name__ == "__main__":
    main()
