this.profession_legend_bounty_hunter <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendBountyHunter);
	}
});
