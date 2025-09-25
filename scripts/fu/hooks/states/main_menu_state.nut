::mods_hookExactClass("states/main_menu_state", function(o) {
	o.m.ModSettingsShown <- false;
	o.m.TempSettings <- null;

	local onInit = o.onInit;
    o.onInit = function()
    {
        ::logInfo("FU: Main menu onInit hook running");
        // Ensure our scenario query override is in place BEFORE the vanilla registration binds the listener
        local _orig = this.scenario_menu_module_onQueryData;
        this.scenario_menu_module_onQueryData = function()
        {
            ::logInfo("CustomMaps: scenario menu query data");
            local data = _orig.bindenv(this)();
            this._discoverCustomMaps();
            foreach (m in ::Legends.CustomMaps.List)
            {
                data.push({ id = m.ID, name = m.Name, description = "[p=c]Experimental tactical map template[/p]" });
                ::logInfo("CustomMaps: added scenario entry id=" + m.ID + " name='" + m.Name + "'");
            }
            ::logInfo("CustomMaps: total scenario entries now " + data.len());
            return data;
        }
        // Optional early discovery to confirm file scanning in logs at boot
        this._discoverCustomMaps();
        onInit();
        ::logInfo("FU: Original onInit completed");
        local mainMenuModule = this.m.MainMenuScreen.getMainMenuModule();
        mainMenuModule.setOnModOptionsPressedListener(this.main_menu_module_onModOptionsPressed.bindenv(this));

    }

    // Force custom map IDs to load TacticalState instead of WorldState
    local loading_screen_onScreenShown = o.loading_screen_onScreenShown;
    o.loading_screen_onScreenShown = function()
    {
        // If a custom map (id >= BaseID) is selected, go to TacticalState
        if (this.m.SelectedScenarioID >= ::Legends.CustomMaps.BaseID)
        {
            this.m.MenuStack.popAll();
            this.RootState.add("TacticalState", "scripts/states/tactical_state");
            this.hide();
            return;
        }
        return loading_screen_onScreenShown();
    }

    // --- Custom Tactical Map Discovery ---
    ::Legends <- ("Legends" in getroottable()) ? ::Legends : {};
    ::Legends.CustomMaps <- ("CustomMaps" in ::Legends) ? ::Legends.CustomMaps : { BaseID = 1000, List = [], ByID = {}, Selected = null };

    o._discoverCustomMaps <- function()
    {
        // Only list everything under custom maps roots; do not filter by specific suffixes.
        local roots = [
            "scripts/custom_maps",
            "scripts/mapgen/custom_maps"
        ];
        local files = [];
        foreach (r in roots)
        {
            local fs = ::IO.enumerateFiles(r);
            if (fs == null)
            {
                ::logInfo("CustomMaps: path not found or empty: " + r);
                continue;
            }
            ::logInfo("CustomMaps: enumerated " + fs.len() + " file(s) under " + r);
            foreach (f in fs)
            {
                files.push(f);
            }
        }
        ::logInfo("CustomMaps: total files enumerated: " + files.len());
        local maps = [];
        local added = 0;
        foreach (f in files)
        {
            // IO.enumerateFiles returns script paths without the .nut extension.
            local parts = split(f, "/");
            local stem = parts[parts.len() - 1];
            local scriptPath = f; // already extension-less
            // Friendly name from filename (replace underscores without relying on FU.String at boot)
            local label = stem;
            local pos = null;
            while ((pos = label.find("_")) != null)
            {
                label = label.slice(0, pos) + " " + label.slice(pos + 1);
            }
            local name = "Custom Map: " + label;
            maps.push({ Script = scriptPath, Name = name });
            ++added;
            ::logInfo("CustomMaps: found script: " + scriptPath + " as '" + name + "'");
        }
        if (added == 0)
        {
            ::logInfo("CustomMaps: no custom map scripts discovered");
        }
        // Persist with IDs (reset structures to known types)
        ::Legends.CustomMaps.List <- [];
        ::Legends.CustomMaps.ByID <- {};
        local id = ::Legends.CustomMaps.BaseID;
        foreach (m in maps)
        {
            local entry = { ID = id, Name = m.Name, Script = m.Script };
            ::Legends.CustomMaps.List.push(entry);
            ::Legends.CustomMaps.ByID[id] <- entry;
            id++;
        }
        ::logInfo("CustomMaps: registered entries: " + ::Legends.CustomMaps.List.len());
    }

    // scenario_menu_module_onQueryData is overridden inside onInit so the listener binds to our override

    // Handle launching a custom map when selected
    local onSiblingAdded = o.onSiblingAdded;
    o.onSiblingAdded = function( _stateName )
    {
        if (_stateName == "TacticalState" && this.m.SelectedScenarioID >= ::Legends.CustomMaps.BaseID)
        {
            ::logInfo("CustomMaps: launching custom map with SelectedScenarioID=" + this.m.SelectedScenarioID);
            local tacticalState = this.RootState.get(_stateName);
            if (tacticalState != null)
            {
                ::Legends.CustomMaps.Selected = ::Legends.CustomMaps.ByID[this.m.SelectedScenarioID];
                if (::Legends.CustomMaps.Selected == null)
                {
                    ::logError("CustomMaps: Selected entry not found for id=" + this.m.SelectedScenarioID);
                }
                else
                {
                    ::logInfo("CustomMaps: Selected Script='" + (::Legends.CustomMaps.Selected.Script ? ::Legends.CustomMaps.Selected.Script : "<none>") + "' Name='" + ::Legends.CustomMaps.Selected.Name + "'");
                }
                tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_custom_map"));
            }
            return; // Do not call original handler for custom scenarios
        }
        return onSiblingAdded(_stateName);
    }

    // Capture selection at click time so Selected is definitely set before TacticalState.onInit
    local scenario_menu_module_onPlayPressed = o.scenario_menu_module_onPlayPressed;
    o.scenario_menu_module_onPlayPressed = function( _scenarioId )
    {
        if (_scenarioId >= ::Legends.CustomMaps.BaseID)
        {
            ::Legends.CustomMaps.Selected = (_scenarioId in ::Legends.CustomMaps.ByID) ? ::Legends.CustomMaps.ByID[_scenarioId] : null;
            if (::Legends.CustomMaps.Selected == null)
            {
                ::logError("CustomMaps: PlayPressed: entry not found for id=" + _scenarioId);
            }
            else
            {
                ::logInfo("CustomMaps: PlayPressed: Selected id=" + _scenarioId + " name='" + ::Legends.CustomMaps.Selected.Name + "'");
            }
        }
        return scenario_menu_module_onPlayPressed(_scenarioId);
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
