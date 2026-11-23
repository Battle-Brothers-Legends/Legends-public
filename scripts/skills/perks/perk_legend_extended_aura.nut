this.perk_legend_extended_aura <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendExtendendAura);
		this.m.Icon = "ui/perks/possess56.png";
		this.m.IconDisabled = "ui/perks/possess56_bw.png";
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInSummons = true;
	}


});
