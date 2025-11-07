this.perk_legend_ballistics <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBallistics);
	}

	function onUpdate( _properties )
	{
		_properties.HitChanceAdditionalWithEachTile += 2;
	}

});

