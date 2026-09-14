this.perk_legend_conservation <- this.inherit("scripts/skills/skill", {
	m = {
		MedicinePerDayMult = 0.5
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendConservation);
		this.m.Icon = "ui/perks/possess56.png";
		this.m.IconDisabled = "ui/perks/possess56_bw.png";
	}

});
