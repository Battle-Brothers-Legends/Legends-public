this.perk_legend_favoured_enemy_swordmaster <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendFavouredEnemySwordmaster);
		this.m.ValidTypes = this.Const.LegendMod.FavoriteSwordmaster;
	}

});

