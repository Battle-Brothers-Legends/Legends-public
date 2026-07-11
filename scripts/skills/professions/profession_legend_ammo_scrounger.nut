this.profession_legend_ammo_scrounger <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendAmmoScrounger);
	}
});
