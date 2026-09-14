this.crafting_upgrade <- this.inherit("scripts/retinue/follower", {
	m = {},

	function create() {
		this.follower.create();
		this.m.ID = ::Legends.Camp.Upgrades[::Legends.Camp.CampBuildings.Crafting];
		this.m.Name = "Organized Inventory";
		this.m.Description = "Boxes, vials and racks - all organized well, so the craftsman always knows where to look.";
		this.m.Image = "ui/campfire/legend_crafting";
		this.m.Cost = 3000;
		this.m.Effects = [
			"Increase crafting speed by 15%"
		];
	}
});
