this.perk_legend_favoured_enemy_civilization <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendFavouredEnemyCivilization);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.ValidTypes = this.Const.LegendMod.FavoriteCivilization;
	}

	// this perk is handled in starting scenario
});

