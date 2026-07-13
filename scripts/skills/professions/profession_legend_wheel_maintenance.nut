this.profession_legend_wheel_maintenance <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendWheelMaintenance);
	}
});
