this.perk_legend_favoured_enemy_direwolf <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendFavouredEnemyDirewolf);
		this.m.ValidTypes = this.Const.LegendMod.FavoriteDirewolf;
		this.m.BraveryMult = 1.0;
	}

});

