::Legends.Array <- {};

/*
	Returns true if AT LEAST ONE element matches the predicate
	@param _predicate - lambda, anonymous function or reference to function
*/
::Legends.Array.any <- function (_array, _predicate) {
	foreach (item in _array) {
		if (_predicate(item)) {
			return true;
		}
	}
	return false;
}

/*
	Returns true only if EVERY element matches the predicate
	@param _predicate - lambda, anonymous function or reference to function
*/
::Legends.Array.all <- function (_array, _predicate) {
	foreach (item in _array) {
		if (!_predicate(item)) {
			return false;
		}
	}
	return true; // empty array will also be true
}

::Legends.Array.extend <- @(_array, _item, _count = 1) _array.extend(array(_count, _item));

::Legends.Array.rollWeighted <- function (_array) {
	local candidates = _array.filter(@(_, t) t[0] > 0);
	if (!candidates.len())
		return null;
	local totalWeight = candidates.map(@(t) t[0]).reduce(@(p, c) p + c);
	local r = ::Math.rand(0, totalWeight);
	local selected = candidates.filter(@(_, t)(r -= t[0]) <= 0);
	if (!selected.len())
		return null;
	return selected[0];
}

::Legends.Array.rand <- @(_array) (_array.len() ? _array(::Math.rand(0, _array.len() - 1)) : null);