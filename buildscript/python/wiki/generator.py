from abc import abstractmethod, ABC


class Generator(ABC):
	TABLE_START = "<table><tbody>"
	TABLE_END = "</tbody></table>\n"

	@abstractmethod
	def process(self):
		pass

	# noinspection method-may-be-static
	def get_content(self, file):
		try:
			with open(file, 'r', encoding='utf-8') as file:
				return file.read()
		except:
			raise Exception("File not found")