::FU.Class.ModSettingsSystem <- class extends ::FU.Class.System
{
	Panels = null;
	Locked = null;
	Screen = null; //settings_screen

	constructor()
	{
		base.constructor(::FU.SystemID.ModSettings);
		this.Locked = false;
		this.Panels = ::FU.Class.OrderedMap();
	}

		function registerMod( _mod )
		{
			base.registerMod(_mod);
			
			_mod.ModSettings = ::FU.Class.ModSettingsModAddon(_mod);
			local panel = ::FU.Class.SettingsPanel(_mod.getID(), _mod.getName());
			panel.setMod(_mod);
			local id = _mod.getID();
			this.Panels[id] <- panel;
			this.Panels[id.tolower()] <- panel;
			if (id == "mod_fu") this.Panels["mod_FU"] <- panel;
			::logInfo("FU ModSettings: registered panel for mod '" + id + "' (panel id: " + panel.getID() + ")");
		}

	function addPanel( _modPanel )
	{
		if (this.Locked)
		{
			::logError("Settings Manager is Locked, no more settings can be added");
		}
		else
		{
			if (!(_modPanel instanceof ::FU.Class.SettingsPanel))
			{
				throw ::FU.Exception.InvalidType(_modPanel);
			}
			this.Panels[_modPanel.getID()] <- _modPanel;
		}
	}

		function getPanel( _id )
		{
			if (this.Panels.contains(_id)) return this.Panels[_id];
			if (typeof _id == "string" && this.Panels.contains(_id.tolower())) return this.Panels[_id.tolower()];
			return null;
		}

	function getPanels()
	{
		return this.Panels;
	}

		function hasPanel( _id )
		{
			if (this.Panels.contains(_id)) return true;
			if (typeof _id == "string") return this.Panels.contains(_id.tolower());
			return false;
		}

	function getAllElementsAsArray( _filter = null )
	{
		local ret = [];
		foreach (panel in this.getPanels())
		{
			ret.extend(panel.getAllElementsAsArray(_filter));
		}
		return ret;
	}

        function finalize()
        {
            this.Locked = true;
            local function prioritySort(_id1, _panel1, _id2, _panel2)
            {
                local function prio(_id)
                {
                    if (_id == "mod_legends") return -100;
                    if (_id == "mod_fu" || _id == "mod_FU") return 100;
                    return 0;
                }
                local d = prio(_id1) - prio(_id2);
                if (d != 0) return d;
                return _panel1.getName() <=> _panel2.getName();
            }
            this.Panels.sort(prioritySort);
            local idx = 0;
            foreach (panel in this.Panels)
            {
                panel.Order = idx;
                idx++
            }
        }

	function updateSettingsFromJS( _data )
	{
		/*
		_data = {
			modID = {
				settingID =
				{
					type,
					value
				}
			}
		}
		*/
		foreach (modID, panel in _data)
		{
			foreach (settingID, data in panel)
			{
				this.updateSettingFromJS({
					mod = modID,
					id = settingID,
					type = data.type,
					value = data.value
				});
			}
		}
	}

		function onSettingPressed( _data )
		{
			local panel = this.getPanel(_data.modID);
			if (panel == null) throw ::FU.Exception.KeyNotFound(_data.modID);
			local setting = panel.getSetting(_data.settingID);
			setting.onPressedCallback();
		}

		function setSettingFromPersistence( _modID, _settingID, _value )
		{
			if (!this.hasPanel(_modID))
			{
				::FU.Mod.Debug.printWarning(format("The mod %s has been removed", _modID), "debug");
				return;
			}
			local panel = this.getPanel(_modID);
			if (!panel.hasSetting(_settingID))
			{
				::FU.Mod.Debug.printWarning(format("Mod %s no longer has the setting %s", _modID, _settingID), "debug");
				return;
			}
			::getModSetting(panel.getID(), _settingID).set(_value, true, false, true);
		}

	function updateSettingFromJS( _data )
	{
		if (_data.type == "float") _data.value = _data.value.tofloat();
		::getModSetting(_data.mod, _data.id).set(_data.value);
	}

	function updateSettingInJS( _modID, _settingID, _value )
	{
		this.Screen.updateSettingInJS( _modID, _settingID, _value );
	}

	function callPanelsFunction( _function, _argsArray )
	{
		_argsArray.insert(0, null);

		foreach (panel in this.Panels)
		{
			_argsArray[0] = panel;
			panel[_function].acall(_argsArray);
		}
	}

	function importPersistentSettings()
	{
		::FU.System.PersistentData.loadFileForEveryMod("ModSetting");
	}

	function flagSerialize( _out )
	{
		this.callPanelsFunction("flagSerialize", [_out]);
	}

	function flagDeserialize( _in )
	{
		this.callPanelsFunction("flagDeserialize", [_in]);
	}

	function getUIData( _flags = null )
	{
		local ret = {};
		foreach (panel in this.getPanels())
		{
			ret[panel.getID()] <- panel.getUIData(_flags);
		}
		return ret;
	}

	function isVisibleWithFlags( _flags )
	{
		foreach (panel in this.getPanels())
		{
			if (panel.verifyFlags(_flags)) return true;
		}
		return false;
	}

	function sortPanelsByName( _key1, _mod1, _key2, _mod2 )
	{
		return _mod1.getName() <=> _mod2.getName();
	}
}
