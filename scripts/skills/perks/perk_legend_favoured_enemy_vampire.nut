this.perk_legend_favoured_enemy_vampire <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendFavouredEnemyVampire);
		this.m.ValidTypes = this.Const.LegendMod.FavoriteVampire;
		this.m.BraveryMult = 1.5;
	}

});

