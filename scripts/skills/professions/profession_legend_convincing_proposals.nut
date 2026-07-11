this.profession_legend_convincing_proposals <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendConvincingProposals);
	}
});
