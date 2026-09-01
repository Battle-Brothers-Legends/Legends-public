this.perk_legend_horrify <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHorrify);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendHorrificScream))
		{
			::Legends.Actives.grant(this, ::Legends.Effect.HorrificScream, function(_skill) {
				_skill.m.ActionPointCost = 6;
				_skill.m.FatigueCost = 30;
				_skill.m.MaxRange = 4;
			}.bindenv(this));
		}
	}

	function onRemoved()
	{
		if (!this.m.Container.hasPerk(::Legends.Perk.LegendHorrify))
		{
			::Legends.Actives.remove(this, ::Legends.Active.HorrificScream);
		}
	}

});
