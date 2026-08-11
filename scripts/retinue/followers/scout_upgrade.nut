this.scout_upgrade <- this.inherit("scripts/retinue/follower", {
	m = {},

	function create() {
		this.follower.create();
		this.m.ID = ::Legends.Camp.Upgrades[::Legends.Camp.CampBuildings.Scout];
		this.m.Name = "Mapping Stand";
		this.m.Description = "Maps, documents and scouting reports. Necessary equipment of every serious commander.";
		this.m.Image = "ui/campfire/legend_scout";
		this.m.Cost = 10000;
		this.m.Effects = [
			"Increase scouting speed by 15%",
			"Reduces the chance of getting injured while scouting",
			"Allows scouting nearby locations"
		];
	}
});
