::FU.Vanilla.Keybinds.addSQKeybind("character_closeCharacterScreen", "c/i/escape", ::FU.Key.State.World | ::FU.Key.State.Tactical, function()
{
	if (!this.isInCharacterScreen()) return;
	if (::FU.isKindOf(this, "tactical_state"))
	{
		this.hideCharacterScreen();
	}
	else
	{
		this.toggleCharacterScreen();
	}
	return true;
}, "Close Character Screen");

::FU.Vanilla.Keybinds.addSQKeybind("character_openCharacterScreen", "c/i", ::FU.Key.State.World | ::FU.Key.State.Tactical, function()
{
	if (::FU.isKindOf(this, "tactical_state"))
	{
		if (this.m.MenuStack.hasBacksteps() || this.isInputLocked() || this.isInCharacterScreen()) return;
		this.showCharacterScreen();
		return true;
	}
	else
	{
		if (!this.m.MenuStack.hasBacksteps() || this.m.CharacterScreen.isVisible() || this.m.WorldTownScreen.isVisible() && !this.m.EventScreen.isVisible())
		{
			if (!this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
			{
				this.toggleCharacterScreen();
				return true;
			}
		}
	}
}, "Open Character Screen");

::FU.Vanilla.Keybinds.addSQKeybind("character_switchToPreviousBrother", "left/a", ::FU.Key.State.World | ::FU.Key.State.Tactical, function()
{
	if (!this.isInCharacterScreen()) return;
	this.m.CharacterScreen.switchToPreviousBrother();
	return true;
}, "Switch to Previous Brother");

::FU.Vanilla.Keybinds.addSQKeybind("character_switchToNextBrother", "right/d/tab", ::FU.Key.State.World | ::FU.Key.State.Tactical, function()
{
	if (!this.isInCharacterScreen()) return;
	this.m.CharacterScreen.switchToNextBrother();
	return true;
}, "Switch to Next Brother");

local function isCampfireScreen()
{
	return this.m.CampfireScreen != null && this.m.CampfireScreen.isVisible();
}

::FU.Vanilla.Keybinds.addSQKeybind("toggleMenuScreen", "escape", ::FU.Key.State.World | ::FU.Key.State.Tactical, function()
{
	if (::FU.isKindOf(this, "world_state"))
	{
		if (isCampfireScreen.call(this)) return;
		if (!this.m.WorldMenuScreen.isAnimating() && this.toggleMenuScreen())
		{
			return true;
		}
	}
	else
	{
		if (!this.m.MenuStack.hasBacksteps() || this.m.TacticalMenuScreen.isVisible())
		{
			if (this.toggleMenuScreen())
			{
				return true;
			}
		}
	}
}, "Toggle Menu Screen");


//-------------------------------------------WORLD ONLY---------------------------------------------------------------------------------

::FU.Vanilla.Keybinds.addDivider("world_divider");
::FU.Vanilla.Keybinds.addTitle("world_title", "World Keybinds");

::FU.Vanilla.Keybinds.addSQKeybind("world_closeCampfireScreen", "p/escape", ::FU.Key.State.World, function()
{
	if (!isCampfireScreen.call(this)) return;
	this.m.CampfireScreen.onModuleClosed();
	return true;
}, "Close Campfire Screen");

::FU.Vanilla.Keybinds.addSQKeybind("world_toggleRelationScreen", "r", ::FU.Key.State.World, function()
{
	if (!this.m.MenuStack.hasBacksteps() && !this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
	{
		this.topbar_options_module_onRelationsButtonClicked();
		return true;
	}
	else if (this.m.RelationsScreen.isVisible())
	{
		this.m.RelationsScreen.onClose();
		return true;
	}
}, "Toggle Relations Screen");

::FU.Vanilla.Keybinds.addSQKeybind("world_toggleObituarysScreen", "o", ::FU.Key.State.World, function()
{
	if (!this.m.MenuStack.hasBacksteps() && !this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
	{
		this.topbar_options_module_onObituaryButtonClicked();
		return true;
	}
	else if (this.m.ObituaryScreen.isVisible())
	{
		this.m.ObituaryScreen.onClose();
		return true;
	}
}, "Toggle Obituary Screen");

::FU.Vanilla.Keybinds.addSQKeybind("world_toggleCamping", "t", ::FU.Key.State.World, function()
{
	if (!this.m.MenuStack.hasBacksteps())
	{
		if (this.isCampingAllowed())
		{
			this.onCamp();
			return true;
		}
	}
}, "Toggle Camping");


::FU.Vanilla.Keybinds.addSQKeybind("world_toggleRetinueButton", "p", ::FU.Key.State.World, function()
{
	if (!this.m.MenuStack.hasBacksteps() && !this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
	{
		this.topbar_options_module_onPerksButtonClicked();
		return true;
	}
}, "Toggle Retinue SCreen");

::FU.Vanilla.Keybinds.addSQKeybind("world_pause", "0/space", ::FU.Key.State.World, function()
{
	if (!this.m.MenuStack.hasBacksteps())
	{
		this.setPause(!this.isPaused());
		return true;
	}
}, "Pause World");

::FU.Vanilla.Keybinds.addSQKeybind("world_speedNormal", "1", ::FU.Key.State.World, function()
{
	if (!this.m.MenuStack.hasBacksteps())
	{
		this.setNormalTime();
		return true;
	}
}, "Normal World Speed (1x)");

::FU.Vanilla.Keybinds.addSQKeybind("world_speedFast", "2", ::FU.Key.State.World, function()
{
	if (!this.m.MenuStack.hasBacksteps())
	{
		this.setFastTime();
		return true;
	}
}, "Fast World Speed (2x)");

::FU.Vanilla.Keybinds.addSQKeybind("world_trackingButton", "f", ::FU.Key.State.World, function()
{
	if (!this.m.MenuStack.hasBacksteps())
	{
		this.m.WorldScreen.getTopbarOptionsModule().onTrackingButtonPressed();
		return true;
	}
}, "Toggle Tracks");

::FU.Vanilla.Keybinds.addSQKeybind("world_cameraLockButton", "x", ::FU.Key.State.World, function()
{
	if (!this.m.MenuStack.hasBacksteps())
	{
		this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
		return true;
	}
}, "Lock Camera on Party");

::FU.Vanilla.Keybinds.addSQKeybind("world_quicksave", "f5", ::FU.Key.State.World, function()
{
	if (!this.m.MenuStack.hasBacksteps() && !::World.Assets.isIronman())
	{
		this.saveCampaign("quicksave");
		return true;
	}
}, "Quicksave")

::FU.Vanilla.Keybinds.addSQKeybind("world_quickload", "f9", ::FU.Key.State.World, function()
{
	if (!this.m.MenuStack.hasBacksteps() && !::World.Assets.isIronman() && ::World.canLoad("quicksave"))
	{
		this.loadCampaign("quicksave");
		return true;
	}
}, "Quickload")

::FU.Vanilla.Keybinds.addSQKeybind("world_event_1", "1", ::FU.Key.State.World, function()
{
	if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
	{
		return;
	}

	this.m.EventScreen.onButtonPressed(0);
	return true;
}, "Select Event Option 1", null, "Click the first button from the top in a world event");

::FU.Vanilla.Keybinds.addSQKeybind("world_event_2", "2", ::FU.Key.State.World, function()
{
	if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
	{
		return;
	}

	this.m.EventScreen.onButtonPressed(1);
	return true;
}, "Select Event Option 2", null, "Click the second button from the top in a world event");

::FU.Vanilla.Keybinds.addSQKeybind("world_event_3", "3", ::FU.Key.State.World, function()
{
	if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
	{
		return;
	}

	this.m.EventScreen.onButtonPressed(2);
	return true;
}, "Select Event Option 3", null, "Click the third button from the top in a world event");

::FU.Vanilla.Keybinds.addSQKeybind("world_event_4", "4", ::FU.Key.State.World, function()
{
	if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
	{
		return;
	}

	this.m.EventScreen.onButtonPressed(3);
	return true;
}, "Select Event Option 4", null, "Click the fourth button from the top in a world event");

::FU.Vanilla.Keybinds.addSQKeybind("world_toggle_forceattack", "ctrl", ::FU.Key.State.World, function()
{
	if (this.m.IsForcingAttack)
	{
		this.m.IsForcingAttack = false;
	}
	else
	{
		if (!this.m.MenuStack.hasBacksteps())
		{
			this.m.IsForcingAttack = true;
			return true;
		}
	}
}, "Toggle Forced Attack", ::FU.Key.KeyState.Release | ::FU.Key.KeyState.Press);

// World Continuous, doesn't work cuz we handle keybinds differently from vanilla ):

// ::FU.Vanilla.Keybinds.addSQKeybind("world_moveCamera_left", "left/a/q", ::FU.Key.State.World, function()
// {
// 	if (::Settings.getTempGameplaySettings().CameraLocked)
// 	{
// 		this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
// 	}

// 	::World.getCamera().move(-1500.0 * ::Time.getDelta() * ::Math.maxf(1.0, ::World.getCamera().Zoom * 0.66), 0);
// 	return true;
// }, "Move Camera Up", null, ::FU.Key.KeyState.Continuous | ::FU.Key.KeyState.Press);

// ::FU.Vanilla.Keybinds.addSQKeybind("world_moveCamera_right", "right/d", ::FU.Key.State.World, function()
// {
// 	if (::Settings.getTempGameplaySettings().CameraLocked)
// 	{
// 		this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
// 	}

// 	::World.getCamera().move(1500.0 * ::Time.getDelta() * ::Math.maxf(1.0, ::World.getCamera().Zoom * 0.66), 0);
// 	return true;
// }, "Move Camera Right", null, ::FU.Key.KeyState.Continuous | ::FU.Key.KeyState.Press);

//-------------------------------------------TACTICAL ONLY---------------------------------------------------------------------------------

::FU.Vanilla.Keybinds.addDivider("tactical_divider");
::FU.Vanilla.Keybinds.addTitle("tactical_title", "Combat Keybinds");

::FU.Vanilla.Keybinds.addSQKeybind("tactical_hideCharacterScreen", "enter", ::FU.Key.State.Tactical, function()
{
	if (!this.isInCharacterScreen()) return;
	if (this.m.CharacterScreen.isInBattlePreparationMode() == true)
	{
		this.hideCharacterScreen();
		return true;
	}
}, "Close Character Screen");

::FU.Vanilla.Keybinds.addSQKeybind("tactical_toggleStatsOverlays", "alt", ::FU.Key.State.Tactical, function()
{
	if (this.m.MenuStack.hasBacksteps()) return;
	this.topbar_options_onToggleStatsOverlaysButtonClicked();
	return true;
}, "Toggle Stats Overlay");

::FU.Vanilla.Keybinds.addSQKeybind("tactical_toggleTreesButton", "t", ::FU.Key.State.Tactical, function()
{
	if (this.m.MenuStack.hasBacksteps()) return;
	this.topbar_options_onToggleTreesButtonClicked();
	return true;
}, "Toggle Trees");

::FU.Vanilla.Keybinds.addSQKeybind("tactical_toggleHighlightBlockedTiles", "b", ::FU.Key.State.Tactical, function()
{
	if (this.m.MenuStack.hasBacksteps()) return;
	this.topbar_options_onToggleHighlightBlockedTilesButtonClicked();
	return true;
}, "Toggle Highlighting Blocked Tiles");

::FU.Vanilla.Keybinds.addSQKeybind("tactical_initNextTurn", "enter", ::FU.Key.State.Tactical, function()
{
	if (this.m.MenuStack.hasBacksteps() || this.isInputLocked() || this.isInCharacterScreen()) return;
	 ::Tactical.TurnSequenceBar.initNextTurn();
	return true;
}, "End Turn for Character");

::FU.Vanilla.Keybinds.addSQKeybind("tactical_endTurnAll", "r", ::FU.Key.State.Tactical, function()
{
	if (this.m.MenuStack.hasBacksteps() || this.isInputLocked() || this.isInCharacterScreen()) return;
	::Tactical.TurnSequenceBar.onEndTurnAllButtonPressed();
	return true;
}, "End Turn for All Characters");

::FU.Vanilla.Keybinds.addSQKeybind("tactical_waitTurn", "end/space", ::FU.Key.State.Tactical, function()
{
	if (this.m.MenuStack.hasBacksteps() || this.isInputLocked() || this.isInCharacterScreen()) return;
	if (::Tactical.TurnSequenceBar.getActiveEntity() != null && ::Tactical.TurnSequenceBar.getActiveEntity().isPlayerControlled())
	{
		local wasAbleToWait = ::Tactical.TurnSequenceBar.entityWaitTurn(::Tactical.TurnSequenceBar.getActiveEntity());

		if (!wasAbleToWait)
		{
			::Tactical.TurnSequenceBar.initNextTurn();
		}
		return true;
	}
}, "Wait Character Turn");

::FU.Vanilla.Keybinds.addSQKeybind("tactical_focusActiveEntity", "shift", ::FU.Key.State.Tactical, function()
{
	if (this.m.MenuStack.hasBacksteps() || this.isInputLocked() || this.isInCharacterScreen()) return;
	::Tactical.TurnSequenceBar.focusActiveEntity(true);
	return true;
}, "Focus on Active Character");


// ::FU.System.Keybinds.registerMod(::FU.ID)
// local jskeybind = ::FU.Class.KeybindJS(::FU.ID, "testkb", "ctrl+s");
// ::FU.System.Keybinds.add(jskeybind);
