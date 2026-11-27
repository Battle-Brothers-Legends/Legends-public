this.profession_legend_scrap_efficiency <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendScrapEfficiency);
	}

	function getDynamicTooltip(_def, _active) {
		local ret = [
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png"
				text = "Less durability salvaged for each tool"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/plus.png"
				text = "Current: [color=%positive%]" + ::Math.round(::Math.minf(0.4, ::Legends.Professions.getProfessionEffect(_def, 0)) * 100) + "%[/color]"
			}
		];

		if (!_active) {
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/level_dark.png"
				text = "Next: [color=%positive%]" + ::Math.round(::Math.minf(0.4, ::Legends.Professions.getProfessionEffect(_def, 1)) * 100) + "%[/color]"
			});
		}

		return ret;
	}
});
