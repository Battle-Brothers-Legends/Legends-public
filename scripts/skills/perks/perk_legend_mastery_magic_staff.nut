this.perk_legend_mastery_magic_staff <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMasteryMagicStaff);
	}

	function onUpdate(_properties) {
		_properties.IsSpecializedInStaves = true;
	}
});
