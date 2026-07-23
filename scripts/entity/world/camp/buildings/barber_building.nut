this.barber_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {},
	function create() {
		this.camp_building.create();
		this.m.ID = ::Const.World.CampBuildings.Barber;
		this.m.Slot = "barber";
		this.m.Name = "Barber";
		this.m.Description = "Customize the appearance of the mercenaries in the company.";
		this.m.InCommanderTent = false;
		local sounds = [];
		for (local i = 1; i <= 2; i++) {
			sounds.push({
				File = format("ambience/camp/camp_barber_%02d.wav", i),
				Volume = 1.0,
				Pitch = 1.0
			});
		}
		this.m.Sounds = sounds;
		this.m.SoundsAtNight = sounds;
	}

	function getLevel()	{
		return "dude_full";
	}

	function isHidden() {
		if (::Legends.Settings.skipCamp())
			return false;
		return !::World.Flags.get(::Legends.Camp.Flag.Barber);
	}

	function onClicked( _campScreen ) {
		_campScreen.showBarberDialog();
		this.camp_building.onClicked(_campScreen);
	}
});
