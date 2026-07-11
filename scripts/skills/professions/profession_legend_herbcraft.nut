this.profession_legend_herbcraft <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendHerbcraft);
	}
});
