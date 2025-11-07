this.perk_legend_favoured_enemy_master_archer <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendFavouredEnemyArcher);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.ValidTypes = this.Const.LegendMod.FavoriteArcher;
	}

	function onAfterUpdate( _properties )
	{
		_properties.RangedAttackBlockedChanceMult *= 0.66;
	}

});

