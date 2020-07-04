this.legend_scry_trance_skill <- this.inherit("scripts/skills/actives/legend_trance_abstract", {
	m = {},
	function create()
	{
		this.legend_trance_abstract.create();
		this.m.ID = "actives.legend_scry_trance";
		this.m.Name = "Scry Area (Trance)";
		this.m.Icon = "skills/active_104.png"; //todo: change icons, better description
		this.m.IconDisabled = "skills/active_104_sw.png";
		this.m.Overlay = "active_104";		
		this.m.SoundOnUse = [
			"sounds/combat/hawk_01.wav",
			"sounds/combat/hawk_02.wav"
		];
		
		this.m.Description = "Toggle Scry Trance On (12 Tile Scry until cancelled)";
		this.m.ToggleOnDescription = "Toggle Scry Trance On (12 tile hawk-scry until cancelled)";
		this.m.ToggleOffDescription = "Toggle Scry Trance Off";
	}

	function doTranceStartTurn()
	{
		this.Tactical.queryTilesInRange( this.getContainer().getActor().getTile(), 1, 12, false, [], this.onQueryTile, this.getContainer().getActor().getFaction());
	}

	function onQueryTile( _tile, _tag )
	{
		_tile.addVisibilityForFaction(_tag);

		if (_tile.IsOccupiedByActor)
		{
			_tile.getEntity().setDiscovered(true);
		}
	}

});
