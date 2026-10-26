this.perk_legend_favoured_enemy_undead <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendFavouredEnemyUndead);
		this.legend_favoured_enemy_skill.create();
		this.m.BraveryMult = 1.5;
	}

	function getDynamicTooltip(_actor = null) {
		return this.legend_favoured_enemy_skill.getDynamicTooltip(_actor);
	}
});
