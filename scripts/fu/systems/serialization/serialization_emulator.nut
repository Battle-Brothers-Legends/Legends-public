// enulates the _out object passed to onSerialize functions
::FU.Class.SerializationEmulator <- class extends ::FU.Class.SerDeEmulator
{
	IsIncremental = false;

	function setIncremental( _bool )
	{
		this.IsIncremental = _bool;
	}

	function __writeData( _data )
	{
		this.Data.push(_data);
		if (this.IsIncremental)
		{
			local startString = this.getEmulatorString();
			this.FlagContainer.set(startString, this.Data.len());
			this.FlagContainer.set(startString + "." + (this.Data.len() - 1), _data);
		}
	}

	function writeString( _string )
	{
		this.__writeData(_string);
	}

	function __writeInt( _int )
	{
		this.__writeData(_int);
	}

	function __writeFloat( _float )
	{
		this.__writeData(_float);
	}

	function writeBool( _bool )
	{
		this.__writeData(_bool);
	}

	function writeI32( _int )
	{
		this.__writeInt(_int);
	}

	function writeU32( _int )
	{
		this.__writeInt(_int);
	}

	function writeI16( _int )
	{
		this.__writeInt(_int);
	}

	function writeU16( _int )
	{
		this.__writeInt(_int);
	}

	function writeI8( _int )
	{
		this.__writeInt(_int);
	}

	function writeU8( _int )
	{
		this.__writeInt(_int);
	}

	function writeF32( _float )
	{
		this.__writeFloat(_float);
	}

	function storeDataInFlagContainer()
	{
		if (this.IsIncremental)
		{
			::logError("Called storeDataInFlagContainer for an Incremental SerializationEmulator");
			throw ::FU.Exception.InvalidValue();
		}
		local startString = this.getEmulatorString();
		this.FlagContainer.set(startString, this.Data.len());
		foreach (idx, element in this.Data)
		{
			this.FlagContainer.set(startString + "." + idx, element);
		}
	}
}
