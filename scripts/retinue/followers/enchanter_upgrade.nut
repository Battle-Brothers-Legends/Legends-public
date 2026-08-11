this.enchanter_upgrade <- this.inherit("scripts/retinue/follower", {
	m = {},

	function create() {
		this.follower.create();
		this.m.ID = ::Legends.Camp.Upgrades[::Legends.Camp.CampBuildings.Enchanter];
		this.m.Name = "Enchanter's Abode";
		this.m.Description = "The right tools, incense and a generous amount of candles all serve to create the proper setting for runecrafting.";
		this.m.Image = "ui/campfire/legend_enchanter";
		this.m.Cost = 10000;
		this.m.Effects = [
			"Increase enchanting speed by 15%",
			"Produced runes have 50% increased potential"
		];
	}
});
