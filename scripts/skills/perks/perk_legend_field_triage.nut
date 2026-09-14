this.perk_legend_field_triage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendFieldTriage);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendFieldTriage))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendFieldTriage);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendFieldTriage);
	}

});
