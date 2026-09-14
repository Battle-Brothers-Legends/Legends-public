this.repair_upgrade <- this.inherit("scripts/retinue/follower", {
	m = {},

	function create() {
		this.follower.create();
		this.m.ID = ::Legends.Camp.Upgrades[::Legends.Camp.CampBuildings.Repair];
		this.m.Name = "Blacksmith's Tools";
		this.m.Description = "No forge can function without an anvil or a hammer. And no company can function for long without a blacksmith.";
		this.m.Image = "ui/campfire/legend_repair";
		this.m.Cost = 5000;
		this.m.Effects = [
			"Increases repairing speed by 33%",
			"Increases tool efficiency by 33%"
		];
	}
});
