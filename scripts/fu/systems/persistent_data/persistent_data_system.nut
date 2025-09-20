::FU.Class.PersistentDataSystem <- class extends ::FU.Class.System
{
	Mods = null;
	ModConfigPath = "mod_config/";
	Separator = "@"

	constructor()
	{
		base.constructor(::FU.SystemID.PersistentData);
		this.Mods = {};
	}

	function registerMod( _mod )
	{
		base.registerMod(_mod);

		_mod.PersistentData = ::FU.Class.PersistentDataModAddon(_mod);
		this.addMod(_mod.getID());
		this.importModFiles(_mod.getID());
	}

	function importModFiles( _modID )
	{
		local persistentDirectory = ::IO.enumerateFiles(this.ModConfigPath + _modID);
		if (persistentDirectory == null)
		{
			return;
		}
		foreach (file in persistentDirectory)
		{
			local components = split(file, "/");
			local modID = components[1];
			local fileType = components[2];
			# ::FU.Mod.Debug.printWarning(format("Checking file, potential modID: '%s' and fileType '%s'.", modID, fileType), "persistence");
			this.Mods[_modID][fileType] <- file;
		}
	}

		function addMod( _modID, _reset = false )
		{
			local id = _modID;
			if (typeof id == "string") id = id.tolower();
			if (this.hasMod(id) && _reset == false)
			{
				return;
			}
			this.Mods[id] <- {};
		}

		function hasMod( _modID )
		{
			if (_modID in this.Mods) return true;
			if (typeof _modID == "string") return (_modID.tolower() in this.Mods);
			return false;
		}

		function getMod( _modID )
		{
			local id = _modID;
			if (!this.hasMod(id) && typeof id == "string" && this.hasMod(id.tolower())) id = id.tolower();
			if (!this.hasMod(id))
			{
				::logError("Mod " + id + " not found in mods!");
				throw ::FU.Exception.KeyNotFound(id);
			}
			return this.Mods[id];
		}

		function loadFileForMod( _modID, _fileID )
		{
			::FU.Mod.Debug.printWarning(format("Loading file '%s' for mod '%s'.", _fileID, _modID), "persistence");
			local id = _modID;
			if (typeof id == "string" && !(id in this.Mods) && (id.tolower() in this.Mods)) id = id.tolower();
			if (_fileID in this.getMod(id))
			{
				::include(this.getMod(id)[_fileID]);
				return true;
			}
			return false;
		}

	function loadFileForEveryMod( _fileID )
	{
		foreach (modID, modValue in this.Mods)
		{
			this.loadFileForMod(modID, _fileID);
		}
	}

	function loadAllFilesForMod( _modID )
	{
		if (!this.hasMod(_modID))
		{
			::logError("Mod " + _modID + " not found in mods!");
			throw ::FU.Exception.KeyNotFound(_modID);
		}

		foreach (file in this.getMod(_modID))
		{
			this.loadFileForMod(_modID, file);
		}
	}

	function writeToLog( _fileID, _modID, _payload )
	{
		local result = format("%sBBPARSER%s%s%s%s", this.Separator, this.Separator, _fileID, this.Separator, _modID);
		if (typeof _payload != "array")
		{
			_payload = [_payload];
		}
		foreach (arg in _payload)
		{
			::FU.requireAnyTypeExcept(["array", "table", "class"], arg)
			result += this.Separator + arg;
		}
		result += this.Separator
		::logInfo(result);
	}
}
