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
::MSU.System.Keybinds.KeybindsByMod["vanilla"]["world_toggleCamping"].Function = function ()
{
	if (!this.m.MenuStack.hasBacksteps())
	{
		this.showCampScreen();
		return true;
	}
}
