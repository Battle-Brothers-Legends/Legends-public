this.profession_legend_negotiator <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {
		NegotiationAnnoyanceMult = 0.5,
		AdvancePaymentCap = 0.75
	},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendNegotiator);
	}
});
