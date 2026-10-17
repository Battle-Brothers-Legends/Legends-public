import ast
from dataclasses import dataclass, field
from typing import List, Optional

from antlr.ast.SquirrelNode import SquirrelNode


def _parse_int(s: str) -> int:
	s = s.strip()
	if s.startswith("0x") or s.startswith("0X"):
		return int(s, 16)
	return int(s, 10)


def _unquote(s: str) -> str:
	s = s.strip()
	if s.startswith('@"') and s.endswith('"'):
		return s[2:-1].replace('""', '"')
	if (s.startswith('"') and s.endswith('"')) or \
			(s.startswith("'") and s.endswith("'")):
		try:
			return ast.literal_eval(s)
		except Exception:
			return s[1:-1]
	return s


@dataclass
class Statement(SquirrelNode):
	pass


@dataclass
class Program(SquirrelNode):
	statements: List[Statement] = field(default_factory=list)


@dataclass
class Expression(SquirrelNode):
	pass


# --- Literals ---------------------------------------------------------------

class Literal(Expression):
	@property
	def real_value(self):
		"""Extract the native Python value directly from the Literal node."""
		if isinstance(self, IntegerLiteral):
			return self.value
		if isinstance(self, FloatLiteral):
			return self.value
		if isinstance(self, StringLiteral):
			return self.value
		if isinstance(self, BooleanLiteral):
			return self.value
		if isinstance(self, NullLiteral):
			return None
		if isinstance(self, ThisLiteral):
			return "this"
		return self


@dataclass
class IntegerLiteral(Literal):
	value: int = field()


@dataclass
class FloatLiteral(Literal):
	value: float = field()


@dataclass
class BooleanLiteral(Literal):
	value: bool = field()


@dataclass
class StringLiteral(Literal):
	value: str = field()


@dataclass
class NullLiteral(Literal):
	pass


@dataclass
class ThisLiteral(Literal):
	pass


# --- Init / Args ------------------------------------------------------------

@dataclass
class Init(SquirrelNode):
	identifier: str = field()
	expression: Optional[Expression] = None


@dataclass
class Arg(SquirrelNode):
	name: str = field()
	value: Optional[Expression] = None


@dataclass
class Args(SquirrelNode):
	args: List[Arg] = field(default_factory=list)
	vararg: bool = False


@dataclass
class Funcname(SquirrelNode):
	identifiers: List[str] = field(default_factory=list)


# --- Control flow -----------------------------------------------------------

@dataclass
class StatementBlock(Statement):
	statements: List[Statement] = field(default_factory=list)


@dataclass
class IfStatement(Statement):
	condition: Expression = field()
	statement: Statement = field()
	else_statement: Optional[Statement] = None


@dataclass
class WhileStatement(Statement):
	condition: Expression = field()
	statement: Statement = field()


@dataclass
class DoWhileStatement(Statement):
	condition: Expression = field()
	statement: Statement = field()


@dataclass
class SwitchCase(SquirrelNode):
	condition: Expression = field()
	statements: List[Statement] = field(default_factory=list)


@dataclass
class DefaultCase(SquirrelNode):
	statements: List[Statement] = field(default_factory=list)


@dataclass
class SwitchStatement(Statement):
	condition: Expression = field()
	cases: List[SwitchCase] = field(default_factory=list)
	default: Optional[DefaultCase] = None


@dataclass
class ForStatement(Statement):
	statement: Statement = field()
	init: Optional[Statement] = None
	condition: Optional[Statement] = None
	update: Optional[Statement] = None


@dataclass
class ForeachVar(SquirrelNode):
	pass


@dataclass
class ForeachStatement(Statement):
	key: ForeachVar = field()
	container: Expression = field()
	statement: Statement = field()


@dataclass
class KeyOnlyVar(ForeachVar):
	key: str = field()


@dataclass
class KeyValVar(ForeachVar):
	key: str = field()
	val: str = field()


@dataclass
class BreakStatement(Statement):
	pass


@dataclass
class ContinueStatement(Statement):
	pass


@dataclass
class ReturnStatement(Statement):
	expression: Optional[Expression] = None


@dataclass
class YieldStatement(Statement):
	expression: Optional[Expression] = None


# --- Declarations -----------------------------------------------------------

@dataclass
class LocalVariable(Statement):
	inits: List[Init] = field(default_factory=list)


@dataclass
class LocalFunction(Statement):
	statement: Statement = field()
	args: Args = field()


@dataclass
class LocalFunction(Statement):
	name: Funcname = field()
	statement: Statement = field()
	args: Args = field()


@dataclass  # todo
class ClassName(SquirrelNode):
	identifiers: List[str] = field(default_factory=list)


class MemberDeclare(SquirrelNode):
	pass  # todo


@dataclass  # todo
class ClassDeclare(Statement):
	className: ClassName = field()
	extends: Optional[ClassName] = None
	members: List[MemberDeclare] = field(default_factory=list)


class MemberStaticDeclare(MemberDeclare):
	pass  # todo


class MemberArrayDeclare(MemberDeclare):
	pass  # todo


class MemberFunctionDeclare(MemberDeclare):
	pass  # todo


class MemberConstructorDeclare(MemberDeclare):
	pass  # todo


@dataclass
class TryCatch(Statement):
	tryStatement: Statement = field()
	statement: Statement = field()
	identifier: Optional[str] = None


@dataclass
class ThrowStatement(Statement):
	expression: Expression = field()


@dataclass
class ConstStatement(Statement):
	identifier: str = field()
	literal: Literal = field()


@dataclass
class IndexAssign(SquirrelNode):
	id: Expression = field()
	key: Expression = field()
	expr: Expression = field()


@dataclass
class Enumeration(SquirrelNode):
	name: str = field()
	const: Literal = field()


@dataclass
class EnumStatement(SquirrelNode):
	name: str = field()
	values: List[Enumeration] = field(default_factory=list)


# --- Expressions ------------------------------------------------------------
@dataclass
class LiteralExpression(Expression):
	literal: Literal = field()


@dataclass
class Identifier(Expression):
	name: str = field()

	def __str__(self):
		return self.name


@dataclass
class ParenExpression(Expression):
	expr: Expression = field()


class TableSlot(SquirrelNode):
	@property
	def key(self):
		if isinstance(self, BasicTableSlot):
			return self.name
		if isinstance(self, ArrayTableSlot):
			return self.index
		if isinstance(self, JsonTableSlot):
			return self.name.value
		return None


@dataclass
class TableConstruction(SquirrelNode):
	slots: List[TableSlot] = field(default_factory=list)


@dataclass
class ArrayConstruction(Expression):
	expressions: List[Expression] = field(default_factory=list)


@dataclass
class FunctionDeclare(Expression):
	name: Funcname = field()
	statement: Statement = field()
	args: Optional[Args] = None


@dataclass
class AnonymousFunction(Expression):
	statement: Statement = field()
	args: Optional[Args] = None


@dataclass
class Lambda(Expression):
	expr: Expression = field()
	args: Optional[Args] = None


@dataclass
class BaseExpression(Expression):
	name: str = field()
	expressions: List[Expression] = field(default_factory=list)


@dataclass
class ScopeAccess(Expression):
	name: str = field()


@dataclass
class DotAccess(Expression):
	expr: Expression = field()
	name: str = field()


@dataclass
class IndexAccess(Expression):
	expr: Expression = field()
	index: Expression = field()


@dataclass
class FunctionCall(Expression):
	expr: Expression = field()
	param: List[Expression] = field(default_factory=list)


@dataclass
class PostincrementOp(Expression):
	expr: Expression = field()


@dataclass
class PostdecrementOp(Expression):
	expr: Expression = field()


@dataclass
class CloneExpression(Expression):
	expr: Expression = field()


@dataclass
class ResumeExpression(Expression):
	expr: Expression = field()


@dataclass
class DeleteOperation(Expression):
	expr: Expression = field()


@dataclass
class UnaryMinusOp(Expression):
	expr: Expression = field()

	@property
	def real_value(self):
		return -self.expr.real_value

@dataclass
class BitwiseNotOp(Expression):
	expr: Expression = field()


@dataclass
class LogicalNotOp(Expression):
	expr: Expression = field()


@dataclass
class TypeofOp(Expression):
	expr: Expression = field()


@dataclass
class PreincrementOp(Expression):
	expr: Expression = field()


@dataclass
class PredecrementOp(Expression):
	expr: Expression = field()


# Binary operations
@dataclass
class DivideOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class MultiplyOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class ModuloOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class AddOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class SubOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class LeftShiftOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class RightShiftOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class RightUnsignedShiftOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class LessOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class LessEqualOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class GreaterOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class GreaterEqualOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class EqualOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class NotEqualOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class CompareOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class BitwiseAndOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class BitwiseXOROp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class BitwiseOrOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class LogicalAndOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class InOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class LogicalOrOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class InstanceofOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class TernaryOp(Expression):
	condition: Expression = field()
	expression: Expression = field()
	else_expression: Expression = field()


# Assignment
@dataclass
class Newslot(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class AssignOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class MulEqualOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class DivEqualOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class ModEqualOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class AddEqualOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


@dataclass
class SubEqualOp(Expression):
	lhs: Expression = field()
	rhs: Expression = field()


# --- Table slots ------------------------------------------------------------


@dataclass
class BasicTableSlot(TableSlot):
	name: str = field()
	expr: Expression = field()


@dataclass
class ArrayTableSlot(TableSlot):
	index: Expression = field()
	expr: Expression = field()


@dataclass
class JsonTableSlot(TableSlot):
	name: StringLiteral = field()
	expr: Expression = field()


@dataclass
class FunctionTableSlot(TableSlot):
	name: Funcname = field()
	statement: Statement = field()
	args: Args = field()
