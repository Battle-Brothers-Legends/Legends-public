this.profession_legend_meal_preparation <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendMealPreparation);
	}
});
