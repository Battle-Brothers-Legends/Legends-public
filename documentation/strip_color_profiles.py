import os
from PIL import Image
import argparse

def remove_icc_profiles(directories):
    for directory in directories:
        if os.path.exists(directory) and os.path.isdir(directory):
            for root, dirs, files in os.walk(directory):
                for file in files:
                    try:
                        image_path = os.path.join(root, file)
                        with Image.open(image_path) as img:
                            # Remove the ICC profile
                            img.info.pop('icc_profile', None)
                            # Overwrite the existing image
                            img.save(image_path)
                    except Exception as e:
                        print(f"Failed to process file {file}. Error: {e}")
        else:
            print(f"Directory does not exist or is not a directory: {directory}")

def main():
    parser = argparse.ArgumentParser(description='Remove ICC profiles from images in directories.')
    parser.add_argument('-d', '--directories', nargs='+', required=True, help='List of directories to scan')
    args = parser.parse_args()

    remove_icc_profiles(args.directories)

if __name__ == "__main__":
    main()
    
    ##python strip_color_profiles.py -d gfx unpacked