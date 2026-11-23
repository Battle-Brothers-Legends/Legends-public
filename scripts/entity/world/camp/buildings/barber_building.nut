this.barber_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {},
	function create()
	{
		this.camp_building.create();
		this.m.ID = this.Const.World.CampBuildings.Barber;
		this.m.Slot = "barber";
		this.m.Name = "Barber";
		this.m.Description = "Customize the appearance of the men in the company.";
		this.m.InCommanderTent = false;
		this.m.Sounds = [
			{
				File = "ambience/camp/barber_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/barber_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/barber_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/barber_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/barber_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/barber_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/barber_07.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
		this.m.SoundsAtNight = [
					{
				File = "ambience/camp/barber_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/barber_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/barber_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/barber_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/barber_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/barber_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/barber_07.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];

	}

	function getLevel()
	{
		return "dude_full";
	}

	function isHidden() {
		if (::Legends.Settings.skipCamp())
			return false;
		return !::World.Flags.get("HasLegendCampBarber");
	}

	function onClicked( _campScreen )
	{
		_campScreen.showBarberDialog();
		this.camp_building.onClicked(_campScreen);
	}

	function onSerialize( _out )
	{
		this.camp_building.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.camp_building.onDeserialize(_in);
	}

});
