this.profession_legend_hammer_them_out <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendHammerThemOut);
	}
});
