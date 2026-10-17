import dataclasses
from typing import Type, Callable, Optional, List, TypeVar, Any

from antlr.ast.SquirrelNode import SquirrelNode
from antlr.ast.nodes import ScopeAccess, DotAccess

T = TypeVar('T')


class AstUtils:
	@classmethod
	def _walk(cls, node: SquirrelNode):
		"""Recursively yields all node objects in the AST."""
		if node is None:
			return

		# Handle lists/tuples (e.g., statement blocks, argument lists)
		if isinstance(node, (list, tuple)):
			for item in node:
				yield from cls._walk(item)
			return

		# If it's a dataclass, yield it and traverse its fields
		if dataclasses.is_dataclass(node):
			yield node
			for field in dataclasses.fields(node):
				if field.name in ["parent", "span"]:
					continue
				value = getattr(node, field.name)
				yield from cls._walk(value)

	@classmethod
	def find(cls, node: SquirrelNode, node_type: Type[T], predicate: Optional[Callable[[T], bool]] = None) -> List[T]:
		"""Finds all nodes of a given type that satisfy an optional predicate."""
		results = []
		for n in cls._walk(node):
			if n is node:
				continue
			if isinstance(n, node_type):
				if predicate is None or predicate(n):
					results.append(n)
		return results

	@classmethod
	def find_first(cls, node: SquirrelNode, node_type: Type[T], predicate: Optional[Callable[[T], bool]] = None) -> \
	Optional[T]:
		"""Null-safe search that returns the first node of a given type satisfying an optional predicate."""
		for n in cls._walk(node):
			if n is node:
				continue
			if isinstance(n, node_type):
				if predicate is None or predicate(n):
					return n
		return None

	@classmethod
	def find_ancestor(cls, node: SquirrelNode, node_type: Type[T]):
		"""Walks up the parent chain to find the nearest ancestor of a specific type."""
		curr = node.parent
		while curr is not None:
			if isinstance(curr, node_type):
				return curr
			curr = curr.parent
		return None

	@classmethod
	def qualified_name(cls, node: SquirrelNode) -> Optional[str]:
		if isinstance(node, ScopeAccess):
			return f"::{node.name}"

		if isinstance(node, DotAccess):
			left_name = cls.qualified_name(node.expr)
			if left_name:
				return f"{left_name}.{node.name}"
			return node.name

		return None
