this.perk_legend_staff_spins <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendStaffSpins);
	}

	function onUpdate(_properties) {
		_properties.IsSpecializedInStaffStun = true;
	}
});
