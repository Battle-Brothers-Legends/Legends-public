this.profession_legend_favoured_enemy_outlaw <- this.inherit("scripts/skills/professions/profession_legend_favoured_enemy", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendFavouredEnemyOutlaw);
		this.profession_legend_favoured_enemy.create();
	}
});
