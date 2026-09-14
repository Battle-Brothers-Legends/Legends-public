this.training_upgrade <- this.inherit("scripts/retinue/follower", {
	m = {},

	function create() {
		this.follower.create();
		this.m.ID = ::Legends.Camp.Upgrades[::Legends.Camp.CampBuildings.Training];
		this.m.Name = "Training Grounds";
		this.m.Description = "Dull swords, heavy weights and a training dummy - tools which can turn a farmer into a mercenary.";
		this.m.Image = "ui/campfire/legend_training";
		this.m.Cost = 5000;
		this.m.Effects = [
			"Allows brothers to train more intensively and permanently increase their stats",
			"Reduces the chance of getting injured while training",
		];
	}
});
