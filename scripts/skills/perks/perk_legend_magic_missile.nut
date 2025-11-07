this.perk_legend_magic_missile <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMagicMissile);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendMagicMissile))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMagicMissile);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMagicMissile);
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 1.33;
	}

});

