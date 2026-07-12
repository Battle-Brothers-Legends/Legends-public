this.profession_legend_trophy_carving <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendTrophyCarving);
	}
});
