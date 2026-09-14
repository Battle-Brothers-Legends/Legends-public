class BinPackager:
	@staticmethod
	def fill_nfs(frame_images, max_dim):
		"""
		Next-Fit Shelf bin packaging. Same as bbrusher.exe
		"""
		unique_images = list(frame_images.keys())
		unique_images.sort(key=lambda name: -frame_images[name].height)

		bins = []
		spacing = 1 if len(unique_images) > 1 else 0

		for name in unique_images:
			w, h = frame_images[name].width, frame_images[name].height
			placed = False

			for b in bins:
				if b['curr_x'] + w <= max_dim and b['curr_y'] + h <= max_dim:
					px, py = b['curr_x'], b['curr_y']
					b['images'][name] = (px, py)

					b['used_w'] = max(b['used_w'], px + w)
					b['used_h'] = max(b['used_h'], py + h)

					b['curr_x'] += w + spacing
					b['shelf_h'] = max(b['shelf_h'], h)
					placed = True
					break
				else:
					new_y = b['curr_y'] + b['shelf_h'] + spacing
					if w <= max_dim and new_y + h <= max_dim:
						b['curr_y'] = new_y
						b['curr_x'] = 0
						px, py = b['curr_x'], b['curr_y']

						b['images'][name] = (px, py)
						b['used_w'] = max(b['used_w'], px + w)
						b['used_h'] = max(b['used_h'], py + h)

						b['curr_x'] += w + spacing
						b['shelf_h'] = h
						placed = True
						break

			if not placed:
				bins.append({
					'images': {name: (0, 0)},
					'curr_x': w + spacing,
					'curr_y': 0,
					'shelf_h': h,
					'used_w': w,
					'used_h': h
				})
		return bins


	@staticmethod
	def fill_bf(frame_images, max_dim):
		"""
		Best-Fit bin packaging.
		"""
		unique_images = list(frame_images.keys())
		unique_images.sort(key=lambda name: -frame_images[name].height)

		bins = []
		spacing = 1 if len(unique_images) > 1 else 0

		for name in unique_images:
			w, h = frame_images[name].width, frame_images[name].height
			placed = False
			best_bin, best_shelf, min_h_diff = None, None, float('inf')

			# 1. Search for best existing shelf
			for b in bins:
				for shelf in b['shelves']:
					if shelf['curr_x'] + w <= max_dim and h <= shelf['max_h']:
						diff = shelf['max_h'] - h
						if diff < min_h_diff:
							min_h_diff, best_bin, best_shelf = diff, b, shelf
				if min_h_diff == 0: break

			if best_shelf:
				px, py = best_shelf['curr_x'], best_shelf['y_pos']
				best_bin['images'][name] = (px, py)
				best_bin['used_w'] = max(best_bin['used_w'], px + w)
				best_bin['used_h'] = max(best_bin['used_h'], py + h)
				best_shelf['curr_x'] += w + spacing
				placed = True

			# 2. Try new shelf in existing bins
			if not placed:
				for b in bins:
					last_shelf = b['shelves'][-1]
					new_y = last_shelf['y_pos'] + last_shelf['max_h'] + spacing
					if w <= max_dim and new_y + h <= max_dim:
						new_shelf = {'y_pos': new_y, 'curr_x': w + spacing, 'max_h': h}
						b['shelves'].append(new_shelf)
						b['images'][name] = (0, new_y)
						b['used_w'] = max(b['used_w'], w)
						b['used_h'] = max(b['used_h'], new_y + h)
						placed = True
						break
			if not placed:
				bins.append({
					'images': {name: (0, 0)},
					'shelves': [{
						'y_pos': 0,
						'curr_x': w + spacing,
						'max_h': h
					}],
					'used_w': w,
					'used_h': h
				})
		return bins