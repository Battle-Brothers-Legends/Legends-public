this.perk_legend_bearform <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBearform);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendTransformIntoBear))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendTransformIntoBear);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendTransformIntoBear);
	}

});
