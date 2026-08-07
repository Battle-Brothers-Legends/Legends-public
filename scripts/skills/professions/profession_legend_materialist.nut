this.profession_legend_materialist <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendMaterialist);
	}

	function getDynamicTooltip(_def, _active) {
		local ret = [
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png"
				text = "Looted item repair state"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/plus.png"
				text = "Current: [color=%positive%]" + (0.35 + ::Legends.Professions.getProfessionEffect(_def, 0)) * 100 + "%[/color]"
			},
		];

		if (!_active) {
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/level_dark.png"
				text = "Next: [color=%positive%]" + (0.35 + ::Legends.Professions.getProfessionEffect(_def, 1)) * 100 + "%[/color]"
			});
		}
		
		return ret;
	}
});
