this.perk_legend_favoured_enemy_swordmaster <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendFavouredEnemySwordmaster);
		this.legend_favoured_enemy_skill.create();
	}

	function getDynamicTooltip(_actor = null) {
		return this.legend_favoured_enemy_skill.getDynamicTooltip(_actor);
	}
});
