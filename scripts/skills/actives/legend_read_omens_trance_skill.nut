this.legend_read_omens_trance_skill <- this.inherit("scripts/skills/actives/legend_trance_abstract_skill", {
	m = {
		BaseFatigueCost = 30,
		BaseAPCost = 4,
	},
	function create()
	{
		this.legend_trance_abstract_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendReadOmensTrance);
		this.m.Icon = "skills/omen_active.png";
		this.m.IconDisabled = "skills/omen_active_sw.png";
		this.m.Overlay = "omen_active";
		/*this.m.SoundOnUse = [
			"sounds/combat/hawk_01.wav",
			"sounds/combat/hawk_02.wav"
		];*/

		this.m.Description = "Toggle Read Omens On (+15% reroll on hit)";
		this.m.ToggleOnDescription = this.m.Description;
		this.m.ToggleOffDescription = "Toggle Read Omens Off";
	}

	function removeAll()
	{
		local act = this.getContainer().getActor();
		foreach( bro in this.World.getPlayerRoster().getAll() )
		{
			local omens = ::Legends.Effects.get(bro, ::Legends.Effect.LegendReadOmens);
			if (omens != null && omens.getActor() != null && omens.getActor == act)
			{
				::Legends.Effects.remove(bro, ::Legends.Effect.LegendReadOmens);
			}
		}
	}


	function swapOn()
	{
		this.legend_trance_abstract_skill.swapOn();
		local act = this.getContainer().getActor();
		foreach( bro in this.World.getPlayerRoster().getAll() )
		{
			::Legends.Effects.grant(bro, ::Legends.Effect.LegendReadOmens, function(_effect) {
				_effect.setActor(act);
			}.bindenv(this));
		}
	}

});
