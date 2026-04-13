this.painter_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {},
	function create()
	{
		this.camp_building.create();
		this.m.ID = this.Const.World.CampBuildings.Painter;
		this.m.Slot = "painter";
		this.m.Name = "Painting Tent";
		this.m.Description = "Here you can repaint your armor.";
		this.m.InCommanderTent = false;
		this.m.TerrainLabel = "00";
		this.m.Sounds = [
			{
				File = "ambience/camp/camp_scrap_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
		this.m.SoundsAtNight = [
			{
				File = "ambience/camp/camp_scrap_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
	}

	function getDescription()
	{
		local desc = "";
		desc = desc + "Here you can spend your crowns to change the style of each piece of armour of each unit in your company ";
		return desc;
	}

	function getLevel()
	{
		return "empty";
	}

	function isHidden() {
		if (::Legends.Settings.skipCamp())
			return false;
		return !::World.Flags.get("HasLegendCampPainter");
	}

	function onClicked( _campScreen )
	{
		_campScreen.showPainterDialog();
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

