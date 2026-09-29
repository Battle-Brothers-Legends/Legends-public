this.perk_legend_dog_whisperer <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendDogWhisperer);
	}
});
