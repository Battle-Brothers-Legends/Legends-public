::FU.String <- {
	function capitalizeFirst( _string )
	{
		if (_string == "") return _string;
		return _string.slice(0, 1).toupper() + _string.slice(1);
	}

	function replace( _string, _find, _replace, _all = false )
	{
		if (_all) return ::String.replace(_string, _find, _replace);
		local idx = _string.find(_find);
		if (idx != null)
		{
			return _string.slice(0, idx) + _replace + _string.slice(idx + _find.len());
		}
		return _string;
	}

	function isInteger( _string )
	{
		foreach (char in _string)
		{
			if (char < 48 || char > 57) return false;
		}
		return true;
	}

	function startsWith( _string, _start )
	{
		return _string.find(_start) == 0;
	}

	function endsWith( _string, _end )
	{
		return _end.len() <= _string.len() && _string.slice(-_end.len()) == _end;
	}
}
