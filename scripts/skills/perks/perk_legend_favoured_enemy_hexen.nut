this.perk_legend_favoured_enemy_hexen <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendFavouredEnemyHexen);
		this.m.ValidTypes = this.Const.LegendMod.FavoriteHexe;
		this.m.BraveryMult = 1.5;
	}

});

