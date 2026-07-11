this.profession_legend_silver_tongued <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendSilverTongued);
	}
});
