this.legend_scry_trance_skill <- this.inherit("scripts/skills/actives/legend_trance_abstract_skill", {
	m = {
		BaseFatigueCost = 15,
		BaseAPCost = 3,
	},
	function create()
	{
		this.legend_trance_abstract_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendScryTrance);
		this.m.Icon = "skills/scry_skill.png";
		this.m.IconDisabled = "skills/scry_skill_bw.png";
		this.m.Overlay = "active_104";
		this.m.SoundOnUse = [
			"sounds/combat/hawk_01.wav",
			"sounds/combat/hawk_02.wav"
		];

		this.m.Description = "Toggle Scry Trance On (12 Tile Scry at the beginning of turn until cancelled)";
		this.m.ToggleOnDescription = this.m.Description;
		this.m.ToggleOffDescription = "Toggle Scry Trance Off";
	}

	function doTranceStartTurn()
	{
		this.Tactical.queryTilesInRange( this.getContainer().getActor().getTile(), 1, 12, false, [], this.onQueryTile, this.getContainer().getActor().getFaction());
	}

	function onUse( _user, _targetTile )
	{
		this.legend_trance_abstract_skill.onUse(_user, _targetTile);
		this.Tactical.queryTilesInRange( _user.getTile(), 1, 12, false, [], this.onQueryTile, _user.getFaction());
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
