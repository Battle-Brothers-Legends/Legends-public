this.profession_legend_favoured_enemy_beast <- this.inherit("scripts/skills/professions/profession_legend_favoured_enemy", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendFavouredEnemyBeast);
		this.profession_legend_favoured_enemy.create();
	}
});
