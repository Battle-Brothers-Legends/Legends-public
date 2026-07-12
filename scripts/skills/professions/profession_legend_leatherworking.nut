this.profession_legend_leatherworking <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendLeatherworking);
	}
});
