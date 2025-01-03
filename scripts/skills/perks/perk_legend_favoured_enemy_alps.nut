this.perk_legend_favoured_enemy_alps <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendFavouredEnemyAlps);
		this.m.ValidTypes = this.Const.LegendMod.FavoriteAlps;
		this.m.BraveryMult = 1.5;
	}


});

