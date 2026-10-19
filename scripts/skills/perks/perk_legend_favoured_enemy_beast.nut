this.perk_legend_favoured_enemy_beast <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendFavouredEnemyBeast);
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.ValidTypes = ::Const.LegendMod.FavoriteBeast;
		this.m.BraveryMult = 1.0;
	}

	function getDynamicTooltip (_actor = null) {
		return this.legend_favoured_enemy_skill.getDynamicTooltip(_actor);
	}
});

