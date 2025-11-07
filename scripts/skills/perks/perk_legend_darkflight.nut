this.perk_legend_darkflight <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendDarkflight);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendDarkflight))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendDarkflight);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendDarkflight);
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 1.33;
	}

});
