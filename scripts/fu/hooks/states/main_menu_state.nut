::mods_hookExactClass("states/main_menu_state", function(o) {
	o.m.ModSettingsShown <- false;
	o.m.TempSettings <- null;

	local onInit = o.onInit;
    o.onInit = function()
    {
        onInit();
        local mainMenuModule = this.m.MainMenuScreen.getMainMenuModule();
        mainMenuModule.setOnModOptionsPressedListener(this.main_menu_module_onModOptionsPressed.bindenv(this));

        // FU UI connections are handled by the FU system itself
    }

	o.main_menu_module_onModOptionsPressed <- function()
	{
		::FU.SettingsScreen.setOnCancelPressedListener(this.FU_settings_screen_onCancelPressed.bindenv(this)); // Need to bind these every time because it's a new screen and not a module (which tbh was probs a mistake).
		::FU.SettingsScreen.setOnSavePressedListener(this.FU_settings_screen_onSavepressed.bindenv(this));
		this.m.MainMenuScreen.hideMainMenuModule();
		::FU.SettingsScreen.show(::FU.SettingsFlags.Main);
		this.m.MenuStack.push(function ()
		{
			::FU.SettingsScreen.hide();
			this.m.MainMenuScreen.showMainMenuModule();
		}, function ()
		{
			return !::FU.SettingsScreen.isAnimating();
		});
	}

	local campaign_menu_module_onStartPressed = o.campaign_menu_module_onStartPressed;
	o.campaign_menu_module_onStartPressed = function( _settings )
	{
		this.m.TempSettings = _settings;
		if (this.m.ModSettingsShown || !::FU.System.ModSettings.isVisibleWithFlags(::FU.SettingsFlags.NewCampaign))
		{
			campaign_menu_module_onStartPressed(_settings);
		}
		else
		{
			this.m.ModSettingsShown = true;
			::FU.SettingsScreen.setOnCancelPressedListener(this.FU_settings_screen_onCancelPressed.bindenv(this));
			::FU.SettingsScreen.setOnSavePressedListener(this.FU_settings_screen_onSavepressed.bindenv(this));
			this.m.MainMenuScreen.hideNewCampaignModule();
			::FU.SettingsScreen.show(::FU.SettingsFlags.NewCampaign);
			this.m.MenuStack.push(function ()
			{
				::FU.SettingsScreen.hide();
				this.m.MainMenuScreen.showNewCampaignModule();
			}, function ()
			{
				return !::FU.SettingsScreen.isAnimating();
			})
		}
	}

	o.FU_settings_screen_onCancelPressed <- function()
	{
		this.m.ModSettingsShown = false;
		this.m.MenuStack.pop();
	}

	o.FU_settings_screen_onSavepressed <- function( _data )
	{
		::FU.System.ModSettings.updateSettingsFromJS(_data);
		this.m.MenuStack.pop();
		if (this.m.ModSettingsShown)
		{
			campaign_menu_module_onStartPressed(this.m.TempSettings);
			this.m.TempSettings = null;
			this.m.ModSettingsShown = false;
		}
	}

	local onKeyInput = o.onKeyInput;
	o.onKeyInput = function( _key )
	{
		if (!::FU.Key.isKnownKey(_key))
		{
			return onKeyInput(_key);
		}
		if (::FU.System.Keybinds.onKeyInput(_key, this, ::FU.Key.State.MainMenu) || ::FU.Mod.ModSettings.getSetting("SuppressBaseKeybinds").getValue())
		{
			return false;
		}
		return onKeyInput(_key);
	}

	local onMouseInput = o.onMouseInput;
	o.onMouseInput = function( _mouse )
	{
		if (!::FU.Key.isKnownMouse(_mouse))
		{
			return onMouseInput(_mouse);
		}
		if (::FU.System.Keybinds.onMouseInput(_mouse, this, ::FU.Key.State.MainMenu))
		{
			return false;
		}
		return onMouseInput(_mouse);
	}
});
