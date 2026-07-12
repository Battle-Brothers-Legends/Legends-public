this.profession_legend_tailoring <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendTailoring);
	}
});
