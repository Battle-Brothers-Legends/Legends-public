this.perk_legend_favoured_enemy_schrat <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendFavouredEnemySchrat);
		this.m.ValidTypes = this.Const.LegendMod.FavoriteSchrat;
	}

});

