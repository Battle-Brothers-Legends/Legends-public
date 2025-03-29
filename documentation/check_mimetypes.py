import os
import magic
import argparse

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
                                f.write(f"{file_path},{mime_type}\n")
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
    ## magic to be installed with 'pip install python-magic' and 'pip install python-magic-bin'
    ## is run with this command:
    ## python check_mimetypes.py -d gfx unpacked -o mime_results.txt
