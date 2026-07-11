this.profession_legend_dog_breeder <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendDogBreeder);
	}
});
