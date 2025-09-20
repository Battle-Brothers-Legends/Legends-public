::FU.Class.SerializationModAddon <- class extends ::FU.Class.SystemModAddon
{
	function isSavedVersionAtLeast( _version, _metaData )
	{
		local savedVersion = _metaData.getString(this.Mod.getID() + "Version");
		return savedVersion != "" && ::FU.SemVer.compareVersionWithOperator(savedVersion, ">=", _version);
	}

	function flagSerialize( _id, _object, _flags = null )
	{
		::FU.System.Serialization.flagSerialize(this.Mod, _id, _object, _flags);
	}

	function flagDeserialize( _id, _defaultValue, _object = null, _flags = null )
	{
		return ::FU.System.Serialization.flagDeserialize(this.Mod, _id, _defaultValue, _object, _flags);
	}

	function getDeserializationEmulator( _id, _flags = null )
	{
		return ::FU.System.Serialization.getDeserializationEmulator(this.Mod, _id, _flags);
	}

	function getSerializationEmulator( _id, _flags = null )
	{
		return ::FU.System.Serialization.getSerializationEmulator(this.Mod, _id, _flags);
	}
}
