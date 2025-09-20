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
		if (this.m.JSHandle == null)
		{
			throw ::FU.Exception.NotConnected;
		}
		else if (this.isVisible())
		{
			throw ::FU.Exception.AlreadyInState;
		}
		this.m.JSHandle.asyncCall("show", ::FU.System.ModSettings.getUIData(_flags));
	}

	function connect()
	{
		this.m.JSHandle = ::UI.connect("ModSettingsScreen", this);
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
