class LazyFileReader:
	def __init__(self, fp, pbar, limit):
		self.fp = fp
		self.pbar = pbar
		self.limit = limit
		self.bytes_read = 0

	def read(self, size=-1):
		if self.bytes_read >= self.limit:
			return b""

		remaining = self.limit - self.bytes_read
		to_read = min(size, remaining) if size > 0 else remaining

		chunk = self.fp.read(to_read)
		self.bytes_read += len(chunk)
		self.pbar.update(len(chunk))
		return chunk

	def __len__(self):
		return self.limit