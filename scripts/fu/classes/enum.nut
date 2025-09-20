::FU.Class.Enum <- class
{
	__Keys = null;
	__ValueKeyArray = null;

	constructor( _array = null )
	{
		this.__Keys = {};
		this.__ValueKeyArray = [];
		if (_array != null) this.addArray(_array);
	}

	function __isValidKey( _key )
	{
		return typeof _key == "string" && _key != "" && _key.slice(0,1).tolower() != _key.slice(0,1);
	}

	function add( _key )
	{
		if (!this.__isValidKey(_key))
		{
			::logError("FU Enum Keys must be non-empty strings and start with a capitalized letter");
			throw ::FU.Exception.InvalidValue(_key);
		}
		if (_key in this.__Keys)
		{
			::logError("FU Enum Keys must be unique");
			throw ::FU.Exception.InvalidValue(_key);
		}
		this.__Keys[_key] <- this.__Keys.len();
		this.__ValueKeyArray.push(_key);
	}

	function addArray( _array )
	{
		foreach (value in _array) this.add(value);
	}

	function getKeyForValue( _value )
	{
		return this.__ValueKeyArray[_value];
	}

	function len()
	{
		return this.__Keys.len();
	}

	function contains( _value )
	{
		::FU.requireInt(_value);
		return _value >= 0 && _value < this.len();
	}

	function _get( _key )
	{
		if (_key in this.__Keys) return this.__Keys[_key];
		throw null;
	}

	function _cloned( _original )
	{
		this.__Keys = _original.__Keys;
		this.__ValueKeyArray = _original.__ValueKeyArray;
	}

	function _nexti( _prev )
	{
		if (_prev == null) return this.__ValueKeyArray[0];
		return this.__Keys[_prev] < this.len() - 1 ? this.__ValueKeyArray[this.__Keys[_prev] + 1] : null;
	}
}
