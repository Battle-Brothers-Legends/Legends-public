#!/usr/bin/env python3
"""
Convert a Tiled JSON map (hex) + tileset JSON into a Squirrel tactical template (.nut).

MVP assumptions:
- Base terrain is taken from the layer named "height 0" (fallback).
- Elevation is computed as the maximum N where layer name == "height N" has a non-zero gid at (x,y).
- Terrain variants recognized by tileset image names: grass_01 -> grass1, grass_02 -> grass2, earth_01 -> earth1.
- Unknown tiles default to grass1.

Usage:
  python tools/tiled_to_nut.py tileset/testmap.json tileset/Terrain.json \
    --name tactical.hills_mvp \
    --out templates/tactical/locations/tactical_hills_mvp.nut

Notes:
- This writes a self-contained .nut file; the engine does not parse JSON at runtime.
"""
from __future__ import annotations
import argparse
import json
import os
import sys
import xml.etree.ElementTree as ET


def load_json(path: str):
    with open(path, 'r', encoding='utf-8') as f:
        return json.load(f)


def basename_noext(p: str) -> str:
    return os.path.splitext(os.path.basename(p))[0]


def _normalize_family_number(base: str, num: str | int | None) -> str:
    """Normalize a family+number to a canonical key supported by MapGen.

    - Maps aliases like 'legend_desert' -> 'desert'.
    - Clamps numbers to known ranges to avoid non-existent templates.
    """
    alias = {
        'legend_desert': 'desert',
    }
    fam = alias.get(base, base)
    limits = {
        'grass': 2,
        'earth': 2,
        'forest': 2,
        'stone': 3,
        'steppe': 5,
        'swamp': 5,
        'swampgreen': 5,
        'swampforest': 5,
        'tundra': 5,
        'autumn': 2,
        'moss': 2,
        'snow': 4,
        'desert': 7,
    }
    if num is None or num == '':
        return fam
    try:
        n = int(num)
    except Exception:
        return fam
    limit = limits.get(fam)
    if limit is not None:
        if n < 1:
            n = 1
        if n > limit:
            n = limit
    return f"{fam}{n}"


def id_to_key(id_str: str) -> str | None:
    s = id_str.lower()
    if s.startswith('tile_'):
        s = s[5:]
    if s.startswith('socket_'):
        return None
    # Skip overlays / non-base terrain
    if s.startswith('zone_') or s in ('inside', 'tile_inside', 'forest_light'):
        return None
    # Normalize road variants to vanilla 'road' tile template
    if s in ('road', 'road_dirt', 'tile_road', 'tile_road_dirt'):
        return 'road'
    s = s.replace('swamp_green', 'swampgreen')
    s = s.replace('swamp_forest', 'swampforest')
    base, num = s, ''
    if '_' in s:
        parts = s.rsplit('_', 1)
        if len(parts) == 2 and parts[1].isdigit():
            base, num = parts[0], parts[1]
    key = _normalize_family_number(base, num)
    fam = key
    for prefix in (
        'grass', 'earth', 'snow', 'desert', 'tundra', 'autumn', 'moss', 'forest',
        'stone', 'steppe', 'swamp', 'swampgreen', 'swampforest', 'legend_cave',
        'desert7_oasis', 'road',
    ):
        if fam.startswith(prefix):
            return key
    return None


def build_metadata_map(meta_xml_path: str | None) -> dict[str, str]:
    """Return a map from image basename -> canonical tile key using metadata.xml.
    Keys are lowercase basenames (e.g., 'grass_01'). Values like 'grass1'.
    """
    if not meta_xml_path or not os.path.isfile(meta_xml_path):
        return {}
    try:
        tree = ET.parse(meta_xml_path)
        root = tree.getroot()
    except Exception:
        return {}
    mapping: dict[str, str] = {}
    for spr in root.findall('.//sprite'):
        img = spr.attrib.get('img', '')
        sid = spr.attrib.get('id', '')
        if not img or not sid:
            continue
        base = basename_noext(img).lower().replace('\\', '/').split('/')[-1]
        key = id_to_key(sid)
        if key:
            mapping[base] = key
    return mapping


def build_combined_metadata_map(paths: list[str]) -> dict[str, str]:
    combined: dict[str, str] = {}
    for p in paths:
        m = build_metadata_map(p)
        if m:
            combined.update(m)
    return combined


def build_spriteid_map(meta_xml_path: str | None) -> dict[str, str]:
    """Map image basename -> raw sprite id from metadata.xml (no normalization)."""
    if not meta_xml_path or not os.path.isfile(meta_xml_path):
        return {}
    try:
        tree = ET.parse(meta_xml_path)
        root = tree.getroot()
    except Exception:
        return {}
    mapping: dict[str, str] = {}
    for spr in root.findall('.//sprite'):
        img = spr.attrib.get('img', '')
        sid = spr.attrib.get('id', '')
        if not img or not sid:
            continue
        base = basename_noext(img).lower().replace('\\', '/').split('/')[-1]
        mapping[base] = sid
    return mapping


def build_combined_spriteid_map(paths: list[str]) -> dict[str, str]:
    combined: dict[str, str] = {}
    for p in paths:
        m = build_spriteid_map(p)
        if m:
            combined.update(m)
    return combined


def classify_tile_name(img_path: str, meta_map: dict[str, str] | None = None) -> str | None:
    """Map a tileset image filename to an internal tactical tile key used by MapGen.

    Strategy: parse the basename, normalize prefixes and underscores, and build
    keys like 'grass1', 'earth2', 'snow3', 'desert7', 'tundra4', 'autumn3',
    'moss2', 'forest1', 'stone1', 'steppe5', 'swamp1', 'swampgreen2', 'swampforest3'.

    Returns None for sockets/unsupported placeholders so caller can decide.
    """
    name = basename_noext(img_path).lower().replace('\\', '/').split('/')[-1]
    # strip common prefixes
    if name.startswith('tile_'):
        name = name[5:]
    # ignore sockets and roads here (not terrain base)
    if name.startswith('socket_'):
        return None
    # Try metadata-derived key first (authoritative)
    if meta_map is not None:
        mm_key = meta_map.get(name)
        if mm_key is not None:
            # Normalize family+number (e.g., legend_desert15 -> desert7)
            if '_' in mm_key:
                parts = mm_key.rsplit('_', 1)
                if len(parts) == 2 and parts[1].isdigit():
                    base, num = parts[0], parts[1]
                    return _normalize_family_number(base, num)
            # Already normalized (e.g., desert7)
            return _normalize_family_number(mm_key, None)
    # Fallback to filename-based classification
    # Normalize special composites
    name = name.replace('swamp_green', 'swampgreen')
    name = name.replace('swamp_forest', 'swampforest')

    # If ends with _<number>, split
    base, num = name, ''
    if '_' in name:
        parts = name.rsplit('_', 1)
        if len(parts) == 2 and parts[1].isdigit():
            base, num = parts[0], parts[1]
    # Accept already-formed names like 'desert7_oasis'
    if num:
        key = _normalize_family_number(base, num)
    else:
        key = _normalize_family_number(base, None)

    # Final whitelist of known families; otherwise return None to skip
    fam = key
    # Normalize some special cases to vanilla names
    if fam.startswith('road_'):
        fam = 'road'
        key = 'road'
    # Skip UI/overlay placeholders
    if fam.startswith('zone_') or key == 'tile_inside' or key == 'inside' or key == 'forest_light':
        return None
    for prefix in (
        'grass', 'earth', 'snow', 'desert', 'tundra', 'autumn', 'moss', 'forest',
        'stone', 'steppe', 'swamp', 'swampgreen', 'swampforest', 'legend_cave',
        'desert7_oasis', 'road',
    ):
        if fam.startswith(prefix):
            return key
    # Fallback to metadata-derived key if available
    if meta_map and name in meta_map:
        return meta_map[name]
    return None


def build_gid_to_img(tileset_json: dict, firstgid: int) -> dict[int, str]:
    gid_to_img: dict[int, str] = {}
    for t in tileset_json.get('tiles', []):
        tid = t.get('id')
        img = t.get('image')
        if isinstance(tid, int) and img:
            gid = firstgid + tid
            gid_to_img[gid] = img
    return gid_to_img


def build_gid_to_img_from_map(map_json: dict, map_dir: str) -> dict[int, str]:
    """Build a combined gid->image map for all tilesets referenced by the map."""
    combined: dict[int, str] = {}
    for ts in map_json.get('tilesets', []):
        firstgid = int(ts.get('firstgid', 1))
        src = ts.get('source')
        if not src:
            continue
        ts_path = os.path.join(map_dir, src)
        base = os.path.basename(ts_path)
        # If TSX, try .tsj next to it
        if base.lower().endswith('.tsx'):
            tsj_candidate = os.path.splitext(ts_path)[0] + '.tsj'
            if os.path.isfile(tsj_candidate):
                ts_path = tsj_candidate
        try:
            ts_json = load_json(ts_path)
        except Exception:
            continue
        combined.update(build_gid_to_img(ts_json, firstgid))
    return combined


def extract_layers(map_json: dict) -> tuple[list[dict], list[tuple[int, list[int]]]]:
    """Return (layers, height_layers_by_level).
    height_layers_by_level is a list of (level, data[]) sorted ascending by level.

    Accepts case-insensitive names and common separators, e.g. "Height_2", "height 2", "height2".
    """
    layers = map_json.get('layers', [])
    height_layers: list[tuple[int, list[int]]] = []
    for layer in layers:
        name = layer.get('name', '')
        if not isinstance(name, str):
            continue
        lname = name.lower()
        if lname.startswith('height'):
            suffix = lname[len('height'):]
            suffix = suffix.replace('_', ' ').strip()
            level = 0
            if suffix:
                try:
                    level = int(suffix.split()[0])
                except Exception:
                    level = 0
            data = layer.get('data')
            if isinstance(data, list):
                height_layers.append((level, data))
    height_layers.sort(key=lambda x: x[0])
    return layers, height_layers


def to_grid(data: list[int], width: int, height: int) -> list[list[int]]:
    return [data[y*width:(y+1)*width] for y in range(height)]


def compute_height_grid(height_layers: list[tuple[int, list[int]]], width: int, height: int) -> list[list[int]]:
    grid = [[0 for _ in range(width)] for _ in range(height)]
    for level, data in height_layers:
        if not data:
            continue
        layer_grid = to_grid(data, width, height)
        for y in range(height):
            row = layer_grid[y]
            for x in range(width):
                gid = row[x]
                if gid and level > grid[y][x]:
                    grid[y][x] = level
    return grid


def compute_terrain_index_grid_from_gid_grid(gid_grid: list[list[int]], width: int, height: int, gid_to_img: dict[int, str], meta_map: dict[str, str] | None = None):
    """Build (grid, keys): grid[y][x] is small int code; keys[index] -> tile key string.

    Code 0 means no tile. Indexing starts at 1 for the first discovered key.
    """
    # Discover keys in order of appearance for deterministic indices
    keys: list[str] = [None]  # index 0 is placeholder
    key_to_index: dict[str, int] = {}
    grid = [[0 for _ in range(width)] for _ in range(height)]
    for y in range(height):
        for x in range(width):
            gid = gid_grid[y][x]
            if gid == 0:
                continue
            img = gid_to_img.get(gid, '')
            key = classify_tile_name(img, meta_map) if img else None
            if key is None:
                # Fallback for present but unclassified tiles: default to grass1
                key = 'grass1'
            idx = key_to_index.get(key)
            if idx is None:
                keys.append(key)
                idx = len(keys) - 1
                key_to_index[key] = idx
            grid[y][x] = idx
    return grid, keys


def compute_terrain_gid_grid(width: int, height: int, height_layers: list[tuple[int, list[int]]], base_layer_data: list[int] | None) -> list[list[int]]:
    """Choose a representative terrain GID per cell.
    Preference: topmost height layer (highest level) with non-zero GID.
    Fallback: base layer data (typically 'height 0').
    """
    gid_grid = [[0 for _ in range(width)] for _ in range(height)]
    # Check height layers descending by level
    for level, data in sorted(height_layers, key=lambda x: x[0], reverse=True):
        if not data:
            continue
        layer = to_grid(data, width, height)
        for y in range(height):
            for x in range(width):
                if gid_grid[y][x] == 0 and layer[y][x] != 0:
                    gid_grid[y][x] = layer[y][x]
    # Fallback to base layer where still zero
    if base_layer_data:
        base_grid = to_grid(base_layer_data, width, height)
        for y in range(height):
            for x in range(width):
                if gid_grid[y][x] == 0:
                    gid_grid[y][x] = base_grid[y][x]
    return gid_grid


def compute_object_grid(layers: list[dict], width: int, height: int, gid_to_img: dict[int, str], object_spriteid_map: dict[str, str]) -> tuple[list[list[int]], list[str]]:
    """Aggregate object layers named like 'Object_*' into a single grid.
    Returns (grid, sprite_ids), where grid[y][x] indexes into sprite_ids (0 = none).
    Later layers override earlier ones.
    """
    grid = [[0 for _ in range(width)] for _ in range(height)]
    sprite_ids: list[str] = [None]
    sprite_to_index: dict[str, int] = {}
    for layer in layers:
        if layer.get('type') != 'tilelayer':
            continue
        lname = str(layer.get('name', '')).lower()
        if not lname.startswith('object'):
            continue
        data = layer.get('data')
        if not isinstance(data, list):
            continue
        # Iterate cells
        for y in range(height):
            for x in range(width):
                gid = data[y * width + x]
                if gid == 0:
                    continue
                img = gid_to_img.get(gid)
                if not img:
                    continue
                base = basename_noext(img).lower().replace('\\', '/').split('/')[-1]
                sprite_id = object_spriteid_map.get(base) or base
                idx = sprite_to_index.get(sprite_id)
                if idx is None:
                    sprite_ids.append(sprite_id)
                    idx = len(sprite_ids) - 1
                    sprite_to_index[sprite_id] = idx
                grid[y][x] = idx
    return grid, sprite_ids


def write_nut(out_path: str, name: str, width: int, height: int, terrain_grid: list[list[int]], height_grid: list[list[int]], terrain_keys: list[str], object_grid: list[list[int]] | None = None, object_keys: list[str] | None = None, object_entity_map: dict[str, str] | None = None):
    out_dir = os.path.dirname(out_path)
    if out_dir:
        os.makedirs(out_dir, exist_ok=True)
    with open(out_path, 'w', encoding='utf-8') as f:
        w = f.write
        # Class symbol: match the output filename without extension so this.new(<script_path>) returns the instance
        obj_name = basename_noext(out_path).lower().replace('.', '_')
        w('this.{name} <- this.inherit("scripts/mapgen/tactical_template", {{\n'.format(name=obj_name))
        w('\tm = {},\n')
        w('\tfunction init()\n\t{\n')
        w('\t\tthis.m.Name = "{name}";\n'.format(name=name))
        w('\t\tthis.m.MinX = {w}; this.m.MaxX = {w};\n'.format(w=width))
        w('\t\tthis.m.MinY = {h}; this.m.MaxY = {h};\n'.format(h=height))
        w('\t}\n\n')
        # Implement vanilla-style onFirstPass; parent fill() will call this
        w('\tfunction onFirstPass( _rect )\n\t{\n')
        # Emit a helper to instantiate tiles directly by script path
        w('\t\tlocal function GetTile(_id)\n')
        w('\t\t{\n')
        w('\t\t\tlocal prefix = "tactical.tile.";\n')
        w('\t\t\tlocal path = null;\n')
        w('\t\t\tif (_id.find(prefix) == 0) path = "scripts/mapgen/templates/tactical/tiles/" + _id.slice(prefix.len());\n')
        w('\t\t\telse path = _id;\n')
        w('\t\t\tlocal inst = null;\n')
        w('\t\t\ttry { inst = this.new(path); } catch(e) { inst = null; }\n')
        w('\t\t\tif (inst != null && ("init" in inst)) inst.init();\n')
        w('\t\t\treturn inst;\n')
        w('\t\t}\n')
        # Emit tile objects array indexed by code
        w('\t\tlocal Tiles = [ null')
        for i, key in enumerate(terrain_keys):
            if i == 0:
                continue
            w(', GetTile("tactical.tile.{k}")'.format(k=key))
        w(' ];\n')
        # Emit terrain map
        w('\t\tlocal terrainMap = [\n')
        for y in range(height):
            row = terrain_grid[y]
            w('\t\t\t[' + ', '.join(str(v) for v in row) + ']' + (',' if y < height-1 else '') + '\n')
        w('\t\t];\n')
        # Emit height map
        w('\t\tlocal heightMap = [\n')
        for y in range(height):
            row = height_grid[y]
            w('\t\t\t[' + ', '.join(str(v) for v in row) + ']' + (',' if y < height-1 else '') + '\n')
        w('\t\t];\n')
        # Fill loop
        w('\t\tfor (local y = 0; y < {h}; y = ++y)\n'.format(h=height))
        w('\t\t{\n')
        w('\t\t\tfor (local x = 0; x < {w}; x = ++x)\n'.format(w=width))
        w('\t\t\t{\n')
        w('\t\t\t\tlocal wx = _rect.X + x;\n')
        w('\t\t\t\tlocal wy = _rect.Y + y;\n')
        w('\t\t\t\tlocal tile = this.Tactical.getTileSquare(wx, wy);\n')
        w('\t\t\t\t// Set height first\n')
        w('\t\t\t\ttile.Level = heightMap[y][x];\n')
        w('\t\t\t\t// Stamp terrain\n')
        w('\t\t\t\tlocal code = terrainMap[y][x];\n')
        w('\t\t\t\tlocal rect = { X = wx, Y = wy, W = 1, H = 1, IsEmpty = false };\n')
        w('\t\t\t\tif (code != 0 && Tiles[code] != null) Tiles[code].fill(rect, null);\n')
        w('\t\t\t}\n')
        w('\t\t}\n')
        w('\t\tthis.makeBordersImpassable(_rect);\n')
        w('\t}\n\n')

        # Optional object pass
        if object_grid is not None and object_keys is not None and len(object_keys) > 1:
            w('\tfunction onSecondPass( _rect )\n\t{\n')
            # Emit sprite ids used
            w('\t\tlocal Sprites = [ null')
            for i, sid in enumerate(object_keys):
                if i == 0:
                    continue
                w(', "{sid}"'.format(sid=sid))
            w(' ];\n')
            # Emit entity mapping
            if object_entity_map:
                w('\t\tlocal Entities = {')
                first = True
                for sid, ent in object_entity_map.items():
                    if not first:
                        w(',')
                    first = False
                    w(' ["{sid}"] = "{ent}"'.format(sid=sid, ent=ent))
                w(' };\n')
            else:
                w('\t\tlocal Entities = {};\n')
            # Emit object grid
            w('\t\tlocal objectMap = [\n')
            for y in range(height):
                row = object_grid[y]
                w('\t\t\t[' + ', '.join(str(v) for v in row) + ']' + (',' if y < height-1 else '') + '\n')
            w('\t\t];\n')
            # Iterate and spawn
            w('\t\tfor (local y = 0; y < {h}; y = ++y)\n'.format(h=height))
            w('\t\t{\n')
            w('\t\t\tfor (local x = 0; x < {w}; x = ++x)\n'.format(w=width))
            w('\t\t\t{\n')
            w('\t\t\t\tlocal wx = _rect.X + x;\n')
            w('\t\t\t\tlocal wy = _rect.Y + y;\n')
            w('\t\t\t\tlocal tile = this.Tactical.getTileSquare(wx, wy);\n')
            w('\t\t\t\tlocal code = objectMap[y][x];\n')
            w('\t\t\t\tif (code == 0) continue;\n')
            w('\t\t\t\tlocal sid = Sprites[code];\n')
            w('\t\t\t\tif (sid in Entities)\n')
            w('\t\t\t\t{\n')
            w('\t\t\t\t\tlocal o = tile.spawnObject(Entities[sid]);\n')
            w('\t\t\t\t\tif (o != null)\n')
            w('\t\t\t\t\t{\n')
            w('\t\t\t\t\t\tlocal b = o.getSprite("body");\n')
            w('\t\t\t\t\t\tif (b != null) b.setBrush(sid);\n')
            w('\t\t\t\t\t}\n')
            w('\t\t\t\t}\n')
            w('\t\t\t\telse\n')
            w('\t\t\t\t{\n')
            w('\t\t\t\t\ttile.spawnDetail(sid);\n')
            w('\t\t\t\t}\n')
            w('\t\t\t}\n')
            w('\t\t}\n')
            w('\t}\n\n')

        w('});\n')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('map_json', help='Path to Tiled map JSON (.json/.tmj)')
    ap.add_argument('tileset_json', nargs='?', default=None, help='Path to Tiled tileset JSON (collection of images). If omitted, inferred from map tilesets[0].source with .json extension.')
    ap.add_argument('--name', default=None, help='Squirrel template name (e.g., tactical.custom_name). Defaults to derived from output or map filename')
    ap.add_argument('--out', default=None, help='Output .nut path. Defaults to scripts/custom_maps/<map_stem>_map.nut')
    ap.add_argument('--metadata', nargs='*', default=None, help='One or more metadata.xml files (terrain/objects) to improve tile classification')
    ap.add_argument('--objects', default=None, help='Optional JSON file mapping object sprite-id to entity script path (e.g., entity/tactical/objects/human_camp_wall)')
    args = ap.parse_args()

    map_json = load_json(args.map_json)

    width = int(map_json.get('width', 0))
    height = int(map_json.get('height', 0))
    if width <= 0 or height <= 0:
        print('Map width/height missing or zero', file=sys.stderr)
        sys.exit(1)

    # Resolve tileset path and firstgid
    tilesets = map_json.get('tilesets', [])
    if not tilesets:
        print('No tilesets in map JSON', file=sys.stderr)
        sys.exit(1)
    ts = tilesets[0]
    firstgid = int(ts.get('firstgid', 1))

    tileset_path = args.tileset_json
    if not tileset_path:
        src = ts.get('source') or ''
        if src:
            base = os.path.basename(src)
            # Prefer a .json sibling if .tsx was referenced
            if base.lower().endswith('.tsx'):
                base = base[:-4] + '.json'
            tileset_path = os.path.join(os.path.dirname(args.map_json), base)
        else:
            tileset_path = os.path.join(os.path.dirname(args.map_json), 'Terrain.json')

    tileset_json = load_json(tileset_path)
    # Combined gid->image across all tilesets in the map
    gid_to_img = build_gid_to_img_from_map(map_json, os.path.dirname(args.map_json))
    # Build metadata map: prefer provided paths, else try typical defaults
    meta_paths = []
    if args.metadata:
        meta_paths = args.metadata
    else:
        for p in (
            os.path.join('terrain', 'metadata.xml'),
            os.path.join('object_0', 'metadata.xml'),
            os.path.join('object_1', 'metadata.xml'),
        ):
            if os.path.isfile(p):
                meta_paths.append(p)
    meta_map = build_combined_metadata_map(meta_paths) if meta_paths else {}

    layers, height_layers = extract_layers(map_json)
    if not height_layers:
        print('No height layers found (expected layers named "height N")', file=sys.stderr)
        sys.exit(1)

    # Base terrain layer: pick layer named 'height 0' / 'height_0' (case-insensitive) if present; else first tilelayer.
    base_layer_data = None
    for l in layers:
        if l.get('type') != 'tilelayer':
            continue
        lname = str(l.get('name', '')).lower()
        if lname == 'height 0' or lname == 'height_0' or lname == 'height0':
            base_layer_data = l.get('data')
            break
    if base_layer_data is None:
        # Find first tilelayer as fallback
        first_tilelayer = next((ly for ly in layers if ly.get('type') == 'tilelayer'), None)
        base_layer_data = first_tilelayer.get('data') if first_tilelayer is not None else None
    if base_layer_data is None:
        print('Could not find a base terrain layer; aborting', file=sys.stderr)
        sys.exit(1)

    height_grid = compute_height_grid(height_layers, width, height)
    terrain_gid_grid = compute_terrain_gid_grid(width, height, height_layers, base_layer_data)
    terrain_grid, terrain_keys = compute_terrain_index_grid_from_gid_grid(terrain_gid_grid, width, height, gid_to_img, meta_map)

    # Objects: build sprite-id map from object metadata files only
    object_meta_paths = [p for p in (args.metadata or []) if 'object' in p] if args.metadata else [p for p in (
        os.path.join('object_0', 'metadata.xml'),
        os.path.join('object_1', 'metadata.xml'),
    ) if os.path.isfile(p)]
    object_sprite_map = build_combined_spriteid_map(object_meta_paths) if object_meta_paths else {}
    object_grid, object_keys = compute_object_index_grid = (None, None)
    try:
        object_grid, object_keys = compute_object_grid(layers, width, height, gid_to_img, object_sprite_map)
    except Exception:
        object_grid, object_keys = (None, None)

    # Load object entity mapping
    object_entity_map = {}
    lookup_path = args.objects or ('objects_lookup.json' if os.path.isfile('objects_lookup.json') else None)
    if lookup_path:
        try:
            with open(lookup_path, 'r', encoding='utf-8') as lf:
                object_entity_map = json.load(lf)
        except Exception:
            object_entity_map = {}

    # Derive sensible defaults for out and name
    map_stem = basename_noext(args.map_json).lower()
    out_path = args.out or os.path.join('scripts', 'custom_maps', f'{map_stem}_map.nut')
    # Name used inside .nut for m.Name (tactical.<stem>) and class symbol (tactical_<stem>)
    name = args.name or f'tactical.{map_stem}'

    write_nut(out_path, name, width, height, terrain_grid, height_grid, terrain_keys, object_grid, object_keys, object_entity_map)
    print(f'Wrote {out_path} with name={name} size={width}x{height}')


if __name__ == '__main__':
    main()
