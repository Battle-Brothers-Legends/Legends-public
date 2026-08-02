this.profession_legend_off_book_deal <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {
		ExtraItemPercentage = 20,
		RarityMult = 1.2
	},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendOffBookDeal);
	}

	function getDynamicTooltip(_def, _active) {
		local ret = [
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png"
				text = "Off Book Deal prices"
			}
		];

		if (::Legends.Professions.getProfessionEffect(_def) > 0) {
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/plus.png"
				text = "Current: [color=%negative%]" + Math.ceil((2 / ::Legends.Professions.getProfessionEffect(_def, 0)) * 100) + "%[/color]"
			});
		}

		if (!_active) {
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/level_dark.png"
				text = "Next: [color=%negative%]" + Math.ceil((2 / ::Legends.Professions.getProfessionEffect(_def, 1)) * 100) + "%[/color]"
			});
		}

		return ret;
	}
});
