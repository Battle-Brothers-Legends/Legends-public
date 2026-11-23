this.profession_legend_dog_breeder <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendDogBreeder);
	}

	function getDynamicTooltip(_def, _active) {
		local ret = [
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png"
				text = "Crafting speed"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/plus.png"
				text = "Current: [color=%positive%]" + (::Legends.Professions.getProfessionEffect(_def, 0) == 0	? 1	: ::Legends.Professions.getProfessionEffect(_def, 0)) * 100 + "%[/color]"
			},
		];

		if (!_active) {
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/level_dark.png"
				text = "Next: [color=%positive%]" + ::Legends.Professions.getProfessionEffect(_def, 1) * 100 + "%[/color]"
			});
		}

		ret.extend([
			{
				id = 13,
				type = "text",
				icon = "ui/icons/special.png"
				text = "Chance for a downed animal to survive"
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/plus.png"
				text = "Current: [color=%positive%]" + 100 * ::Legends.Professions.getAnimalSurvivalChance(0) + "%[/color]"
			},
		]);

		if (!_active) {
			ret.push({
				id = 15,
				type = "text",
				icon = "ui/icons/level_dark.png"
				text = "Next: [color=%positive%]" + 100 * ::Legends.Professions.getAnimalSurvivalChance(1) + "%[/color]"
			});
		}

		return ret;
	}
});
