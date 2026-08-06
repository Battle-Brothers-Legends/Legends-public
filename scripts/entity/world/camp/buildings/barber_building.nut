this.barber_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {},
	function create() {
		this.camp_building.create();
		this.m.ID = ::Const.World.CampBuildings.Barber;
		this.m.Slot = "barber";
		this.m.Name = "Barber";
		this.m.Description = "Customize the appearance of the mercenaries in the company.";
		this.m.InCommanderTent = false;
		local sounds = this.getCampSounds(2, this.m.Slot);
		this.m.Sounds = sounds;
		this.m.SoundsAtNight = sounds;
	}

	function getLevel()	{
		return "dude_full";
	}

	function isHidden() {
		return ::Legends.Settings.skipCamp() ? false : !::World.Flags.get(::Legends.Camp.Flag.Barber);
	}
});
