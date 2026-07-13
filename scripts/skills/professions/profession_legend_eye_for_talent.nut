this.profession_legend_eye_for_talent <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendEyeForTalent);
	}
});
