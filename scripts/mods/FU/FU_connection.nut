this.FU_connection <- ::inherit("scripts/mods/FU/js_connection", {
	m = {},

	function connect()
	{
		this.m.JSHandle = ::UI.connect("FUConnection", this);
		this.querySettingsData();
		this.checkForModUpdates();
	}

	function querySettingsData()
	{
		if (this.m.JSHandle != null)
		{
			local data = {
				keybinds = ::FU.System.Keybinds.getJSKeybinds(),
				settings = ::FU.System.ModSettings.getUIData()
			};
			this.m.JSHandle.asyncCall("onQuerySettingsData", data);
		}
	}

	function removeKeybind( _keybind )
	{
		if (this.m.JSHandle != null)
		{
			this.m.JSHandle.asyncCall("removeKeybind", _keybind.getUIData())
		}
	}

	function addKeybind( _keybind )
	{
		if (this.m.JSHandle != null)
		{
			this.m.JSHandle.asyncCall("addKeybind", _keybind.getUIData())
		}
	}

	function clearKeys()
	{
		if (this.m.JSHandle != null)
		{
			this.m.JSHandle.asyncCall("clearKeys", null);
		}
	}

	function checkForModUpdates()
	{
		if (this.m.JSHandle != null)
		{
			this.m.JSHandle.asyncCall("checkForModUpdates", ::FU.System.Registry.getModsForUpdateCheck());
		}
	}

	function receiveModVersions( _modVersions )
	{
		::FU.System.Registry.checkIfModVersionsAreNew(_modVersions);
	}
});
