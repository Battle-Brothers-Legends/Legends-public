this.legend_citrinitas_trance_skill <- this.inherit("scripts/skills/actives/legend_trance_abstract_skill", {
	m = {},
	function create()
	{
		this.legend_trance_abstract_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendCitrinitasTrance);
		this.m.Icon = "skills/omen_active.png"; //todo: change icons, better description, sound on use
		this.m.IconDisabled = "skills/omen_active_sw.png";
		this.m.Overlay = "omen_active";
		this.m.SoundOnUse = [
			"sounds/combat/hawk_01.wav",
			"sounds/combat/hawk_02.wav"
		];

		this.m.Description = "Toggle Citrinitas On (Grants Drums of War and Drums of Life effects to all allies at the end of turn)";
		this.m.ToggleOnDescription = this.m.Description;
		this.m.ToggleOffDescription = "Toggle Citrinitas Off";
	}

	function applyDrums()
	{
		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());

		foreach( a in actors )
		{
			if (a.getID() == _user.getID())
			{
				continue;
			}

			if (a.getFatigue() == 0)
			{
				continue;
			}

			if (a.getFaction() == _user.getFaction())
			{
				// ::Legends.Effects.grant(a, ::Legends.Effect.LegendDrumsOfLife);
				::Legends.Effects.grant(a, ::Legends.Effect.LegendDrumsOfWar);
			}
		}
		// ::Legends.Effects.grant(this, ::Legends.Effect.LegendDrumsOfLife);
		::Legends.Effects.grant(this, ::Legends.Effect.LegendDrumsOfWar);
	}

	function doTranceEndTurn()
	{
		this.applyDrums();
	}

});
