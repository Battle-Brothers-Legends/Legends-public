this.perk_legend_mastery_staves <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMasteryStaves);
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInStaves = true;
	}

});
