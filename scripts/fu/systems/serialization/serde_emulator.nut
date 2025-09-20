// Base for the Serialization and Deserialization Emulators
::FU.Class.SerDeEmulator <- class
{
	static __IDRegex = regexp("^.*\\.\\d+$")
	Data = null;
	Mod = null;
	ID = null;
	MetaData = null;
	FlagContainer = null;

	constructor(_mod, _id, _flagContainer, _metaDataEmulator = null)
	{
		if (_metaDataEmulator == null) _metaDataEmulator = clone ::FU.System.Serialization.MetaData;
		if (this.__IDRegex.match(_id))
		{
			::logError("the ID passed to flag serialization cannot end with a full stop followed by digits so it doesn't collide with internal FU flags");
			throw ::FU.Exception.InvalidValue(_id);
		}
		this.Data = [];
		this.Mod = _mod;
		this.ID = _id;
		this.FlagContainer = _flagContainer;
		this.MetaData = _metaDataEmulator;
	}

	function getEmulatorString()
	{
		return format("FU.%s.%s", this.Mod.getID(), this.ID);
	}

	function clearFlags()
	{
		local startString = this.getEmulatorString();
		this.FlagContainer.remove(startString);
		for (local i = 0; i < this.Data.len(); ++i)
		{
			this.FlagContainer.remove(startString + "." + i);
		}
	}

	function getMetaData()
	{
		return this.MetaData;
	}
}
