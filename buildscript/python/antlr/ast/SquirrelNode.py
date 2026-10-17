from dataclasses import dataclass, field
from typing import Any, Optional


@dataclass
class Span:
    """Start and end line/column in the source file (ANTLR convention)."""
    start_line: int
    start_column: int
    end_line: int
    end_column: int

    @classmethod
    def from_ctx(cls, ctx) -> Optional["Span"]:
        if not ctx or not getattr(ctx, "start", None):
            return None

        start = ctx.start
        stop = getattr(ctx, "stop", None) or start
        end_line = getattr(start, "line", 0)
        return Span(
            start_line=getattr(start, "line", 0),
            start_column=getattr(start, "column", 0),
            end_line=getattr(stop, "line", end_line),
            end_column=getattr(stop, "column", 0)
        )


@dataclass
class SquirrelNode:
    span: Optional[Span] = field(init=False, default=None, compare=False)
    parent: 'SquirrelNode' = field(init=False, compare=False)

    def isinstance(self, node_type) -> bool:
        if isinstance(node_type, str) and type(self).__name__ == node_type:
            return True
        elif isinstance(node_type, type) and isinstance(self, node_type):
            return True
        return False

    def fields(self) -> dict[str, Any]:
        """Return all public fields/attributes."""
        return {k: v for k, v in self.__dict__.items() if not k.startswith("_")}

    def dump(self, indent: int = 2) -> str:
        try:
            """Recursively format the current node and all its child nodes as an indented tree."""
            prefix = "  " * indent
            # Uses your existing __str__ summary for the current node header
            lines = [f"{prefix}{str(self)}"]

            # Inspect all public fields for nested nodes or lists of nodes
            for key, val in self.fields().items():
                if key in ["parent"]:
                    continue

                if isinstance(val, SquirrelNode):
                    lines.append(f"{prefix}  .{key} =")
                    lines.append(val.dump(indent + 2))
                elif isinstance(val, list):
                    node_items = [item for item in val if isinstance(item, SquirrelNode)]
                    if node_items:
                        lines.append(f"{prefix}  .{key} (list len={len(val)}) =")
                        for item in node_items:
                            lines.append(item.dump(indent + 2))
            return "\n".join(lines)
        except:
            print(f"Class {type(self).__name__} returned not string from __str__!")
            return ""

    def __str__(self) -> str:
        node_type = type(self).__name__
        line = f"{self.span.start_line if self.span else "?"}:{self.span.start_column if self.span else "?"}"

        details = []
        for key, val in self.fields().items():
            if key == "span":  # <--- Skip the raw span object in summaries
                continue
            if isinstance(val, (int, float, str, bool, type(None))):
                details.append(f"{key}={repr(val)}")
            elif hasattr(val, "__iter__") and not isinstance(val, (str, bytes)):
                details.append(f"{key}=<{type(val).__name__} len={len(val)}>")
            else:
                details.append(f"{key}=<{type(val).__name__}>")

        detail_str = f" ({', '.join(details)})" if details else ""
        return f"<{node_type} line={line}{detail_str}>"
