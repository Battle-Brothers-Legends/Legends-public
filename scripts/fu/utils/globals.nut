::FU.isNull <- function( _object )
{
	return _object == null || (typeof _object == "instance" && _object instanceof ::WeakTableRef && _object.isNull());
}

::FU.getField <- function( _object, _key )
{
	if (typeof _object == "instance")
	{
		if (_object instanceof ::WeakTableRef)
		{
			if (_object.isNull())
			{
				::printError("The table inside the WeakTableRef instance is null");
				throw ::FU.Exception.KeyNotFound(_object);
			}
			_object = _object.get();
		}
		else throw ::FU.Exception.InvalidType(_object);
	}

	_object = _object.m;

	do
	{
		if (_key in _object) return _object[_key];
		_object = _object.getdelegate();
	}
	while(_object != null);

	throw ::FU.Exception.KeyNotFound(_key);
}

::FU.getMember <- function( _object, _key )
{
	if (typeof _object == "instance")
	{
		if (_object instanceof ::WeakTableRef)
		{
			if (_object.isNull())
			{
				::printError("The table inside the WeakTableRef instance is null");
				throw ::FU.Exception.KeyNotFound(_object);
			}
			_object = _object.get();
		}
		else throw ::FU.Exception.InvalidType(_object);
	}

	do
	{
		if (_key in _object) return _object[_key];
		_object = _object.getdelegate();
	}
	while(_object != null);

	throw ::FU.Exception.KeyNotFound(_key);
}

::FU.isIn <- function( _member, _object, _chain = false )
{
	if (_object == null) return false;
	switch (typeof _object)
	{
		case "instance":
			if (!(_object instanceof ::WeakTableRef)) return _member in _object;
			if (_object.isNull()) return false;
			_object = _object.get();
		case "table":
			if (!_chain) return _member in _object;
			do
			{
				if (_member in _object) return true;
				_object = _object.getdelegate();
			}
			while(_object != null);
			return false;

		case "array":
			return _object.find(_member) != null;

		default:
			return false;
	}

	return false;
}

::FU.isKindOf <- function( _object, _className )
{
	if (_object == null || _className == null) return false;
	if (typeof _object == "instance" && _object instanceof ::WeakTableRef)
	{
		if (_object.isNull()) return false;
		_object = _object.get();
	}

	return ::isKindOf(_object, _className);
}

::FU.asWeakTableRef <- function( _object )
{
	if (typeof _object == "instance")
	{
		if (_object instanceof ::WeakTableRef) return _object;
		throw ::FU.Exception.InvalidType(_object);
	}
	return ::WeakTableRef(_object);
}

::FU.regexMatch <- function( _capture, _string, _group )
{
	return _capture[_group].end > 0 && _capture[_group].begin < _string.len() ? _string.slice(_capture[_group].begin, _capture[_group].end) : null;
}

::FU.isEqual <- function( _1, _2 )
{
	if (typeof _1 == "instance" && _1 instanceof ::WeakTableRef) _1 = _1.get();
	if (typeof _2 == "instance" && _2 instanceof ::WeakTableRef) _2 = _2.get();

	return _1 == _2;
}

::FU.isBBObject <- function( _object, _allowWeakTableRef = true )
{
	if (typeof _object == "instance" && _object instanceof ::WeakTableRef && _allowWeakTableRef)
		_object = _object.get();
	return typeof _object == "table" && "_release_hook_DO_NOT_delete_it_" in _object;
}
