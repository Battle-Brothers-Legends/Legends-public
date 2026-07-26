this.profession_legend_tradesman <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendTradesman);
	}

	function getDynamicTooltip(_def, _active) {
		local ret = [
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png"
				text = "Renown for selling goods"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/plus.png"
				text = "Current: [color=%positive%]" + ::Legends.Professions.getProfessionEffect(_def, 0) + "%[/color] gold value"
			},
		];

		if (!_active) {
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/level_dark.png"
				text = "Next: [color=%positive%]" + ::Legends.Professions.getProfessionEffect(_def, 1) + "%[/color] gold value"
			});
		}
	}
});
