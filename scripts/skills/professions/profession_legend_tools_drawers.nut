this.profession_legend_tools_drawers <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendToolsDrawers);
	}
});
