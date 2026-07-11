this.profession_legend_efficient_packing <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendEfficientPacking);
	}
});
