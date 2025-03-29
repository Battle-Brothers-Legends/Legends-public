import os
import magic
import argparse
import io
from PIL import Image, ImageCms

def print_mime_types(directories, output_file):
    try:
        with open(output_file, 'w') as f:
            for directory in directories:
                if os.path.exists(directory) and os.path.isdir(directory):
                    for root, dirs, files in os.walk(directory):
                        for file in files:
                            file_path = os.path.join(root, file)
                            mime_type = magic.from_file(file_path, mime=True)
                            if mime_type is None:
                                f.write(f"No mime type for file: {file_path}\n")
                            else:
                                f.write(f"{file_path},{mime_type}")
                                if mime_type == "image/png":
                                    try:
                                        with Image.open(file_path) as img:
                                            if "icc_profile" in img.info:
                                                icc_profile = ImageCms.ImageCmsProfile(io.BytesIO(img.info["icc_profile"]))
                                                try:
                                                    f.write(f", {icc_profile.tobytes().decode('utf-8')}\n")
                                                except UnicodeEncodeError as e:
                                                    f.write(f", Error decoding ICC profile: {e}\n")
                                            else:
                                                f.write(", No ICC profile\n")
                                    except Exception as e:
                                        f.write(f", Error reading ICC profile: {e}\n")
                                else:
                                    f.write("\n")
                else:
                    print(f"Directory does not exist or is not a directory: {directory}")
    except PermissionError:
        print(f"Permission denied when trying to write to file: {output_file}")
    except Exception as e:
        print(f"An error occurred: {e}")

def main():
    parser = argparse.ArgumentParser(description='Find MIME types of files in directories.')
    parser.add_argument('-d', '--directories', nargs='+', required=True, help='List of directories to scan')
    parser.add_argument('-o', '--output', required=True, help='Output file to write results')
    args = parser.parse_args()

    print_mime_types(args.directories, args.output)

if __name__ == "__main__":
    main()

    ## magic to be installed with 'pip install python-magic'
    ## is run with this command:
    ## python check_colour_profile.py -d gfx unpacked -o color_profile_results.txt
