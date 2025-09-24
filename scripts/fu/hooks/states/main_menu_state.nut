::mods_hookExactClass("states/main_menu_state", function(o) {
	o.m.ModSettingsShown <- false;
	o.m.TempSettings <- null;

	local onInit = o.onInit;
    o.onInit = function()
    {
        ::logInfo("FU: Main menu onInit hook running");
        onInit();
        ::logInfo("FU: Original onInit completed");
        local mainMenuModule = this.m.MainMenuScreen.getMainMenuModule();
        mainMenuModule.setOnModOptionsPressedListener(this.main_menu_module_onModOptionsPressed.bindenv(this));

    }

	o.main_menu_module_onModOptionsPressed <- function()
	{
		::logInfo("FU: Mod options button pressed");

		// Check FU namespace
		if (!("FU" in getroottable()))
		{
			::logError("FU: FU namespace not found in root table");
			return;
		}
		::logInfo("FU: FU namespace found");

		// Check System
		if (!("System" in ::FU))
		{
			::logError("FU: System not available in FU namespace");
			return;
		}
		::logInfo("FU: System found in FU namespace");

		// Check ModSettings
		if (!("ModSettings" in ::FU.System))
		{
			::logError("FU: ModSettings not available in FU.System");
			return;
		}
		::logInfo("FU: ModSettings found in FU.System");

		// Check SettingsScreen
		if (!("SettingsScreen" in ::FU))
		{
			::logError("FU: SettingsScreen not available - mod_settings system may not be loaded");
			return;
		}
		::logInfo("FU: SettingsScreen found");

		// Check SettingsFlags
		if (!("SettingsFlags" in ::FU))
		{
			::logError("FU: SettingsFlags not available - mod_settings system may not be loaded");
			return;
		}
		::logInfo("FU: SettingsFlags found");

		// Check if there are any registered mods with settings
		local panels = ::FU.System.ModSettings.getPanels();
		::logInfo("FU: Found " + panels.len() + " mod settings panels");
		foreach (id, panel in panels)
		{
			::logInfo("FU: Panel '" + id + "' - " + panel.getName() + " (" + panel.getPages().len() + " pages)");
		}

		// Check specifically for Legends mod registration
		if ("Legends" in getroottable() && "Mod" in ::Legends)
		{
			::logInfo("FU: Legends.Mod found, ID: " + ::Legends.Mod.getID());
			if ("ModSettings" in ::Legends.Mod)
			{
				::logInfo("FU: Legends.Mod.ModSettings found");
				local legendsPanel = ::FU.System.ModSettings.getPanel(::Legends.Mod.getID());
				if (legendsPanel != null)
				{
					::logInfo("FU: Legends panel found in central system with " + legendsPanel.getPages().len() + " pages");
				}
				else
				{
					::logInfo("FU: Legends panel NOT found in central system");
				}
			}
			else
			{
				::logInfo("FU: Legends.Mod.ModSettings NOT found");
			}
		}
		else
		{
			::logInfo("FU: Legends.Mod not found");
		}

		try
		{
			::logInfo("FU: Establishing UI connections on-demand");
			::FU.UI.connect();

			::logInfo("FU: Setting up settings screen listeners");
			::FU.SettingsScreen.setOnCancelPressedListener(this.FU_settings_screen_onCancelPressed.bindenv(this)); // Need to bind these every time because it's a new screen and not a module (which tbh was probs a mistake).
			::FU.SettingsScreen.setOnSavePressedListener(this.FU_settings_screen_onSavepressed.bindenv(this));

			::logInfo("FU: Hiding main menu module");
			this.m.MainMenuScreen.hideMainMenuModule();

			::logInfo("FU: About to show settings screen with Main flags");
			::FU.SettingsScreen.show(::FU.SettingsFlags.Main);

			::logInfo("FU: Settings screen show command completed");
		}
		catch (e)
		{
			::logError("FU: Error showing settings screen: " + e);
		}
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
		if (this.m.ModSettingsShown || !("System" in ::FU) || !("ModSettings" in ::FU.System) || !("SettingsFlags" in ::FU) || !::FU.System.ModSettings.isVisibleWithFlags(::FU.SettingsFlags.NewCampaign))
		{
			campaign_menu_module_onStartPressed(_settings);
		}
		else
		{
			this.m.ModSettingsShown = true;
			// Ensure FU UI connections are established before showing the settings screen
			::FU.UI.connect();
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
