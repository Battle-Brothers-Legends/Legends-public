::FU.Class.TooltipsSystem <- class extends ::FU.Class.System
{
	Mods = null;

	constructor()
	{
		base.constructor(::FU.SystemID.Tooltips);
		this.Mods = {};
	}

		function registerMod( _mod )
		{
			base.registerMod(_mod);
			_mod.Tooltips = ::FU.Class.TooltipsModAddon(_mod);
			local id = _mod.getID();
			local tableRef = {};
			this.Mods[id] <- tableRef;
			// Provide common aliases to tolerate casing differences in callers
			this.Mods[id.tolower()] <- tableRef;
			if (id == "mod_fu") this.Mods["mod_FU"] <- tableRef;
		}

	function setTooltips( _modID, _tooltipTable )
	{
		this.__addTable(this.Mods[_modID], _tooltipTable);
	}

	function __addTable( _currentTable, _tableToAdd )
	{
		foreach (key, value in _tableToAdd)
		{
			if (!(key in _currentTable) && typeof value == "table")
			{
				_currentTable[key] <- {};
				this.__addTable(_currentTable[key], value);
			}
			else
			{
				_currentTable[key] <- value;
			}
		}
	}

		function getTooltip( _modID, _identifier )
		{
			local id = _modID;
			if (!(id in this.Mods) && typeof id == "string")
			{
				local lower = id.tolower();
				if (lower in this.Mods) id = lower;
			}
			local fullKey = split(_identifier, ".");
			local currentTable = this.Mods[id];
			for (local i = 0; i < fullKey.len(); ++i)
			{
				currentTable = currentTable[fullKey[i]];
			}
			return currentTable;
		}
}
