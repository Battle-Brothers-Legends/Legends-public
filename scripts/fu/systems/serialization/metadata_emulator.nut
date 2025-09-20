// emulates the metadata object that can be gotten from _in.getMetadata() or _out.getMetadata() during on(De)Serialize function calls
::FU.Class.MetaDataEmulator <- class
{
	Version = null;
	Data = null;
	constructor()
	{
		this.Data = {};
		this.Version = ::Const.Serialization.Version;
	}

	function getVersion()
	{
		return this.Version;
	}

	function setVersion( _version )
	{
		this.Version = _version;
	}

	function __getValue( _key )
	{
		return this.Data[_key];
	}

	function __setValue( _key, _value )
	{
		this.Data[_key] <- _value;
	}

	function getInt( _key )
	{
		return this.__getValue(_key);
	}

	function setInt( _key, _value)
	{
		::FU.requireInt(_value);
		this.__setValue(_key, _value);
	}

	function getString( _key )
	{
		return this.__getValue(_key);
	}

	function setString( _key, _value )
	{
		::FU.requireString(_value);
		this.__setValue(_key, _value);
	}

	function getFloat( _key )
	{
		return this.__getValue(_key);
	}

	function setFloat( _key, _value )
	{
		::FU.requireFloat(_value);
		this.__setValue(_key, _value);
	}

	function hasData( _key )
	{
		return _key in this.Data;
	}

	function getName() // dummy, doesn't return useful value
	{
		return "";
	}

	function getModificationDate() // dummy, doesn't return useful value
	{
		return "";
	}

	function getCreationDate() // dummy, doesn't return useful value
	{
		return "";
	}

	function getFileName() // dummy, doesn't return useful value
	{
		return "";
	}

	function _cloned( _original )
	{
		this.Data = clone _original.Data;
		this.Version = _original.Version;
	}
}
