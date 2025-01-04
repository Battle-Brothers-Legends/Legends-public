this.perk_legend_favoured_enemy_ork <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendFavouredEnemyOrk);
		this.m.ValidTypes = this.Const.LegendMod.FavoriteOrc;
	}

});

