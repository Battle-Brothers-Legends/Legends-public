this.workshop_upgrade <- this.inherit("scripts/retinue/follower", {
	m = {},

	function create() {
		this.follower.create();
		this.m.ID = ::Legends.Camp.Upgrades[::Legends.Camp.CampBuildings.Workshop];
		this.m.Name = "Salvage Racks";
		this.m.Description = "Material oft goes to waste when there isn't enough space to take full stock of the inventory.";
		this.m.Image = "ui/campfire/legend_workshop";
		this.m.Cost = 2000;
		this.m.Effects = [
			"Increases salvage speed by 15%",
			"Increases tool efficiency by 100%"
		];
	}
});
