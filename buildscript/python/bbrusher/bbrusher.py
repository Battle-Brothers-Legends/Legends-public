import io
import math
import os
import struct
import xml.etree.ElementTree as ET
from PIL import Image as PILImage
from PIL.Image import Transpose
from pathlib import Path
from .bin_packager import BinPackager
from .model import *


class BBrusher:
	@staticmethod
	def hash_name(name):
		"""Hash a sprite name to uint64 (bbrusher convention)."""
		h = 0
		for c in name:
			h = (h * 65599 + ord(c)) & 0xFFFFFFFFFFFFFFFF
		return h

	@staticmethod
	def _read_str(data, off):
		"""Read uint16-length-prefixed UTF-8 string.  Returns (string, new_offset)."""
		n = struct.unpack_from('<H', data, off)[0]
		return data[off + 2:off + 2 + n].decode('utf-8'), off + 2 + n

	@staticmethod
	def _write_str(f, s):
		"""Write uint16-length-prefixed UTF-8 string to file-like *f*."""
		b = s.encode('utf-8')
		f.write(struct.pack('<H', len(b)))
		f.write(b)

	@staticmethod
	def _po2(v):
		"""Round *v* up to next power of two (minimum 1)."""
		v = max(int(v), 1) - 1
		v |= v >> 1
		v |= v >> 2
		v |= v >> 4
		v |= v >> 8
		v |= v >> 16
		return v + 1

	@staticmethod
	def read_brush(data):
		"""Parse raw bytes into a *Brush*.  Raises *ValueError* on bad data."""
		if len(data) < 32:
			raise ValueError('File too small to be a valid .brush file')

		o = 0
		magic = struct.unpack_from('<I', data, o)[0]; o += 4
		if magic != BRUSH_MAGIC:
			raise ValueError(f'Invalid magic: 0x{magic:08X}')

		b = Brush()
		b.version = struct.unpack_from('<H', data, o)[0]; o += 2
		b.img_name, o = BBrusher._read_str(data, o)
		b.img_width, b.img_height = struct.unpack_from('<HH', data, o); o += 4
		b.header_flags = bytearray(data[o:o + 12]); o += 12

		count = struct.unpack_from('<i', data, o)[0]; o += 4
		b.b13_14 = bytes(data[o:o + 2]); o += 2
		b.i0 = struct.unpack_from('<I', data, o)[0]; o += 4

		for _ in range(count):
			s = Sprite()
			s.hash = struct.unpack_from('<Q', data, o)[0]; o += 8
			s.id, o = BBrusher._read_str(data, o)
			s.L0 = struct.unpack_from('<Q', data, o)[0]; o += 8
			s.width, s.height = struct.unpack_from('<ii', data, o); o += 8
			s.offset_x, s.offset_y = struct.unpack_from('<hh', data, o); o += 4
			s.flags = struct.unpack_from('<I', data, o)[0]; o += 4
			s.b1_5 = bytes(data[o:o + 5]); o += 5
			s.rot_speed = struct.unpack_from('<f', data, o)[0]; o += 4
			s.b6_9 = bytes(data[o:o + 4]); o += 4
			s.f1, s.f2 = struct.unpack_from('<ff', data, o); o += 8
			s.ic = struct.unpack_from('<I', data, o)[0]; o += 4
			s.f3 = struct.unpack_from('<f', data, o)[0]; o += 4

			fc = struct.unpack_from('<H', data, o)[0]; o += 2
			for _ in range(fc):
				fr = Frame()
				fr.name, o = BBrusher._read_str(data, o)
				fr.u1, fr.u2, fr.v1, fr.v2 = struct.unpack_from('<ffff', data, o); o += 16
				fr.edge_left, fr.edge_right, fr.edge_top, fr.edge_bottom = \
					struct.unpack_from('<ffff', data, o); o += 16
				s.frames.append(fr)

			s.b10_12 = bytes(data[o:o + 3]); o += 3
			b.sprites.append(s)

		return b


	@staticmethod
	def write_brush(brush):
		"""Serialize a *Brush* to bytes."""
		f = io.BytesIO()

		f.write(struct.pack('<I', BRUSH_MAGIC))
		f.write(struct.pack('<H', brush.version))
		BBrusher._write_str(f, brush.img_name)
		f.write(struct.pack('<HH', brush.img_width, brush.img_height))
		f.write(bytes(brush.header_flags[:12]).ljust(12, b'\x00'))
		f.write(struct.pack('<i', len(brush.sprites)))
		f.write(bytes(brush.b13_14[:2]).ljust(2, b'\x00'))
		f.write(struct.pack('<I', brush.i0))

		for sp in brush.sprites:
			f.write(struct.pack('<Q', sp.hash))
			BBrusher._write_str(f, sp.id)
			f.write(struct.pack('<Q', sp.L0))
			f.write(struct.pack('<ii', sp.width, sp.height))
			f.write(struct.pack('<hh', sp.offset_x, sp.offset_y))
			f.write(struct.pack('<I', sp.flags))
			f.write(bytes(sp.b1_5[:5]).ljust(5, b'\x00'))
			f.write(struct.pack('<f', sp.rot_speed))
			f.write(bytes(sp.b6_9[:4]).ljust(4, b'\x00'))
			f.write(struct.pack('<ff', sp.f1, sp.f2))
			f.write(struct.pack('<I', sp.ic))
			f.write(struct.pack('<f', sp.f3))
			f.write(struct.pack('<H', len(sp.frames)))
			for fr in sp.frames:
				BBrusher._write_str(f, fr.name)
				f.write(struct.pack('<ffff', fr.u1, fr.u2, fr.v1, fr.v2))
				f.write(struct.pack('<ffff',
									fr.edge_left, fr.edge_right,
									fr.edge_top, fr.edge_bottom))
			f.write(bytes(sp.b10_12[:3]).ljust(3, b'\x00'))

		return f.getvalue()


	@staticmethod
	def brush_to_xml(brush):
		"""Convert a *Brush* to a bbrusher-compatible *metadata.xml* ElementTree root."""
		root = ET.Element('brush')
		root.set('name', brush.img_name)
		root.set('version', str(brush.version))

		for i in range(12):
			if brush.header_flags[i] != HEADER_FLAG_DEFAULTS[i]:
				root.set(f'b{i + 1}', str(brush.header_flags[i]))
		for i in range(2):
			if brush.b13_14[i] != 0:
				root.set(f'b{i + 13}', str(brush.b13_14[i]))
		if brush.i0 != DEFAULT_I0:
			root.set('i0', str(brush.i0))

		for sp in brush.sprites:
			el = ET.SubElement(root, 'sprite')
			el.set('id', sp.id)

			if sp.hash != BBrusher.hash_name(sp.id):
				el.set('hash', f'{sp.hash:016X}')
			if sp.L0 != DEFAULT_L0:
				el.set('L0', f'{sp.L0:016X}')
			if sp.offset_x != 0:
				el.set('offsetX', str(sp.offset_x))
			if sp.offset_y != 0:
				el.set('offsetY', str(sp.offset_y))
			if sp.flags != DEFAULT_FLAGS:
				el.set('f', f'{sp.flags:X}')

			for i in range(5):
				if sp.b1_5[i] != 0:
					el.set(f'b{i + 1}', str(sp.b1_5[i]))
			if sp.rot_speed != 0:
				el.set('rotSpeed', str(sp.rot_speed))
			for i in range(4):
				if sp.b6_9[i] != SPRITE_B6_9_DEFAULTS[i]:
					el.set(f'b{i + 6}', str(sp.b6_9[i]))

			if sp.f1 != 0:
				el.set('f1', str(sp.f1))
				el.set('f2', str(sp.f2))
			ic_str = f'{sp.ic:08X}' if sp.ic != 0 else None
			if ic_str:
				el.set('ic', ic_str)
			if sp.f3 != DEFAULT_F3:
				el.set('f3', str(sp.f3))

			# Width/height: only emit when they differ from first frame's stored dims
			first_stored_w = first_stored_h = 0
			if sp.frames:
				fr0 = sp.frames[0]
				first_stored_w = int(round(fr0.u2 * brush.img_width)) - \
								 int(round(fr0.u1 * brush.img_width))
				first_stored_h = int(round(fr0.v2 * brush.img_height)) - \
								 int(round(fr0.v1 * brush.img_height))
			if first_stored_w != sp.width or first_stored_h != sp.height:
				el.set('width', str(sp.width))
				el.set('height', str(sp.height))

			multi = len(sp.frames) > 1
			for fr in sp.frames:
				target = ET.SubElement(el, 'frame') if multi else el
				target.set('img', fr.name)

				_, _, sw, sh = fr.pixel_rect(brush.img_width, brush.img_height)
				left_def = int(-(sw + 1) / 2)
				right_def = sw / 2
				top_def = int(-(sh + 1) / 2)
				bottom_def = sh / 2

				if fr.edge_left != left_def:
					target.set('left', str(fr.edge_left))
				if fr.edge_right != right_def:
					target.set('right', str(fr.edge_right))
				if fr.edge_top != top_def:
					target.set('top', str(fr.edge_top))
				if fr.edge_bottom != bottom_def:
					target.set('bottom', str(fr.edge_bottom))

			for i in range(3):
				if sp.b10_12[i] != 0:
					el.set(f'b{i + 10}', str(sp.b10_12[i]))

		return root


	@staticmethod
	def xml_to_brush(root):
		"""Convert a bbrusher *metadata.xml* root element to a *Brush*.

		Frame UV coords and edge defaults are left unset — they are filled in during
		atlas packing (see *pack_brush_from_dir*).
		"""
		b = Brush()
		b.img_name = root.get('name', '')
		b.version = int(root.get('version', str(DEFAULT_VERSION)))

		hf = bytearray(HEADER_FLAG_DEFAULTS)
		for i in range(12):
			v = root.get(f'b{i + 1}')
			if v is not None:
				hf[i] = int(v)
		b.header_flags = hf

		b13 = bytearray(2)
		for i in range(2):
			v = root.get(f'b{i + 13}')
			if v is not None:
				b13[i] = int(v)
		b.b13_14 = bytes(b13)

		b.i0 = int(root.get('i0', str(DEFAULT_I0)))

		for sel in root.findall('sprite'):
			sp = Sprite()
			sp.id = sel.get('id', '')

			h = sel.get('hash')
			sp.hash = int(h, 16) if h else BBrusher.hash_name(sp.id)
			l0 = sel.get('L0')
			sp.L0 = int(l0, 16) if l0 else DEFAULT_L0

			sp.offset_x = int(sel.get('offsetX', '0'))
			sp.offset_y = int(sel.get('offsetY', '0'))

			fv = sel.get('f')
			sp.flags = int(fv, 16) if fv else DEFAULT_FLAGS

			b1 = bytearray(5)
			for i in range(5):
				v = sel.get(f'b{i + 1}')
				if v is not None:
					b1[i] = int(v)
			sp.b1_5 = bytes(b1)

			rs = sel.get('rotSpeed')
			sp.rot_speed = float(rs) if rs else 0.0

			b6 = bytearray(SPRITE_B6_9_DEFAULTS)
			for i in range(4):
				v = sel.get(f'b{i + 6}')
				if v is not None:
					b6[i] = int(v)
			sp.b6_9 = bytes(b6)

			sp.f1 = float(sel.get('f1', '0'))
			sp.f2 = float(sel.get('f2', '0'))
			icv = sel.get('ic')
			sp.ic = int(icv, 16) if icv else 0
			sp.f3 = float(sel.get('f3', str(DEFAULT_F3)))

			sp.width = int(sel.get('width', '0'))
			sp.height = int(sel.get('height', '0'))

			frame_els = sel.findall('frame')
			if not frame_els:
				frame_els = [sel]
			for fel in frame_els:
				fr = Frame()
				fr.name = fel.get('img', '')
				# Edges — read if present, otherwise left at 0 (set during packing)
				for attr, slot in [('left', 'edge_left'), ('right', 'edge_right'),
								   ('top', 'edge_top'), ('bottom', 'edge_bottom')]:
					v = fel.get(attr)
					if v is not None:
						setattr(fr, slot, float(v))
				sp.frames.append(fr)

			b10 = bytearray(3)
			for i in range(3):
				v = sel.get(f'b{i + 10}')
				if v is not None:
					b10[i] = int(v)
			sp.b10_12 = bytes(b10)

			b.sprites.append(sp)

		return b


	# ── Atlas packing ─────────────────────────────────────────────────────────────
	@staticmethod
	def _pack_rects(sizes, spacing=1):
		"""Shelf-pack a list of (w, h) tuples into a power-of-two atlas.

		Returns *(atlas_w, atlas_h, positions)* where *positions* is a list of
		*(x, y)* tuples in the same order as *sizes*.
		"""
		if not sizes:
			return 1, 1, []

		total_area = sum((w + spacing) * (h + spacing) for w, h in sizes)
		atlas_w = BBrusher._po2(int(math.sqrt(total_area)))
		atlas_h = BBrusher._po2(total_area // max(atlas_w, 1))

		# Ensure atlas can fit the widest / tallest single rect
		atlas_w = max(atlas_w, BBrusher._po2(max(w for w, _ in sizes)))
		atlas_h = max(atlas_h, BBrusher._po2(max(h for _, h in sizes)))

		# Sort indices by height descending for better shelf utilisation
		order = sorted(range(len(sizes)), key=lambda i: -sizes[i][1])

		while True:
			positions = [None] * len(sizes)
			shelf_y = shelf_x = shelf_h = 0
			fit = True

			for idx in order:
				w, h = sizes[idx]
				if shelf_x + w > atlas_w:
					shelf_y += shelf_h + spacing
					shelf_x = 0
					shelf_h = 0
				if shelf_x + w > atlas_w or shelf_y + h > atlas_h:
					fit = False
					break
				positions[idx] = (shelf_x, shelf_y)
				shelf_x += w + spacing
				shelf_h = max(shelf_h, h)

			if fit:
				used_h = max(y + sizes[i][1] for i, (x, y) in enumerate(positions))
				atlas_h = BBrusher._po2(used_h)
				return atlas_w, atlas_h, positions

			if atlas_w > atlas_h:
				atlas_h *= 2
			else:
				atlas_w *= 2



	@staticmethod
	def _flip_blit(src, dst, dst_x, dst_y):
		"""Paste *src* (PIL Image) into *dst* flipped vertically (BB atlas convention)."""
		flipped = src.transpose(Transpose.FLIP_TOP_BOTTOM)
		dst.paste(flipped, (dst_x, dst_y))


	# ── High-level pack / unpack ──────────────────────────────────────────────────

	@staticmethod
	def unpack_brush_to_dir(brush_path, out_dir, gfx_dir=None):
		"""Unpack a .brush to individual PNGs + metadata.xml (bbrusher-compatible)."""
		if gfx_dir is None:
			gfx_dir = str(Path(brush_path).resolve().parent.parent)

		with open(brush_path, 'rb') as fh:
			brush = BBrusher.read_brush(fh.read())

		atlas_path = os.path.join(gfx_dir, brush.img_name)
		atlas = PILImage.open(atlas_path).convert('RGBA')

		os.makedirs(out_dir, exist_ok=True)

		for sp in brush.sprites:
			for fr in sp.frames:
				x, y, w, h = fr.pixel_rect(brush.img_width, brush.img_height)
				cropped = atlas.crop((x, y, x + w, y + h))
				cropped = cropped.transpose(Transpose.FLIP_TOP_BOTTOM)

				frame_path = os.path.join(out_dir, fr.name)
				os.makedirs(os.path.dirname(frame_path), exist_ok=True)
				cropped.save(frame_path)
				print(fr.name)

		# Write metadata.xml
		xml_root = BBrusher.brush_to_xml(brush)
		tree = ET.ElementTree(xml_root)
		ET.indent(tree, space='  ')
		tree.write(os.path.join(out_dir, 'metadata.xml'), encoding='unicode', xml_declaration=True)

		print(f'Unpacked {len(brush.sprites)} sprites to {out_dir}')

	@staticmethod
	def pack_brush_from_dir(brush_path, in_dir, gfx_dir=None, logs=False):
		"""Pack individual PNGs + metadata.xml into a .brush + atlas PNG."""
		if gfx_dir is None:
			gfx_dir = str(Path(brush_path).resolve().parent.parent)

		tree = ET.parse(os.path.join(in_dir, 'metadata.xml'))
		brush = BBrusher.xml_to_brush(tree.getroot())

		# Load all frame images
		if logs: print('Loading images...')
		frame_images = {}
		for sp in brush.sprites:
			for fr in sp.frames:
				if fr.name not in frame_images:
					img_path = os.path.join(in_dir, fr.name.replace('\\', '/'))
					# print(fr.name)
					frame_images[fr.name] = PILImage.open(img_path).convert('RGBA')

		# Fill in sprite dimensions from first frame where not explicitly set
		for sp in brush.sprites:
			if sp.width == 0 and sp.frames:
				img = frame_images[sp.frames[0].name]
				sp.width = img.width
				sp.height = img.height

		# Pack rectangles
		if logs: print('Packing rectangles...')
		frame_names = list(frame_images.keys())
		sizes = [(frame_images[n].width, frame_images[n].height) for n in frame_names]
		spacing = 1 if len(frame_names) > 1 else 0

		atlas_w, atlas_h, positions = BBrusher._pack_rects(sizes, spacing)
		pos_by_name = dict(zip(frame_names, positions))

		# Set UVs and edge defaults on every frame
		for sp in brush.sprites:
			for fr in sp.frames:
				img = frame_images[fr.name]
				px, py = pos_by_name[fr.name]
				fr.u1 = px / atlas_w
				fr.u2 = (px + img.width) / atlas_w
				fr.v1 = py / atlas_h
				fr.v2 = (py + img.height) / atlas_h

				# Edge defaults (only set if still at zero from XML parse with no
				# explicit override — matches bbrusher behaviour)
				left_def = int(-(img.width + 1) / 2)
				right_def = img.width // 2
				top_def = int(-(img.height + 1) / 2)
				bottom_def = img.height // 2
				if fr.edge_left is None:
					fr.edge_left = float(left_def)
				if fr.edge_right is None:
					fr.edge_right = float(right_def)
				if fr.edge_top is None:
					fr.edge_top = float(top_def)
				if fr.edge_bottom is None:
					fr.edge_bottom = float(bottom_def)

		brush.img_width = atlas_w
		brush.img_height = atlas_h

		# Compose atlas
		atlas = PILImage.new('RGBA', (atlas_w, atlas_h), (0, 0, 0, 0))
		for name, img in frame_images.items():
			px, py = pos_by_name[name]
			BBrusher._flip_blit(img, atlas, px, py)

		# Save atlas PNG
		img_path = os.path.join(gfx_dir, brush.img_name)
		os.makedirs(os.path.dirname(img_path), exist_ok=True)
		atlas.save(img_path, 'PNG', optimize=True)

		# Write .brush
		with open(brush_path, 'wb') as fh:
			fh.write(BBrusher.write_brush(brush))

		if logs: print(f'Packed {brush.img_name} ({atlas_w}x{atlas_h}) with {len(brush.sprites)} sprites')

	@staticmethod
	def pack_brush_from_dir_smart(base_brush_path, in_dir, gfx_dir=None, max_dim=1024, logs=False):
		"""
		Packs sprites from in_dir into multiple .brush and .png files if they exceed max_dim.
		experimental for now...
		"""
		if gfx_dir is None:
			gfx_dir = str(Path(base_brush_path).resolve().parent.parent)

		tree = ET.parse(os.path.join(in_dir, 'metadata.xml'))
		master_brush = BBrusher.xml_to_brush(tree.getroot())

		frame_images = {}
		for sp in master_brush.sprites:
			for fr in sp.frames:
				if fr.name not in frame_images:
					img_path = os.path.join(in_dir, fr.name.replace('\\', '/'))
					frame_images[fr.name] = PILImage.open(img_path).convert('RGBA')

		# Fill in sprite dimensions from first frame where not explicitly set
		for sp in master_brush.sprites:
			if sp.width == 0 and sp.frames:
				img = frame_images[sp.frames[0].name]
				sp.width = img.width
				sp.height = img.height

		bins = BinPackager.fill_bf(frame_images, max_dim)

		base_p = Path(base_brush_path)
		for i, b in enumerate(bins):
			suffix = f"_{i}" if len(bins) > 1 else ""
			sheet_brush_path = base_p.with_name(f"{base_p.stem}{suffix}{base_p.suffix}")
			sheet_img_name = f"{base_p.stem}{suffix}.png"

			sb = Brush()
			sb.version = master_brush.version
			sb.img_name = f"gfx/{sheet_img_name}"
			sb.img_width = BBrusher._po2(b['used_w'])
			sb.img_height = BBrusher._po2(b['used_h'])
			sb.header_flags = master_brush.header_flags
			sb.i0 = master_brush.i0
			sb.b13_14 = master_brush.b13_14

			atlas = PILImage.new('RGBA', (sb.img_width, sb.img_height), (0,0,0,0))
			sb.sprites = []

			# Group items back into Sprites for the Brush file
			for sp in master_brush.sprites:
				# Only pull frames that ended up in this specific bin
				frames_in_bin = [fr for fr in sp.frames if fr.name in b['images']]
				if not frames_in_bin:
					continue

				# Clone the sprite metadata
				new_sp = Sprite()
				for attr in ['id', 'hash', 'L0', 'width', 'height', 'offset_x', 'offset_y',
							 'flags', 'b1_5', 'rot_speed', 'b6_9', 'f1', 'f2', 'ic', 'f3', 'b10_12']:
					setattr(new_sp, attr, getattr(sp, attr))
				new_sp.frames = []

				for fr in frames_in_bin:
					img = frame_images[fr.name]
					px, py = b['images'][fr.name]

					fr.u1 = px / sb.img_width
					fr.u2 = (px + img.width) / sb.img_width
					fr.v1 = py / sb.img_height
					fr.v2 = (py + img.height) / sb.img_height

					left_def = int(-(img.width + 1) / 2)
					right_def = img.width // 2
					top_def = int(-(img.height + 1) / 2)
					bottom_def = img.height // 2

					if fr.edge_left is None:
						fr.edge_left = float(left_def)
					if fr.edge_right is None:
						fr.edge_right = float(right_def)
					if fr.edge_top is None:
						fr.edge_top = float(top_def)
					if fr.edge_bottom is None:
						fr.edge_bottom = float(bottom_def)

					new_sp.frames.append(fr)

				sb.sprites.append(new_sp)

			for name, (px, py) in b['images'].items():
				img = frame_images[name]
				BBrusher._flip_blit(img, atlas, px, py)

			# Save atlas PNG safely
			img_path = os.path.join(gfx_dir, sheet_img_name)
			os.makedirs(os.path.dirname(img_path), exist_ok=True)
			atlas.save(img_path, 'PNG', optimize=True)

			with open(sheet_brush_path, 'wb') as f:
				f.write(BBrusher.write_brush(sb))

			if logs: print(f"Packed {sheet_brush_path.name} ({sb.img_width}x{sb.img_height}) with {len(sb.sprites)} sprites.")
