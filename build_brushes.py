#!/usr/bin/env python3
"""
OS-agnostic brush building script for Legends mod
Replaces build_brushes.sh with cross-platform Python implementation
"""

import argparse
import hashlib
import re
import shutil
import sys
import time
from concurrent.futures import ProcessPoolExecutor
from pathlib import Path

from buildscript.lib import BrushUtils, CACHE_DIR, load_cache, save_cache, scan_files, file_stamp
from buildscript.python.bbrusher import BBrusher


class BrushBuildError(Exception):
    """Custom exception for brush build errors"""

    pass


class BrushBuilder:
    # these are build as bbrusher would
    PLAIN_BRUSHES = [
        "world_tiles",
        "terrain",
        "legend_detail",
    ]

    # these are using different packaging method for better compression
    BEST_FIT_BRUSHES = [
        "legend_armor",
        "legend_helmets",
        "legend_characters",
        "legend_enemies",
        "legend_weapons",
        "legend_world",
        "legend_horses",
        "legend_ui",
        "legend_objects",
        "legend_effects",
    ]

    def __init__(self, build_dir=None, repo_dir="Legends-public", copy_to_build=True):
        self.current_dir = Path.cwd()
        # build_legends_mod.py packs straight from the repository and does not need copies in the build directory
        self.copy_to_build = copy_to_build

        # Set default build directory
        if build_dir is None:
            build_dir = self.current_dir / "build"

        self.build_dir = Path(build_dir)
        self.repo_dir = repo_dir
        self.brush = BrushUtils(self.current_dir, self.repo_dir)

        print(f"Build directory: {self.build_dir}")
        print(f"Repository directory: {self.repo_dir}")
        print(f"Current directory: {self.current_dir}")

    def handle_exit(self, result, context=""):
        """Handle subprocess exit codes"""
        if result.returncode != 0:
            error_msg = f"Failed to build {context if context else 'brushes'}!"
            print(error_msg)
            if result.stderr:
                print(f"Error output: {result.stderr}")
            raise BrushBuildError(error_msg)

    def check_for_error(self, output, brush_name):
        """Check output for ERROR messages"""
        if "ERROR" in output:
            for line in output.split("\n"):
                print(line)
            raise BrushBuildError(f"Failed to build Legends brush {brush_name}")

    def build_helmets(self):
        """Build helmet scripts and setup directories"""
        print("Building helmets...")

        # Remove and recreate helmet scripts directory
        helmet_scripts_dir = self.current_dir / "helmet_scripts"
        if helmet_scripts_dir.exists():
            shutil.rmtree(helmet_scripts_dir)
        helmet_scripts_dir.mkdir(exist_ok=True)

        # Run helmet generation directly
        from buildscript.python.make_legend_helmets import generate_legend_helmets

        generate_legend_helmets(self.current_dir)

        if not self.copy_to_build:
            return

        build_helmet_dir = self.build_dir / "scripts" / "items" / "legend_helmets"
        build_helmet_dir.mkdir(parents=True, exist_ok=True)

        if helmet_scripts_dir.exists() and any(helmet_scripts_dir.iterdir()):
            # Copy generated helmet scripts, merging with existing structure
            for item in helmet_scripts_dir.iterdir():
                dest_item = build_helmet_dir / item.name
                if item.is_dir():
                    shutil.copytree(item, dest_item, dirs_exist_ok=True)
                else:
                    shutil.copy2(item, dest_item)

    def build_armor(self):
        """Build armor scripts and setup directories"""
        print("Building armors...")

        # Remove and recreate armor scripts directory
        armor_scripts_dir = self.current_dir / "legend_armor_scripts"
        if armor_scripts_dir.exists():
            shutil.rmtree(armor_scripts_dir)
        armor_scripts_dir.mkdir(exist_ok=True)

        # Run armor generation directly
        from buildscript.python.make_legend_armor import generate_legend_armor

        generate_legend_armor(self.current_dir)

        if not self.copy_to_build:
            return

        # Copy armor scripts to build directory
        build_armor_dir = self.build_dir / "scripts" / "items" / "legend_armor"
        build_armor_dir.mkdir(parents=True, exist_ok=True)

        if armor_scripts_dir.exists() and any(armor_scripts_dir.iterdir()):
            # Copy generated armor scripts, merging with existing structure
            for item in armor_scripts_dir.iterdir():
                dest_item = build_armor_dir / item.name
                if item.is_dir():
                    shutil.copytree(item, dest_item, dirs_exist_ok=True)
                else:
                    shutil.copy2(item, dest_item)

    def build_enemies(self):
        """Build enemies"""
        print("Building enemies...")
        from buildscript.python.make_legend_enemies import generate_legend_enemies

        generate_legend_enemies(self.current_dir)

    def copy_brushes_and_gfx(self):
        """Copy brushes and graphics to build directory for packaging"""
        print(f"Copying brushes to {self.build_dir}/brushes ...")

        # Copy brushes to build directory
        build_brushes_dir = self.build_dir / "brushes"
        build_brushes_dir.mkdir(parents=True, exist_ok=True)

        local_brushes_dir = self.current_dir / "brushes"
        if local_brushes_dir.exists() and any(local_brushes_dir.iterdir()):
            shutil.copytree(local_brushes_dir, build_brushes_dir, dirs_exist_ok=True)

        print(f"Copying gfx files to {self.build_dir}/gfx ...")

        # Copy gfx files to build directory
        build_gfx_dir = self.build_dir / "gfx"
        build_gfx_dir.mkdir(parents=True, exist_ok=True)

        local_gfx_dir = self.current_dir / "gfx"
        if local_gfx_dir.exists():
            for png_file in local_gfx_dir.glob("*.png"):
                shutil.copy2(png_file, build_gfx_dir)

    def fingerprint(self, brush_name):
        """Hash of everything a brush is packed from. So the names, sizes and modification times of its images, its metadata and the packer itself, etc."""
        digest = hashlib.sha1()
        packer_dir = Path(__file__).resolve().parent / "buildscript" / "python" / "bbrusher"

        for file in sorted(packer_dir.glob("*.py")):
            digest.update(file.read_bytes())

        for rel_path, entry in scan_files(self.current_dir / "unpacked" / brush_name):
            if entry.name == "metadata.xml":
                digest.update(Path(entry.path).read_bytes())
            else:
                # the images are not opened cuz reading all of them takes almost as long as packing them
                digest.update(f"{rel_path}|{file_stamp(entry)}\n".encode())

        return digest.hexdigest()

    def brush_outputs(self, brush_name):
        """The .brush files of a brush and the atlas PNGs they use relative to the repo"""
        outputs = []
        pattern = re.compile(re.escape(brush_name) + r"(_\d+)?\.brush")

        for brush_file in sorted((self.current_dir / "brushes").glob(f"{brush_name}*.brush")):
            if pattern.fullmatch(brush_file.name):
                outputs.append(f"brushes/{brush_file.name}")
                try:
                    outputs.append(BBrusher.read_brush(brush_file.read_bytes()).img_name)
                except Exception:
                    # a broken brush file, like from an interrupted build, has no atlas to speak of
                    pass

        return outputs

    def build_all_brushes(self):
        """Build the brushes, skipping the ones that did not change since they were last built"""
        brushes_dir = self.current_dir / "brushes"
        cache = load_cache(self.current_dir, "brushes") if brushes_dir.exists() else {}

        if not cache:
            # Nothing is known about what is already there, so start from scratch
            if brushes_dir.exists():
                shutil.rmtree(brushes_dir)
            for png in (self.current_dir / "gfx").glob("*.png"):
                png.unlink()
        brushes_dir.mkdir(exist_ok=True)

        start = time.time()
        all_brushes = self.PLAIN_BRUSHES + self.BEST_FIT_BRUSHES
        fingerprints = {brush_name: self.fingerprint(brush_name) for brush_name in all_brushes}

        def is_up_to_date(brush_name):
            entry = cache.get(brush_name)
            return (
                entry is not None
                and entry["fingerprint"] == fingerprints[brush_name]
                and all((self.current_dir / output).exists() for output in entry["outputs"])
            )

        changed = [brush_name for brush_name in all_brushes if not is_up_to_date(brush_name)]
        print(f"Building {len(changed)} of {len(all_brushes)} brushes" + (", the others did not change" if len(changed) < len(all_brushes) else ""))

        # Forget the changed brushes and delete what they produced last time, as the number of their sheets can change
        for brush_name in changed:
            for output in cache.pop(brush_name, {}).get("outputs", []) + self.brush_outputs(brush_name):
                (self.current_dir / output).unlink(missing_ok=True)
        save_cache(self.current_dir, "brushes", cache)

        try:
            for brush_names, build_brush in [
                (self.PLAIN_BRUSHES, self.brush.build_brush),
                (self.BEST_FIT_BRUSHES, self.brush.build_brush_best_fit),
            ]:
                brush_names = [brush_name for brush_name in brush_names if brush_name in changed]
                if not brush_names:
                    continue

                with ProcessPoolExecutor() as executor:
                    list(executor.map(build_brush, brush_names))

                for brush_name in brush_names:
                    cache[brush_name] = {
                        "fingerprint": fingerprints[brush_name],
                        "outputs": self.brush_outputs(brush_name),
                    }
        finally:
            save_cache(self.current_dir, "brushes", cache)

        print("Elapsed build brush", time.time() - start)

    def build(self):
        """Main build process"""
        try:
            print("Starting brush build process...")

            # Build scripts first
            self.build_helmets()
            self.build_armor()
            self.build_enemies()

            # Build all brushes
            self.build_all_brushes()

            # Copy brushes and assets to build directory for packaging
            if self.copy_to_build:
                self.copy_brushes_and_gfx()

            print("Brush build completed successfully!")

        except BrushBuildError as e:
            print(f"Brush build failed: {e}")
            sys.exit(1)
        except Exception as e:
            print(f"Unexpected error: {e}")
            sys.exit(1)


def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(description="Build brushes for Legends mod")
    parser.add_argument(
        "build_dir", nargs="?", help="Build directory (default: ./build)"
    )
    parser.add_argument(
        "repo_dir",
        nargs="?",
        default="Legends-public",
        help="Repository directory name (default: Legends-public)",
    )
    parser.add_argument(
        "--full",
        action="store_true",
        help="Forget what earlier builds did and build everything again",
    )

    args = parser.parse_args()

    if args.full:
        shutil.rmtree(Path.cwd() / CACHE_DIR, ignore_errors=True)

    builder = BrushBuilder(args.build_dir, args.repo_dir)
    builder.build()


if __name__ == "__main__":
    main()
