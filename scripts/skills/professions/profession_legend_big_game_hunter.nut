this.profession_legend_big_game_hunter <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendBigGameHunter);
	}
});
