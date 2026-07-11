this.profession_legend_butcher_barber <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendButcherBarber);
	}
});
