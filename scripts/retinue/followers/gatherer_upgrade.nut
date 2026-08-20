this.gatherer_upgrade <- this.inherit("scripts/retinue/follower", {
	m = {},

	function create() {
		this.follower.create();
		this.m.ID = ::Legends.Camp.Upgrades[::Legends.Camp.CampBuildings.Gatherer];
		this.m.Name = "Gatherer's Tools";
		this.m.Description = "Long treks into the wilds require being able to take care of oneself. And to carry the supplies.";
		this.m.Image = "ui/campfire/legend_gathering";
		this.m.Cost = 5000;
		this.m.Effects = [
			"Increase gathering speed by 15%",
			"Reduces the chance of getting injured while gathering"
			//"produce more kinds of medicine." "Having both an upgraded tent and skilled apothecaries can provide rare medicines, and powerful potions."
		];
	}
});
