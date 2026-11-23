# ── Constants ──────────────────────────────────────────────────────────────────

BRUSH_MAGIC = 0xBAADFAAD
DEFAULT_VERSION = 17
DEFAULT_L0 = 0xBF795EF4D3FE85C5
DEFAULT_FLAGS = 0x6400
DEFAULT_I0 = 1000
DEFAULT_F3 = 2.0

# Header flag byte defaults (b1–b12): indices 0,2,3,4,8 → 1, rest → 0
HEADER_FLAG_DEFAULTS = bytes([1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0])

# Per-sprite b6–b9 defaults
SPRITE_B6_9_DEFAULTS = bytes([3, 4, 0, 0])

# ── Data containers ───────────────────────────────────────────────────────────

class Frame:
	"""One animation frame within a sprite."""
	__slots__ = ('name', 'u1', 'u2', 'v1', 'v2',
				 'edge_left', 'edge_right', 'edge_top', 'edge_bottom')

	def __init__(self):
		self.name = ''
		self.u1 = self.u2 = self.v1 = self.v2 = 0.0
		self.edge_left = self.edge_right = self.edge_top = self.edge_bottom = None

	def pixel_rect(self, img_w, img_h):
		"""Return (x, y, w, h) in atlas pixels."""
		x1 = int(round(self.u1 * img_w))
		x2 = int(round(self.u2 * img_w))
		y1 = int(round(self.v1 * img_h))
		y2 = int(round(self.v2 * img_h))
		return x1, y1, x2 - x1, y2 - y1


class Sprite:
	"""One sprite record (may contain multiple frames)."""
	__slots__ = ('id', 'hash', 'L0', 'width', 'height',
				 'offset_x', 'offset_y', 'flags',
				 'b1_5', 'rot_speed', 'b6_9',
				 'f1', 'f2', 'ic', 'f3',
				 'frames', 'b10_12')

	def __init__(self):
		self.id = ''
		self.hash = 0
		self.L0 = DEFAULT_L0
		self.width = self.height = 0
		self.offset_x = self.offset_y = 0
		self.flags = DEFAULT_FLAGS
		self.b1_5 = bytes(5)
		self.rot_speed = 0.0
		self.b6_9 = bytes(SPRITE_B6_9_DEFAULTS)
		self.f1 = self.f2 = 0.0
		self.ic = 0
		self.f3 = DEFAULT_F3
		self.frames = []
		self.b10_12 = bytes(3)


class Brush:
	"""In-memory representation of a complete .brush file."""
	__slots__ = ('version', 'img_name', 'img_width', 'img_height',
				 'header_flags', 'b13_14', 'i0', 'sprites')

	def __init__(self):
		self.version = DEFAULT_VERSION
		self.img_name = ''
		self.img_width = self.img_height = 0
		self.header_flags = bytearray(HEADER_FLAG_DEFAULTS)
		self.b13_14 = bytes(2)
		self.i0 = DEFAULT_I0
		self.sprites = []
