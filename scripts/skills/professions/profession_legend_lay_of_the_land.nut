this.profession_legend_lay_of_the_land <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendLayOfTheLand);
	}
});
