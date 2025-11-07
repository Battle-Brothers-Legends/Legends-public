this.perk_legend_battleheart <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBattleheart);
	}

	function onUpdate( _properties )
	{
		_properties.IsImmuneToSurrounding = true;
	}

});
