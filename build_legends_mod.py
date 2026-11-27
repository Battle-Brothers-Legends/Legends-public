#!/usr/bin/env python3
"""
OS-agnostic main build script for Legends mod
Replaces build_legends_mod.sh with cross-platform Python implementation
"""

import os
import sys
import time
import shutil
import hashlib
import argparse
from pathlib import Path
import platform
from buildscript.lib import VersionExtractor, BuildError, load_config, CACHE_DIR, load_cache, save_cache, scan_files, file_stamp

class LegendsModBuilder:
    # What goes into each archive
    # A later directory wins when two have the same file, so the generated scripts replace leftovers in scripts
    MOD_SOURCES = [
        ("mod_legends", "mod_legends"),
        ("scripts", "scripts"),
        ("helmet_scripts", "scripts/items/legend_helmets"),
        ("legend_armor_scripts", "scripts/items/legend_armor"),
        ("ui", "ui"),
    ]

    ASSETS_SOURCES = [
        ("brushes", "brushes"),
        ("gfx", "gfx"),
        ("sounds", "sounds"),
        ("preload", "preload"),
    ]

    def __init__(self, bb_dir=None, repo_dir=None, build_dir=None):
        # Load config first
        config = load_config(Path(__file__).parent / ".build_config.py")

        # Use provided values, fall back to config, then to defaults
        if repo_dir is None:
            repo_dir = config.REPO_DIR
        if build_dir is None:
            build_dir = config.BUILD_DIR
        if bb_dir is None:
            bb_dir = config.BB_DIR

        # Set default paths based on OS if still None
        if bb_dir is None:
            if platform.system() == "Windows":
                bb_dir = r"c:\Steam\steamapps\common\Battle Brothers\data"
            else:
                bb_dir = os.path.expanduser(
                    "~/.local/share/Steam/steamapps/common/Battle Brothers/data"
                )

        self.bb_dir = Path(bb_dir)
        self.repo_dir = repo_dir
        self.build_dir = Path(build_dir)
        self.current_dir = Path.cwd()
        self.version_extractor = VersionExtractor(self.current_dir)

        print(f"Battle Brothers directory: {self.bb_dir}")
        print(f"Repository directory: {self.repo_dir}")
        print(f"Build directory: {self.build_dir}")
        print(f"Current directory: {self.current_dir}")

    def prebuild_cleanup(self):
        """Clean up generated folders and PNGs before building"""
        try:
            # Remove generated directories
            # The brushes and their PNGs in gfx are kept so the brush builder only replaces the ones that changed
            for rel in [
                "build",
                "helmet_scripts",
                "legend_armor_scripts",
            ]:
                p = self.current_dir / rel
                if p.exists():
                    print(f"Deleting {p} ...")
                    shutil.rmtree(p, ignore_errors=True)

            # Remove gfx/ui PNGs
            gfx_ui_dir = self.current_dir / "gfx" / "ui"
            if gfx_ui_dir.exists():
                for png in gfx_ui_dir.glob("*.png"):
                    try:
                        print(f"Deleting {png} ...")
                        png.unlink()
                    except Exception:
                        pass

        except Exception as e:
            print(f"Warning: cleanup error {e}")


    def build_assets_script(self):
        """Build asset mod script dynamically"""
        assets_version = self.version_extractor.get_legends_assets_version()
        script_content = f"""::LegendsAssets <- {{
    ID = "mod_legends_assets",
    Version = "{assets_version}",
    Name = "Legends assets"
}};
::mods_registerMod(::LegendsAssets.ID, ::LegendsAssets.Version, ::LegendsAssets.Name);"""
        return script_content

    def artifact_name_mod(self):
        """Generate mod artifact name"""
        version = self.version_extractor.extract_version()
        return f"mod_legends-{version}.zip"

    def artifact_name_assets(self):
        """Generate assets artifact name"""
        assets_version = self.version_extractor.get_legends_assets_version()
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
        from build_brushes import BrushBuilder
        BrushBuilder(str(self.build_dir), self.repo_dir, copy_to_build=False).build()

    def collect_files(self, sources):
        """Every file of the given source directories by its name inside the archive"""
        files = {}
        for src_name, arc_dir in sources:
            for rel_path, entry in scan_files(self.current_dir / src_name):
                files[f"{arc_dir}/{rel_path}"] = entry
        return files

    def write_zip(self, zip_name, files, extra_files={}):
        import zipfile

        zip_path = self.build_dir / zip_name
        with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as zf:
            for arc_name in sorted(files):
                zf.write(files[arc_name].path, arc_name)
            for arc_name, content in extra_files.items():
                zf.writestr(arc_name, content)

        shutil.move(zip_path, self.bb_dir / zip_name)
        print(f"Created {zip_name} in {self.bb_dir}")

    def create_mod_zip(self):
        """Create the mod archive with the scripts and the ui"""
        self.write_zip(self.artifact_name_mod(), self.collect_files(self.MOD_SOURCES))

    def create_assets_zip(self):
        zip_name = self.artifact_name_assets()
        zip_path = self.bb_dir / zip_name
        files = self.collect_files(self.ASSETS_SOURCES)
        script = self.build_assets_script()

        digest = hashlib.sha1(script.encode())
        for arc_name in sorted(files):
            digest.update(f"{arc_name}|{file_stamp(files[arc_name])}\n".encode())

        def state():
            return {"fingerprint": digest.hexdigest(), "zip": zip_name, "stamp": file_stamp(zip_path)}

        if zip_path.exists() and load_cache(self.current_dir, "assets") == state():
            print(f"Skipping {zip_name}, none of its {len(files)} files changed")
            return

        self.write_zip(zip_name, files, {"scripts/!mods_preload/mod_legends_assets.nut": script})
        save_cache(self.current_dir, "assets", state())

    def timed(self, label, step):
        """Just my testing to see how much faster it was (p.s. it's much faster)"""
        start = time.time()
        step()
        print(f"{label} took {time.time() - start:.1f}s")

    def build(self, full=False):
        """Main build process"""
        try:
            print("Starting Legends mod build process...")
            start = time.time()

            if full:
                # Forget what earlier builds did, so everything is built again
                shutil.rmtree(self.current_dir / CACHE_DIR, ignore_errors=True)

            # Build cleanup to ensure a fresh state
            self.timed("Cleanup", self.prebuild_cleanup)

            # The build directory only holds the archives while they are written
            self.build_dir.mkdir(parents=True, exist_ok=True)

            # Copy dead assets
            self.copy_dead_assets()

            # Generate the helmet and armor scripts and build the brushes that changed
            self.timed("Brushes and generated scripts", self.build_brushes)

            # Create zip archives
            self.timed("Mod archive", self.create_mod_zip)
            self.timed("Assets archive", self.create_assets_zip)

            print(f"Legends mod build completed successfully in {time.time() - start:.1f}s!")

        except BuildError as e:
            print(f"Legends mod build failed: {e}")
            sys.exit(1)
        except Exception as e:
            print(f"Unexpected error: {e}")
            sys.exit(1)


def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(description="Build complete Legends mod")
    parser.add_argument(
        "bb_dir",
        nargs="?",
        help="Battle Brothers data directory (default: from .build_config.py or auto-detect)",
    )
    parser.add_argument(
        "repo_dir",
        nargs="?",
        help="Repository directory name (default: from .build_config.py or 'Legends-public')",
    )
    parser.add_argument(
        "build_dir",
        nargs="?",
        help="Build directory (default: from .build_config.py or './build')",
    )
    parser.add_argument(
        "--full",
        action="store_true",
        help="Forget what earlier builds did and build everything again",
    )

    args = parser.parse_args()

    builder = LegendsModBuilder(args.bb_dir, args.repo_dir, args.build_dir)
    builder.build(args.full)


if __name__ == "__main__":
    main()
