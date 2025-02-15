import os
from PIL import Image


class CropTool:
    @staticmethod
    def getBounds(path):
        img = Image.open(path)
        img = img.convert("RGBA")
        bbox = img.getbbox()
        if bbox:
            left, top, right, bottom = bbox
            return left, img.width - right, top, img.height - bottom
        else:
            return 0, 0, 0, 0
    @staticmethod
    def crop(path, targetPath):
        os.makedirs(os.path.dirname(targetPath), exist_ok=True)
        img = Image.open(path)
        img = img.convert("RGBA")
        bbox = img.getbbox()
        img = img.crop(bbox)
        img.save(targetPath, 'PNG')
