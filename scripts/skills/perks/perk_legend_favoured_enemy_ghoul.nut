this.perk_legend_favoured_enemy_ghoul <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendFavouredEnemyGhoul);
		this.m.ValidTypes = this.Const.LegendMod.FavoriteGhoul;
	}

});

