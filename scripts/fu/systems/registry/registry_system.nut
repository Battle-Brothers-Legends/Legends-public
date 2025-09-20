::FU.Class.RegistrySystem <- class extends ::FU.Class.System
{
	static ModSources = {};
	static ModSourceDomain = ::FU.Class.Enum([
		"GitHub",
		"NexusMods"
	]);
	Mods = null;
	constructor()
	{
		base.constructor(::FU.SystemID.Registry);
		this.Mods = {};
	}

	function addNewModSource( _modSource )
	{
		::FU.requireInstanceOf(::FU.Class.ModSource, _modSource.instance());
		this.ModSources[_modSource.ModSourceDomain] <- _modSource;
	}

		function addMod( _mod )
		{
			local id = _mod.getID();
			this.Mods[id] <- _mod;
			this.Mods[id.tolower()] <- _mod;
			if (id == "mod_fu") this.Mods["mod_FU"] <- _mod;
			_mod.Registry = ::FU.Class.RegistryModAddon(_mod);
			::logInfo(format("<span style=\"color: green;\">FU registered <span style=\"color: white;\">%s</span>, version: <span style=\"color: white;\">%s</span></span>", _mod.getName(), _mod.getVersionString()));
		}

	function registerMod( _mod )
	{
		if (_mod.getID() != ::FU.VanillaID)
		{
			if (_mod.getID() in this.Mods)
			{
				::logError("Duplicate Mod ID for mod: " + _mod.getID());
				throw ::FU.Exception.DuplicateKey(_mod.getID());
			}
			if (::mods_getRegisteredMod(_mod.getID()) == null)
			{
				::logError("Register your mod using the same ID with mod_hooks before creating a ::FU.Class.Mod");
				throw ::FU.Exception.KeyNotFound(_mod.getID());
			}
			if (::mods_getRegisteredMod(_mod.getID()).SemVer == null || ::FU.SemVer.getVersionString(::mods_getRegisteredMod(_mod.getID()).SemVer) != _mod.getVersionString())
			{
				::logError("Register your mod using the same version with mod_hooks before creating a ::FU.Class.Mod");
				throw ::FU.Exception.InvalidValue(_mod.getVersionString());
			}
		}

		this.addMod(_mod);
	}

	function getModsForUpdateCheck()
	{
		local ret = {};
		foreach (mod in this.Mods)
		{
			if (mod.Registry.hasUpdateSource())
			{
				ret[mod.getID()] <- mod.Registry.getUpdateSource().getUpdateURL();
			}
		}
		return ret;
	}

	function checkIfModVersionsAreNew( _modVersions )
	{
		local modsWithNewVersions = {};
		foreach (modID, version in _modVersions)
		{
			local mod = ::FU.System.Registry.getMod(modID);
			if (!::FU.SemVer.isSemVer(version))
			{
				::FU.Popup.showRawText(format("The version '%s' from the mod %s (%s) isn't using <span style=\"color: lightblue; text-decoration: underline;\" onclick=\"openURL('https://semver.org')\">semantic versioning</span> for its online versions, despite registering to use the FU update checker. Let the mod author know if you see this error", version,  mod.getName(), modID));
				continue;
			}
			if (!::FU.SemVer.compareVersionWithOperator(version, ">", mod)) continue;
			local type = "PATCH";
			if (::FU.SemVer.compareMajorVersionWithOperator(version, ">", mod)) type = "MAJOR";
			else if (::FU.SemVer.compareMinorVersionWithOperator(version, ">", mod)) type = "MINOR";
			local modUpdateInfo = {
				name = mod.getName(),
				currentVersion = mod.getVersionString(),
				availableVersion = version,
				updateType = type,
				sources = {},
			};
			foreach (modSource in mod.Registry.__ModSources)
			{
				modUpdateInfo.sources[::FU.System.Registry.ModSourceDomain.getKeyForValue(modSource.ModSourceDomain)] <- modSource.getURL();
			}
			modsWithNewVersions[modID] <- modUpdateInfo;
		}
		if (modsWithNewVersions.len() > 0) ::FU.Popup.showModUpdates(modsWithNewVersions);
	}

		function getMod( _modID )
		{
			local id = _modID;
			if (!(id in this.Mods) && typeof id == "string")
			{
				local lower = id.tolower();
				if (lower in this.Mods) id = lower;
			}
			if (!(id in this.Mods))
			{
				::logError("Mod " + id + " not found in FU! Did you forget to create a Mod Object via ::FU.Class.Mod?");
				throw ::FU.Exception.KeyNotFound(id);
			}
			return this.Mods[id];
		}

		function hasMod( _modID )
		{
			if (_modID in this.Mods) return true;
			if (typeof _modID == "string") return (_modID.tolower() in this.Mods);
			return false;
		}
}
