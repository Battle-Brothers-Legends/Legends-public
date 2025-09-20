// Apply FU hook wrappers unless a real MSU is present. The shim sets IsShim = true.
// Note: use getroottable() instead of 'in ::' which is invalid in Squirrel.
if (!("MSU" in getroottable()) || ("IsShim" in ::MSU))
{
::FU.QueueErrors <- {
	Errors = "",

	function add( _string )
	{
		::FU.requireString(_string);
		::logError(_string);
		this.Errors += _string + "<br><br>";
	}
}

local function getRegisteredModRef( _modID )
{
	foreach (mod in ::mods_getRegisteredMods())
	{
		if (mod.Name == _modID) return mod;
	}
}
local lastRegistered = null;

local mods_registerMod = ::mods_registerMod;
::mods_registerMod = function( _id, _version, _name = null, _extra = null )
{
	lastRegistered = _id;
	if (_extra == null) _extra = {};
	if (typeof _version == "string")
	{
		_extra.SemVer <- ::FU.SemVer.getTable(_version);
		_version = 2147483647; // 2^31-1 to make sure a semver version is always greater than an int/float one
	}
	else if (typeof _version == "float" || typeof _version == "integer")
	{
		_extra.SemVer <- null;
	}
	else
	{
		::logError("Mod \"" + _id + "\" is using an invalid version format. Mod version must be an integer, float or Semantic Version string.");
		throw ::FU.Exception.InvalidValue(_version);
	}

	_extra.Dependencies <- [];
	mods_registerMod(_id, _version, _name, _extra);
}

local hooks = getRegisteredModRef("mod_hooks");
hooks.SemVer <- null;
hooks.Dependencies <- [];

local mods_queue = ::mods_queue;
::mods_queue = function( _id, _expressions, _function )
{
	if (_id == null) _id = lastRegistered;
	local mod = getRegisteredModRef(_id);
	if (mod == null)
	{
		::logError("Mod " + _id + " not registered.");
		throw ::FU.Exception.KeyNotFound(_id);
	}
	if (_expressions != null && _expressions != "")
	{
		if (_id == null) _id = ::FU.Popup.LastRegistered;
		local expressions = split(_expressions, ",");
		_expressions = "";
		for (local i = 0; i < expressions.len(); ++i)
		{
			local queueRegex = regexp("^([!<>])?(\\w+)(?:\\(([<>]=?|=|!=)?([\\w\\.\\+\\-]+)\\))?$");
			local expression = strip(expressions[i]);
			local capture = queueRegex.capture(expression);
			if (capture == null)
			{
				::logError("Mod \"" + _id + "\" is using an invalid queue expression.");
				throw ::FU.Exception.InvalidValue(expression);
			}
			expressions[i] = {
				Operator = ::FU.regexMatch(capture, expression, 1),
				Name = ::FU.regexMatch(capture, expression, 2),
				VersionOperator = ::FU.regexMatch(capture, expression, 3),
				Version = ::FU.regexMatch(capture, expression, 4),
				SemVer = null
			}


			if (::FU.SemVer.isSemVer(expressions[i].Version))
			{
				expressions[i].SemVer = ::FU.SemVer.getTable(expressions[i].Version);
				expressions[i].Version = 2147483647;
			}
			else if (expressions[i].Version != null)
			{
				expressions[i].Version = expressions[i].Version.tofloat();
			}

			mod.Dependencies.push(expressions[i])
			if (expressions[i].Operator != "!")
			{
				_expressions += (expressions[i].Operator == null ? "" : expressions[i].Operator) + expressions[i].Name + ","
			}
			// then we recreate the expression without the version info
			// we do this for both semver and normal dependencies, because normal mod hooks doesn't handle ordering operations with version numbers, but we do
		}
		if (_expressions != "") _expressions = _expressions.slice(0,-1);
	}
	mods_queue(_id, _expressions, _function);
}

local _mods_runQueue = ::_mods_runQueue;
::_mods_runQueue = function()
{
	local function compareSemVerVersionsWithNulls(_version1, _operator, _version2)
	{
		local ret = _version1 == null ? -1 : _version2 == null ? 1 : null;
		if (ret != null) return ::FU.Utils.operatorCompare(ret, _operator)
		return ::FU.SemVer.compareVersionWithOperator(_version1, _operator, _version2);
	}

	local function compareVersions( _dependencyTable, _modTable )
	{
		if (_dependencyTable.SemVer == null && _modTable.SemVer == null) // both the mod and the depency are not SemVer
		{
			return ::FU.Utils.operatorCompare(_modTable.Version <=> _dependencyTable.Version, _dependencyTable.VersionOperator);
		}
		return compareSemVerVersionsWithNulls(_modTable.SemVer, _dependencyTable.VersionOperator, _dependencyTable.SemVer);
	}

	foreach (mod in ::mods_getRegisteredMods())
	{
		foreach (dependencyTable in mod.Dependencies)
		{
			local dependencyMod = ::mods_getRegisteredMod(dependencyTable.Name);
			// Treat MSU dependency as satisfied if FU's MSU shim is active
				if (dependencyMod == null && dependencyTable.Name == "mod_msu" && ("MSU" in getroottable()) && ("IsShim" in ::MSU))
			{
				// Fabricate a minimal mod record for version comparisons
				dependencyMod = { Name = "mod_msu", FriendlyName = "MSU (shim)", Version = 2147483647, SemVer = ::MSU.SemVer.getTable(::MSU.Version) };
			}
			// First check mod presence
			if (dependencyTable.Operator == "!")
			{
				if (dependencyMod != null)
				{
					if (dependencyTable.Version == null)
					{
						::FU.QueueErrors.add(mod.FriendlyName + " is not compatible with " + dependencyMod.FriendlyName);
						continue; // Incompatible mod present
					}
					else if (compareVersions(dependencyTable, dependencyMod))
					{
						local tableVersion = dependencyTable.SemVer == null ? dependencyTable.Version : ::FU.SemVer.getVersionString(dependencyTable.SemVer);
						::FU.QueueErrors.add(mod.FriendlyName + " is not compatible with " + dependencyMod.FriendlyName + " version " + dependencyTable.VersionOperator + tableVersion);
						continue; // Incompatible mod version present
					}
					else
					{
						continue; // Incompatible mod version is acceptable
					}
				}
				continue; // Incompatible mod missing
			}
			else if (dependencyTable.Operator == null)
			{
				if (dependencyMod == null)
				{
					switch (dependencyTable.Name)
					{
						case "dlc_lindwurm":
							dependencyTable.Name = "DLC: Lindwurm";
							break;

						case "dlc_unhold":
							dependencyTable.Name = "DLC: Beasts & Exploration";
							break;

						case "dlc_wildmen":
							dependencyTable.Name = "DLC: Warriors of the North";
							break;

						case "dlc_desert":
							dependencyTable.Name = "DLC: Blazing Deserts";
							break;

						case "dlc_paladins":
							dependencyTable.Name = "DLC: Of Flesh and Faith";
							break;
					}
					::FU.QueueErrors.add(mod.FriendlyName + " requires " + dependencyTable.Name);
					continue; // Required mod missing
				}
			}
			else if (dependencyMod == null)
			{
				continue; // Non-required mod missing
			}

			// Then check version
			if (dependencyTable.Version == null)
			{
				continue; // Doesn't require a specific version
			}
			else if (!compareVersions(dependencyTable, dependencyMod))
			{
				local tableVersion = dependencyTable.SemVer == null ? dependencyTable.Version : ::FU.SemVer.getVersionString(dependencyTable.SemVer);
				local modVersion = dependencyMod.SemVer == null ? dependencyMod.Version : ::FU.SemVer.getVersionString(dependencyMod.SemVer);
				::FU.QueueErrors.add(mod.FriendlyName + " requires " + dependencyMod.FriendlyName + " version " + dependencyTable.VersionOperator + tableVersion + " but version " + modVersion + " was found");
				continue; // Incompatible mod version
			}
			else
			{
				continue; // Compatible mod version
			}
		}
	}

	if (::FU.QueueErrors.Errors != "")
	{
		::FU.Popup.showRawText(::FU.QueueErrors.Errors, true);
		throw ::FU.QueueErrors.Errors;
	}

	_mods_runQueue();

	if (::FU.QueueErrors.Errors != "")
	{
		::FU.Popup.showRawText(::FU.QueueErrors.Errors, true);
		throw ::FU.QueueErrors.Errors;
	}
}
}
