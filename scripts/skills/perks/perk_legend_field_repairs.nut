this.perk_legend_field_repairs <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendFieldRepairs);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendFieldRepairs))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendFieldRepairs);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendFieldRepairs);
	}

});
