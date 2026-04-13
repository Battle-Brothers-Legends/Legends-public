this.perk_legend_favoured_enemy_undead <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},

	function create() {
		this.legend_favoured_enemy_skill.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendFavouredEnemyUndead);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.ValidTypes = this.Const.LegendMod.FavoriteUndead;
		this.m.BraveryMult = 1.5; // This was in the old vampire fav enemy perk
	}

});
