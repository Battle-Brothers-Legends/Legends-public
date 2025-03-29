import argparse
import os
from PIL import Image

def check_images(directory, output_file):
    with open(output_file, 'w') as f:
        # loop over all files in the directory
        for foldername, subfolders, filenames in os.walk(directory):
            for filename in filenames:
                # only check files that have an image file extension
                if filename.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.bmp', '.ico', '.emf', '.wmf')):
                    try:
                        # attempt to open and load the image
                        filepath = os.path.join(foldername, filename)
                        img = Image.open(filepath)
                        img.verify()  # verify that it is, in fact an image
                    except (IOError, SyntaxError) as e:
                        f.write(f'Bad file: {filepath}\n')  # write out the names of corrupt or unsupported files

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Check images for compatibility with GDI+.")
    parser.add_argument("-d", "--directories", nargs="+", required=True, help="One or more directories to check.")
    parser.add_argument("-o", "--output", required=True, help="Output file to store the results.")
    args = parser.parse_args()

    for directory in args.directories:
        if os.path.exists(directory):
            check_images(directory, args.output)
        else:
            print(f"Directory does not exist: {directory}")
    ## magic to be installed with 'pip install python-magic'
    ## is run with this command:
    ## python check_mimetypes2.py -d gfx unpacked -o bad_images_results.txt
