::FU.Array <- {
	function rand( _array, _start = null, _end = null )
	{
		local len = _array.len();
		if (len == 0)
		{
			if (_start != null || _end != null) throw "indexing empty array";
			return null;
		}

		if (_start == null) _start = 0;
		else if (_start >= len || -_start > len)
		{
			::logError("starting index out of bounds");
			throw ::FU.Exception.InvalidValue(_start);
		}
		else if (_start < 0) _start = len + _start;

		if (_end == null) _end = len;
		else if (_end > len || -_end > len)
		{
			::logError("ending index out of bounds");
			throw ::FU.Exception.InvalidValue(_end);
		}
		else if (_end < 0) _end = len + _end;

		if (_start >= _end)
		{
			::logError("invalid indices: _start must be smaller than _end");
			throw ::FU.Exception.InvalidValue(_end);
		}

		return _array[::Math.rand(_start, _end - 1)];
	}


	// deprecated - use removeByValue instead
	function remove( _array, _item, _ignoreMissing = true )
	{
		local idx = _array.find(_item);
		if (idx == null)
		{
			if (!_ignoreMissing) throw ::FU.Exception.KeyNotFound(_item);
			return null;
		}
		else
		{
			return _array.remove(idx);
		}
	}

	function removeByValue( _array, _item )
	{
		local idx = _array.find(_item);
		if (idx != null) return _array.remove(idx);
	}

	function shuffle( _array )
	{
		for (local i = _array.len() - 1; i > 0; i--)
		{
			local j = ::Math.rand(0, i);

			local temp = _array[i];
			_array[i] = _array[j];
			_array[j] = temp;
		}
	}

	function sortDescending( _array, _member = null )
	{
		if (_member == null)
		{
			_array.sort(@(a, b) -1 * (a <=> b));
		}
		else
		{
			if (_array.len() != 0 && typeof _array[0][_member] == "function")
			{
				_array.sort(@(a, b) -1 * (a[_member]() <=> b[_member]()));
			}
			else
			{
				_array.sort(@(a, b) -1 * (a[_member] <=> b[_member]));
			}
		}
	}

	function sortAscending( _array, _member = null )
	{
		if (_member == null)
		{
			_array.sort();
		}
		else
		{
			if (_array.len() != 0 && typeof _array[0][_member] == "function")
			{
				_array.sort(@(a, b) a[_member]() <=> b[_member]());
			}
			else
			{
				_array.sort(@(a, b) a[_member] <=> b[_member]);
			}
		}
	}
}
