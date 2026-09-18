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
local panel = ::MSU.System.ModSettings.getPanel(::MSU.Vanilla.Keybinds.Mod.getID());
panel.getSetting("character_closeCharacterScreen").set("");
panel.getSetting("character_openCharacterScreen").set("");
panel.getSetting("world_closeCampfireScreen").set("");
panel.getSetting("world_toggleRelationScreen").set("");
panel.getSetting("world_toggleObituarysScreen").set("");
panel.getSetting("world_toggleCamping").set("");
panel.getSetting("world_toggleRetinueButton").set("");
panel.getSetting("world_pause").set("");
panel.getSetting("world_speedNormal").set("");
panel.getSetting("world_speedFast").set("");
panel.getSetting("world_speedVeryFast").set("");
panel.getSetting("world_quicksave").set("");
panel.getSetting("world_quickload").set("");
panel.getSetting("tactical_hideCharacterScreen").set("");
panel.getSetting("toggleMenuScreen").set("");