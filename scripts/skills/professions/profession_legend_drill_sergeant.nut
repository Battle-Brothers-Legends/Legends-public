this.profession_legend_drill_sergeant <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendDrillSergeant);
	}
});
