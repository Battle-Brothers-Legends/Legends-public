this.profession_legend_negotiator <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {
		NegotiationAnnoyanceMult = 0.5,
		AdvancePaymentCap = 0.75
	},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendNegotiator);
	}

	function getDynamicTooltip(_def, _active) {
		local ret = [
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png"
				text = "Improved negotiation payout"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/plus.png"
				text = "Current: [color=%positive%]" + (1 + ::Legends.Professions.getProfessionEffect(_def, 0)) * 100 + "%[/color]"
			},
		];

		if (!_active) {
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/level_dark.png"
				text = "Next: [color=%positive%]" + (1 + ::Legends.Professions.getProfessionEffect(_def, 1)) * 100 + "%[/color]"
			});
		}
	}
});
