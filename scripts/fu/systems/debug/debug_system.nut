::FU.Class.DebugSystem <- class extends ::FU.Class.System
{
	Mods = null;
	FullDebug = null;
	static LogType = {
		Info = 1,
		Warning = 2,
		Error = 3
	};
	static DefaultFlag = "default";

	constructor()
	{
		base.constructor(::FU.SystemID.Log);
		this.Mods = {};
		this.FullDebug = false;
	}

	function registerMod( _mod )
	{
		base.registerMod(_mod);
		if (_mod.getID() in this.Mods)
		{
			throw ::FU.Exception.DuplicateKey(_mod.getID());
		}

		_mod.Debug = ::FU.Class.DebugModAddon(_mod);
		this.Mods[_mod.getID()] <- {};
		this.setFlag(_mod.getID(), this.DefaultFlag, false);
	}

	function setFlag( _modID, _flagID, _flagBool )
	{
		if (!(_modID in this.Mods))
		{
			::logError(::FU.Error.ModNotRegistered(_modID));
			throw ::FU.Exception.KeyNotFound(_modID);
		}
		this.Mods[_modID][_flagID] <- _flagBool;
		if (_flagBool == true)
		{
			if (_modID == ::FU.ID && _flagID == this.DefaultFlag)
			{
				::FU.Mod.Debug.printWarning(format("Debug flag '%s' set to true for mod '%s'.", _flagID, _modID), "default");
			}
			else
			{
				::FU.Mod.Debug.printWarning(format("Debug flag '%s' set to true for mod '%s'.", _flagID, _modID), "debug");
			}
		}
	}

	function setFlags( _modID, _flagTable )
	{
		foreach (flagID, flagBool in _flagTable)
		{
			this.setFlag(_modID, flagID, flagBool);
		}
	}

	function setAllFlags( _modID, _bool)
	{
		foreach (flagID, _ in this.Mods[_modID])
		{
			this.setFlag(_modID, flagID, _bool);
		}
	}

	function isEnabledForMod( _modID, _flagID = "default" )
	{
		if (!(_modID in this.Mods))
		{
			::logError(::FU.Error.ModNotRegistered(_modID));
			throw ::FU.Exception.KeyNotFound(_modID);
		}
		if (!(_flagID in this.Mods[_modID]))
		{
			throw ::FU.Exception.KeyNotFound(_flagID);
		}
		return this.isFullDebug() || this.Mods[_modID][_flagID] == true;
	}

	function isFullDebug()
	{
		return this.FullDebug;
	}

	function setFullDebug( _bool )
	{
		this.FullDebug = _bool;
	}

	function print( _printText, _modID, _logType, _flagID = "default" )
	{
		if (!(_modID in this.Mods))
		{
			::logError(::FU.Error.ModNotRegistered(_modID));
			throw ::FU.Exception.KeyNotFound(_modID);
		}

		if (this.isEnabledForMod(_modID, _flagID))
		{
			local si = ::getstackinfos(3);
			local string = format("%s::%s -- %s::%s : %i<br>%s", _modID, _flagID, si.src, si.func == "unknown" ? "" : si.func, si.line, _printText)
			switch (_logType)
			{
				case this.LogType.Info:
					::logInfo(string);
					return;
				case this.LogType.Warning:
					::logWarning(string);
					return;
				case this.LogType.Error:
					::logError(string);
					return;
				default:
					::logError("No log type defined for this log: " + string);
					throw ::FU.Exception.KeyNotFound(_logType);
			}
		}
	}
}
