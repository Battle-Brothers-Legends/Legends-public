this.profession_legend_favoured_enemy_swordmaster <- this.inherit("scripts/skills/professions/profession_legend_favoured_enemy", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendFavouredEnemySwordmaster);
		this.profession_legend_favoured_enemy.create();
	}
});
