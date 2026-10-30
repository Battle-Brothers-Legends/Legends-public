this.profession_legend_favoured_enemy_undead <- this.inherit("scripts/skills/professions/profession_legend_favoured_enemy", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendFavouredEnemyUndead);
		this.profession_legend_favoured_enemy.create();
		this.m.BraveryMult = 1.5;
	}
});
