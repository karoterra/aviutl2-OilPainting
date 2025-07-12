# /// script
# requires-python = ">=3.13"
# ///

from pathlib import Path
import subprocess


def main():
    dist_dir = Path("publish")
    dist_dir.mkdir(exist_ok=True)

    dist_path = dist_dir / "aviutl2-OilPainting.zip"

    subprocess.run(["7z", "a", dist_path, "README.md", "LICENSE", ".\\build\\油絵KR.anm2"], check=True)


if __name__ == "__main__":
    main()
