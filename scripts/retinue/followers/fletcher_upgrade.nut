this.fletcher_upgrade <- this.inherit("scripts/retinue/follower", {
	m = {},

	function create() {
		this.follower.create();
		this.m.ID = ::Legends.Camp.Upgrades[::Legends.Camp.CampBuildings.Fletcher];
		this.m.Name = "Ammunition Stores";
		this.m.Description = "Nothing warms a fighters heart like a full stockpile of ammunition.";
		this.m.Image = "ui/campfire/legend_fletcher";
		this.m.Cost = 3000;
		this.m.Effects = [
			"Increase fletching speed by 15%",
			//"Occasionally craft throwing spears and javelins"
		];
	}
});
