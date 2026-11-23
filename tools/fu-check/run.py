#!/usr/bin/env python3
"""Run FU regression checks with a supplied Squirrel 3 source tree, offline."""
import argparse
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[2]


def run(*args):
    subprocess.run([str(a) for a in args], cwd=ROOT, check=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--squirrel-source", required=True, type=Path,
                        help="Tree containing include/squirrel.h and src/{squirrel,sqstdlib}")
    args = parser.parse_args()
    source = args.squirrel_source.resolve()
    build = ROOT / "build/fu-check"
    build.mkdir(parents=True, exist_ok=True)
    runner = build / "squirrel"
    inputs = [ROOT / "tools/fu-check/runner.cpp",
              *sorted((source / "src/squirrel").glob("*.cpp")),
              *sorted((source / "src/sqstdlib").glob("*.cpp"))]
    if not (source / "include/squirrel.h").exists() or len(inputs) < 3:
        parser.error("Squirrel source tree is incomplete")
    if not runner.exists() or any(p.stat().st_mtime > runner.stat().st_mtime for p in inputs):
        run("g++", "-std=c++11", "-O1", "-fpermissive", "-w", "-I" + str(source / "include"),
            *inputs, "-o", runner)
    nuts = sorted((ROOT / "scripts/fu").rglob("*.nut"))
    nuts += sorted((ROOT / "scripts/mods/FU").glob("*.nut"))
    nuts += [ROOT / "scripts/!mods_preload/!!a_fu_preload.nut"]
    run(runner, "--compile", *nuts)
    print(f"Squirrel syntax: {len(nuts)} files passed", flush=True)
    run(runner, ROOT / "tools/fu-check/runtime.nut")
    for path in sorted((ROOT / "ui/mods/fu").rglob("*.js")):
        run("node", "--check", path)
    run("node", ROOT / "tools/fu-check/ui.cjs")


if __name__ == "__main__":
    main()
