local canResurrectOnTile = this.MSU.Tile.canResurrectOnTile;
this.MSU.Tile.canResurrectOnTile = function( _tile, _force = false )
{
	if (!canResurrectOnTile(_tile, _force)) 
	{
		return false;
	}

	if (_tile.Properties.Effect != null && _tile.Properties.Effect.Type == "legend_holyflame") 
	{
		return false;
	}

	return true;
}

// DO NOT DO THIS. TEMPORARY FIX SO WE CAN DISCUSS THE PROPER WAY TO SOLVE THESE PROBLEMS (NOT SUPPORTED)
/*::MSU.System.Keybinds.KeybindsByMod["vanilla"]["world_toggleCamping"].Function = function ()
{
	if (!this.m.MenuStack.hasBacksteps())
	{
		this.showCampScreen();
		return true;
	}
}*/
// Disable MSU keybinds we hook on game startup
::MSU.System.ModSettings.getPanel(::MSU.Vanilla.Keybinds.Mod.getID()).getSetting("character_closeCharacterScreen").set("");
::MSU.System.ModSettings.getPanel(::MSU.Vanilla.Keybinds.Mod.getID()).getSetting("character_openCharacterScreen").set("");
::MSU.System.ModSettings.getPanel(::MSU.Vanilla.Keybinds.Mod.getID()).getSetting("world_closeCampfireScreen").set("");
::MSU.System.ModSettings.getPanel(::MSU.Vanilla.Keybinds.Mod.getID()).getSetting("world_toggleRelationScreen").set("");
::MSU.System.ModSettings.getPanel(::MSU.Vanilla.Keybinds.Mod.getID()).getSetting("world_toggleObituarysScreen").set("");
::MSU.System.ModSettings.getPanel(::MSU.Vanilla.Keybinds.Mod.getID()).getSetting("world_toggleCamping").set("");
::MSU.System.ModSettings.getPanel(::MSU.Vanilla.Keybinds.Mod.getID()).getSetting("world_toggleRetinueButton").set("");
::MSU.System.ModSettings.getPanel(::MSU.Vanilla.Keybinds.Mod.getID()).getSetting("world_pause").set("");
::MSU.System.ModSettings.getPanel(::MSU.Vanilla.Keybinds.Mod.getID()).getSetting("world_speedNormal").set("");
::MSU.System.ModSettings.getPanel(::MSU.Vanilla.Keybinds.Mod.getID()).getSetting("world_speedFast").set("");
::MSU.System.ModSettings.getPanel(::MSU.Vanilla.Keybinds.Mod.getID()).getSetting("world_speedVeryFast").set("");
::MSU.System.ModSettings.getPanel(::MSU.Vanilla.Keybinds.Mod.getID()).getSetting("world_quicksave").set("");
::MSU.System.ModSettings.getPanel(::MSU.Vanilla.Keybinds.Mod.getID()).getSetting("world_quickload").set("");