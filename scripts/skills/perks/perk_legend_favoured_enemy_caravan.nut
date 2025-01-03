this.perk_legend_favoured_enemy_caravan <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendFavouredEnemyCaravan);
		this.m.ValidTypes = this.Const.LegendMod.FavoriteCaravan;
	}

	// this perk is handled in starting scenario
});

