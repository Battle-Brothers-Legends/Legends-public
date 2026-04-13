this.perk_legend_mastery_magic_missile_focus <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMagicMissileFocus);
		this.m.Icon = "ui/perks/missile_circle.png";
	}

});

