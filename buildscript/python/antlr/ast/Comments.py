import json
from typing import Any, List


class Comments:
    """Encapsulates comment mapping and retrieval for AST nodes."""

    def __init__(self, comment_map: dict[int, str]):
        self._map = comment_map

    @property
    def map(self) -> dict[int, str]:
        """Direct access to the underlying line-to-comment dictionary."""
        return self._map

    def for_node(self, node: Any) -> List[str]:
        """Find all comments associated with an AST node's span boundaries,
        including preceding doc comments and internal line comments.
        """
        span = node.span
        start_line = span.start_line
        stop_line = span.end_line

        collected = []

        # Scan backwards for preceding doc/header comments
        curr_line = start_line - 1
        while curr_line in self._map:
            collected.insert(0, self._map[curr_line])
            curr_line -= 1

        # Scan within the node's span lines for internal comments
        for line in range(start_line, stop_line + 1):
            if line in self._map:
                collected.append(self._map[line])

        return collected

    def __str__(self) -> str:
        """Returns JSON-serialized representation of the comment map."""
        return json.dumps(self._map, indent=2)

    def __repr__(self) -> str:
        return f"Comments(count={len(self._map)})"