this.profession_legend_drill_sergeant <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendDrillSergeant);
	}

	function getDynamicTooltip(_def, _active) {
		local ret = [
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png"
				text = "Extra experience for non-veterans"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/plus.png"
				text = "Current: [color=" + ::Const.UI.Color.PositiveValue + "]" + ::Legends.Professions.getProfessionEffect(_def, 0) + "%[/color]"
			},
		]

		if (!_active) {
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/level_dark.png"
				text = "Next: [color=" + ::Const.UI.Color.PositiveValue + "]" + ::Legends.Professions.getProfessionEffect(_def, 1) + "%[/color]"
			});
		}

		return ret;
	}
});