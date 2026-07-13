this.profession_legend_alcohol_preparation <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendAlcoholPreparation);
	}
});
