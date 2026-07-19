this.profession_legend_amusing_ourselves_to_death <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendAmusingOurselvesToDeath);
	}
});
