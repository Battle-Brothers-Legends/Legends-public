this.profession_legend_size_them_up <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendSizeThemUp);
	}
});
