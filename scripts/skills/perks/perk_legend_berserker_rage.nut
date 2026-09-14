this.perk_legend_berserker_rage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBerserkerRage);
	}

	function onAdded()
	{
		if (!this.m.Container.hasEffect(::Legends.Effect.LegendBerserkerRage))
		{
			::Legends.Effects.grant(this, ::Legends.Effect.LegendBerserkerRage);
		}
	}

	function onRemoved()
	{
		::Legends.Effects.remove(this, ::Legends.Effect.LegendBerserkerRage);
	}

});
