this.profession_legend_skillful_stacking <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendSkillfulStacking);
	}
});
