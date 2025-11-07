this.perk_legend_sprint <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSprint);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendStrafingRun))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_sprint_skill_5"));
		}
	}

});

