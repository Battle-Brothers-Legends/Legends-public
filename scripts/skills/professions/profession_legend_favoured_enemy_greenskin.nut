this.profession_legend_favoured_enemy_greenskin <- this.inherit("scripts/skills/professions/profession_legend_favoured_enemy", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendFavouredEnemyGreenskin);
		this.profession_legend_favoured_enemy.create();
	}
});
