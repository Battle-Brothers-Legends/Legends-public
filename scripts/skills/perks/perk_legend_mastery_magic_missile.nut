this.perk_legend_mastery_magic_missile <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMasteryMagicMissile);
	}
});
