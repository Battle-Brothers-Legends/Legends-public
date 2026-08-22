from wiki.background_generator import BackgroundGenerator
from pathlib import Path

import argparse
import os

def process_file(file_path: Path, transformer, output_path: Path | None = None) -> str | None:
	try:
		with open(file_path, 'r', encoding='utf-8') as file:
			source_code = file.read()
			print(f"Validating file: {file_path}")
			result = transformer(source_code)

			# Save to output file if generated successfully
			if result and output_path:
				output_path.parent.mkdir(parents=True, exist_ok=True)
				with open(output_path, 'w', encoding='utf-8') as out_file:
					out_file.write(result)
				print(f"Successfully saved output to: {output_path}")

			return result

	except FileNotFoundError:
		print(f"File {file_path} not found!")
		return None
	except UnicodeDecodeError:
		print(f"Encoding error reading {file_path}")
		return None


if __name__ == "__main__":
	ROOT_DIR = Path(__file__).resolve().parent.parent.parent

	BackgroundGenerator(ROOT_DIR, "wiki").process()
