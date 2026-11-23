this.perk_legend_reclamation <- this.inherit("scripts/skills/skill", {
	m = {
		LootChance = 20
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendReclamation);
		this.m.Icon = "ui/perks/possess56.png";
		this.m.IconDisabled = "ui/perks/possess56_bw.png";
	}

});
