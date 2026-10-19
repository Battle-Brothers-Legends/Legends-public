this.perk_legend_favoured_enemy_civilization <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendFavouredEnemyCivilization);
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.ValidTypes = ::Const.LegendMod.FavoriteCivilization;
	}

	function getDynamicTooltip (_actor = null) {
		return this.legend_favoured_enemy_skill.getDynamicTooltip(_actor);
	}
});

