this.perk_legend_favoured_enemy_civilization <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendFavouredEnemyCivilization);
		this.m.ValidTypes = this.Const.LegendMod.FavoriteCivilization;
	}

	// this perk is handled in starting scenario
});

