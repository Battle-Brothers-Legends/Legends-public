::mods_hookExactClass("states/tactical_state", function(o) {
    // Ensure custom maps run in Scenario mode by setting the scenario early if selected
    local onInit = o.onInit;
    o.onInit = function()
    {
        if ("Legends" in getroottable() && "CustomMaps" in ::Legends && ::Legends.CustomMaps.Selected != null)
        {
            ::logInfo("CustomMaps: TacticalState onInit - setting custom scenario");
            this.setScenario(this.new("scripts/scenarios/tactical/scenario_custom_map"));
        }
        onInit();
    }
	local executeEntityTravel = o.executeEntityTravel;
	o.executeEntityTravel = function( _activeEntity, _mouseEvent )
	{
		_activeEntity.getSkills().m.IsPreviewing = false;
		executeEntityTravel(_activeEntity, _mouseEvent);
	}

	local executeEntitySkill = o.executeEntitySkill;
	o.executeEntitySkill = function( _activeEntity, _targetTile )
	{
		_activeEntity.getSkills().m.IsPreviewing = false;
		executeEntitySkill(_activeEntity, _targetTile);
	}

	local onInitUI = o.onInitUI;
	o.onInitUI = function()
	{
		onInitUI();
		local mainMenuModule = this.m.TacticalMenuScreen.getMainMenuModule();
		mainMenuModule.setOnModOptionsPressedListener(this.main_menu_module_onModOptionsPressed.bindenv(this));
	}

	o.main_menu_module_onModOptionsPressed <- function()
	{
		::FU.SettingsScreen.setOnCancelPressedListener(this.FU_settings_screen_onCancelPressed.bindenv(this));
		::FU.SettingsScreen.setOnSavePressedListener(this.FU_settings_screen_onSavepressed.bindenv(this));
		this.m.TacticalMenuScreen.hide();
		::FU.SettingsScreen.show(::FU.SettingsFlags.Tactical);
		this.m.MenuStack.push(function ()
		{
			::FU.SettingsScreen.hide();
			local allowRetreat = this.m.StrategicProperties == null || !this.m.StrategicProperties.IsFleeingProhibited;
			local allowQuit = !this.isScenarioMode();
			this.m.TacticalMenuScreen.show(allowRetreat, allowQuit, !this.isScenarioMode() && ::World.Assets.isIronman() ? "Quit & Retire" : "Quit");
		}, function ()
		{
			return !::FU.SettingsScreen.isAnimating();
		});
	}

	o.FU_settings_screen_onCancelPressed <- function ()
	{
		this.m.MenuStack.pop();
	}

	o.FU_settings_screen_onSavepressed <- function( _data )
	{
		::FU.System.ModSettings.updateSettingsFromJS(_data);
		this.m.MenuStack.pop();
	}

	local onKeyInput = o.onKeyInput;
	o.onKeyInput = function( _key )
	{
		if (!::FU.Key.isKnownKey(_key))
		{
			return onKeyInput(_key);
		}
		if (::FU.System.Keybinds.onKeyInput(_key, this, ::FU.Key.State.Tactical) || ::FU.Mod.ModSettings.getSetting("SuppressBaseKeybinds").getValue())
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
		if (::FU.System.Keybinds.onMouseInput(_mouse, this, ::FU.Key.State.Tactical))
		{
			return false;
		}
		return onMouseInput(_mouse);
	}
});
