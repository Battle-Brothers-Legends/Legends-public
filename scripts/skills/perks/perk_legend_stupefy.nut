this.perk_legend_stupefy <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendStupefy);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendStupefy))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendStupefy);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendStupefy);
	}

});
