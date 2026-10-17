import re
from abc import ABC, abstractmethod


class Scrawler[T](ABC):
	@abstractmethod
	def run(self, code:str) -> T:
		pass

	# noinspection method-may-be-static
	def _parse_wiki_metadata(self, comments: list[str]) -> tuple[bool, str | None]:
		"""Inspects node comments for @wiki_skip and @wiki_name directives."""
		skip = False
		override_name = None

		for comment in comments:
			if "@wiki_skip" in comment:
				skip = True
			if "@wiki_name" in comment:
				match = re.search(r'@wiki_name\s+(?:"([^"]+)"|\'([^\']+)\'|(\S+))', comment)
				if match:
					override_name = match.group(1) or match.group(2) or match.group(3)
					override_name = override_name.rstrip(",")

		return skip, override_name
