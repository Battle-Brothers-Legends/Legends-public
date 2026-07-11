this.profession_legend_cut_to_the_chase <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendCutToTheChase);
	}
});
