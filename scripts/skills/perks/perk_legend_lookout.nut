this.perk_legend_lookout <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendLookout);
	}

	function onUpdate( _properties )
	{
		_properties.Vision += 1;
	}
});

