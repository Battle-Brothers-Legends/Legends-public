this.profession_legend_net_repair <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendNetRepair);
	}

	function getDynamicTooltip(_def, _active) {
		local ret = [
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png"
				text = "Net repair cost"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/plus.png"
				text = "Current: [color=%positive%]" + (::Legends.Professions.getProfessionEffect(_def) != 0 ? ::Math.round(15 / ::Legends.Professions.getProfessionEffect(_def)) : 15) + "[/color]"
			},
		];

		if (!_active) {
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/level_dark.png"
				text = "Next: [color=%positive%]" + ::Math.round(15 / ::Legends.Professions.getProfessionEffect(_def, 1)) + "[/color]"
			});
		}

		return ret;
	}
});
