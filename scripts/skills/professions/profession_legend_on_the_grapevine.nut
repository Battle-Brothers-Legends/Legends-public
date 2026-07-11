this.profession_legend_on_the_grapevine <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendOnTheGrapevine);
	}
});
