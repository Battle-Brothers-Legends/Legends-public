this.commander_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {},
	function create() {
		this.camp_building.create();
		this.m.ID = ::Legends.Camp.CampBuildings.Commander;
		this.m.Slot = "commander";
		this.m.Name = "Commanders Tent";
		this.m.Description = "Assign mercenaries to different tasks while encamped.";
		// this.m.UIImage = "ui/settlements/commander_day";
		// this.m.UIImageNight = "ui/settlements/commander_night";
		// this.m.UIImageFull = "ui/settlements/commander_day";
		// this.m.UIImageNightFull = "ui/settlements/commander_night";
		this.m.InCommanderTent = false;
	}

	function isHidden() {
		return false;
	}

	function getLevel()	{
		return "full";
	}

	function getDescription() {
		return "Take care of your company needs while campaigning. Assign brothers to work in tents. Every tent action requires time and is only performed while camping unless stated otherwise. Tents can be upgraded in the retinue screen.";
	}
});
