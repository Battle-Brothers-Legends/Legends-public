this.profession_legend_spot_the_tells <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendSpotTheTells);
	}
});
