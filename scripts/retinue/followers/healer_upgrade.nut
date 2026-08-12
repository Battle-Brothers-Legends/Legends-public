this.healer_upgrade <- this.inherit("scripts/retinue/follower", {
	m = {},

	function create() {
		this.follower.create();
		this.m.ID = ::Legends.Camp.Upgrades[::Legends.Camp.CampBuildings.Healer];
		this.m.Name = "Surgeon's Table";
		this.m.Description = "A sturdy table and all the instruments needed to stich flesh and set limbs. Or to saw them off if needs be.";
		this.m.Image = "ui/campfire/legend_healer";
		this.m.Cost = 10000;
		this.m.Effects = [
			"Increase health regeneration speed by 15%",
			"Decreases the medicine cost of treating injuries by 25% and time by 33%",
			"Enables intensive treatment - healing hitpoints faster at the cost of medicine"			
		];
	}
});
