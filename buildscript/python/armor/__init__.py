from .templates import Templates
from .defs import Defs

import os, shutil

def cleanupDirs(parent_dir):
    for item in os.listdir(parent_dir):
        item_path = os.path.join(parent_dir, item)
        if os.path.isdir(item_path) and item.isdigit():
            try:
                shutil.rmtree(item_path)  # Remove the directory and all its contents
            except e:
                print(f"Error removing {item_path}: {e}")