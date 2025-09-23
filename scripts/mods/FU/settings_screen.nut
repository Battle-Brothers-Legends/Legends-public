this.settings_screen <- ::inherit("scripts/mods/FU/ui_screen", {
	m = {
		MenuStack = null,
		OnCancelPressedListener = null,
		OnSavePressedListener = null
	},
	
	function create()
	{		
	}

	function setOnSavePressedListener( _listener )
	{
		this.m.OnSavePressedListener = _listener;
	}

	function setOnCancelPressedListener( _listener )
	{
		this.m.OnCancelPressedListener = _listener;
	}

	function show( _flags = [] )
	{
		::logInfo("FU: SettingsScreen.show called with flags: " + (_flags.len() > 0 ? "provided" : "empty"));
		if (this.m.JSHandle == null)
		{
			::logError("FU: SettingsScreen JSHandle is null - not connected to UI");
			throw ::FU.Exception.NotConnected;
		}
		else if (this.isVisible())
		{
			::logError("FU: SettingsScreen is already visible");
			throw ::FU.Exception.AlreadyInState;
		}
		::logInfo("FU: SettingsScreen calling asyncCall to show");
		this.m.JSHandle.asyncCall("show", ::FU.System.ModSettings.getUIData(_flags));
	}

	function connect()
	{
		::logInfo("FU: SettingsScreen connecting to UI with identifier 'ModSettingsScreen'");
		this.m.JSHandle = ::UI.connect("ModSettingsScreen", this);
		if (this.m.JSHandle != null)
		{
			::logInfo("FU: SettingsScreen successfully connected to UI");
		}
		else
		{
			::logError("FU: SettingsScreen failed to connect to UI - JSHandle is null");
		}
	}

	function linkMenuStack( _menuStack )
	{
		this.m.MenuStack = _menuStack;
	}

	function onCancelButtonPressed()
	{
		this.m.OnCancelPressedListener();
	}

	function onResetButtonPressed( _data )
	{
		local panel = ::FU.System.ModSettings.getPanel(_data.panelID);
		local page = panel.getPage(_data.pageID);
		page.resetSettings();
	}

	function onSaveButtonPressed( _data )
	{
		this.m.OnSavePressedListener(_data);
	}

	function onApplyButtonPressed( _data )
	{
		::FU.System.ModSettings.updateSettingsFromJS(_data);
	}

	function onSettingPressed( _data )
	{
		::FU.System.ModSettings.onSettingPressed(_data);
	}

	function updateSettingInJS( _modID, _settingID, _value )
	{
		local data = {
			modID = _modID,
			settingID = _settingID,
			value = _value
		}
		this.m.JSHandle.asyncCall("updateSetting", data);
	}

	function onSettingsScreenShown()
	{
		local mainMenu = ::getCurrentMainMenuModule();
		if (mainMenu == null) return; // Can be null when called directly from the Character Screen (i.e. 'in game')

		local navigationModule = mainMenu.mMenuStack.getModule("MainMenuNavigationModule");
		if (navigationModule == null) return;
		navigationModule = navigationModule.mContainer.findChild("navigation-module");
		local width = navigationModule["box#navigation-frame"].width();
		navigationModule["#navigation-frame"].addClass("-hidden");
		mainMenu.mMenuStack.splitRightView(width);
		this.m.MenuStack = mainMenu.mMenuStack;
	}

	function onSettingsScreenHidden()
	{
		if (this.m.MenuStack != null)
		{
			this.m.MenuStack.clearSplitAllViews();
		}
	}
});
