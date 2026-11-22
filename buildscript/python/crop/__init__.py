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
    @staticmethod
    def cropCached(path, targetPath, cache, key):
        """Does what crop() does and returns what getBounds() returns, but an image that did not change since it was last cropped is not opened again"""
        stat = os.stat(path)
        stamp = [stat.st_size, stat.st_mtime_ns]
        entry = cache.get(key)
        if entry is None or entry[0] != stamp or not os.path.exists(targetPath):
            CropTool.crop(path, targetPath)
            entry = [stamp, list(CropTool.getBounds(path))]
            cache[key] = entry
        return entry[1]
