::FU.Class.ModSettingsModAddon <- class extends ::FU.Class.SystemModAddon
{
	function getPanel()
	{
		return ::FU.System.ModSettings.getPanel(this.Mod.getID());
	}

	function getPage( _pageID )
	{
		return this.getPanel().getPage(_pageID);
	}

		function addPage( _pageID, _pageName = null )
		{
			local page = ::FU.Class.SettingsPage(_pageID, _pageName);
			this.getPanel().addPage(page);
			::logInfo("FU ModSettings: mod '" + this.Mod.getID() + "' added page '" + page.getID() + "' (name: " + page.getName() + ")");
			return page;
		}

	function getSetting( _settingID )
	{
		return ::FU.System.ModSettings.getPanel(this.Mod.getID()).getSetting(_settingID);
	}

	function getAllElementsAsArray( _filter = null )
	{
		return this.getPanel().getAllElementsAsArray(_filter);
	}

	function resetSettings()
	{
		return this.getPanel().resetSettings();
	}

	function hasSetting( _settingID )
	{
		return ::FU.System.ModSettings.getPanel(this.Mod.getID()).hasSetting(_settingID);
	}	

	function lockSetting( _setting, _lockReason )
	{
		if (typeof _setting == "string") _setting = this.getSetting(_setting);

		_setting.lock(_lockReason + format(" (%s (%s))", this.getMod().getID(), this.getMod().getName()));
	}
}
