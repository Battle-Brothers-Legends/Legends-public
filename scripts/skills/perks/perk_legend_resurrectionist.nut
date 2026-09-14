this.perk_legend_resurrectionist <- this.inherit("scripts/skills/skill", {
	m = {
		LootChance = 5
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendResurrectionist);
		this.m.Icon = "ui/perks/possess56.png";
		this.m.IconDisabled = "ui/perks/possess56_bw.png";
	}

});
