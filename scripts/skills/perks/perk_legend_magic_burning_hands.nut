// TODO Edit strings.nut
this.perk_legend_magic_burning_hands <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMagicBurningHands);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendMagicBurningHands))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_magic_burning_hands_skill"));
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMagicBurningHands);
	}

});
