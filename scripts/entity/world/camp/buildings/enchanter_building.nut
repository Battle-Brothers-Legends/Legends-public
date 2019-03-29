this.enchanter_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {},
    function create()
    {
        this.camp_building.create();
        this.m.ID = this.Const.World.CampBuildings.Enchanter;
        this.m.Slot = "enchanter";
        this.m.Name = "Enchanter";
        this.m.Description = "Oooo.. Pretty glowing things..."
		this.m.BannerImage = "ui/buttons/banner_enchant.png"
		// this.m.UIImage = "ui/settlements/vala_day_empty";
		// this.m.UIImageNight = "ui/settlements/vala_night_empty";
		// this.m.UIImageFull = "ui/settlements/vala_day_full";
		// this.m.UIImageNightFull = "ui/settlements/vala_night_full";
		this.m.Sounds = [
			{
				File = "ambience/camp/camp_vala_chanting_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_chanting_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_07.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_08.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_09.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_10.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_stones_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_stones_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_stones_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_stones_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
		this.m.SoundsAtNight = [
				{
				File = "ambience/camp/camp_vala_chanting_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_chanting_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_07.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_08.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_09.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_10.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_stones_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_stones_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_stones_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_stones_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
    }

    function getRequiredTime()
    {
		return 0;
        // local points = 0;
		// if (this.m.Queue == null)
        // {
        //     return 0;
        // }
        
        // foreach (r in this.m.Queue)
        // {
        //     if (r == null)
        //     {
        //         continue;
        //     }
            
        //     points += r.Blueprint.getCost();
        // }
        // local modifiers = this.getModifiers();
		// if (modifiers.Craft <= 0)
		// {
		// 	return 0
		// }
        // return this.Math.ceil(points / modifiers.Craft);
    }

	function getLevel()
	{
		return "empty";
	}
	
	function getResourceImage()
	{
		return "ui/buttons/icon_time.png";
	}

	function getResourceCount()
	{
		return this.getRequiredTime();
	}

	function onClicked( _campScreen )
	{
        _campScreen.showEnchanterDialog();
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