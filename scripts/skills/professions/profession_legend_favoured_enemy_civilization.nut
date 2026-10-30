this.profession_legend_favoured_enemy_civilization <- this.inherit("scripts/skills/professions/profession_legend_favoured_enemy", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendFavouredEnemyCivilization);
		this.profession_legend_favoured_enemy.create();
	}
});
