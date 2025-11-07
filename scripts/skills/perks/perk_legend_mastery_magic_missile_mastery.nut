// TODO strings.nut
this.perk_legend_mastery_magic_missile_mastery <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMagicMissileMastery);
	}

});

