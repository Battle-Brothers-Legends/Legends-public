this.perk_legend_favoured_enemy_occult <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendFavouredEnemyOccult);
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.ValidTypes = ::Const.LegendMod.FavoriteOccult;
		this.m.BraveryMult = 1.5;
	}

});

