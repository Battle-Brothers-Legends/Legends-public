this.kitchen_upgrade <- this.inherit("scripts/retinue/follower", {
	m = {},

	function create() {
		this.follower.create();
		this.m.ID = ::Legends.Camp.Upgrades[::Legends.Camp.CampBuildings.Kitchen];
		this.m.Name = "Cook's Cauldron";
		this.m.Description = "A heavy iron pot in which stew is boiled. Proper grub for weary mercenaries.";
		this.m.Image = "ui/campfire/legend_kitchen";
		this.m.Cost = 3000;
		this.m.Effects = [
			"Increase cooking speed by 15%"
		];
	}
});
