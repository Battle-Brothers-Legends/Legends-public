this.stables_building <- this.inherit("scripts/entity/world/settlements/buildings/building", {
	m = {},
	function create()
	{
		this.building.create();
		this.m.ID = "building.stables";
		this.m.Name = "Stables";
		this.m.Description = "Stables for horses";
		this.m.UIImage = "ui/settlements/building_14";
		this.m.UIImageNight = "ui/settlements/building_14_night";
		this.m.Tooltip = "world-town-screen.main-dialog-module.Stables";
		this.m.TooltipIcon = "ui/icons/buildings/stables.png";
		this.m.Sounds = [
			{
				File = "ambience/buildings/kennel_cage_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_cage_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_cage_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_07.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_08.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_09.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_10.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_11.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_12.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
		this.m.SoundsAtNight = [
			{
				File = "ambience/buildings/kennel_cage_00.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_cage_01.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_cage_02.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_00.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_01.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_02.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_03.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_04.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_05.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_06.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_07.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_08.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_09.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_10.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_11.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_12.wav",
				Volume = 0.5,
				Pitch = 1.0
			}
		];
	}

	function onClicked( _townScreen )
	{
		_townScreen.getStablesDialogModule().setRosterID(this.m.Settlement.getID());
		_townScreen.showStablesDialog();
		this.pushUIMenuStack();
	}

	function onSettlementEntered()
	{
	}

	function onUpdateStablesList( _list )
	{
		_list.push("legend_horse_rouncey");
		_list.push("legend_donkey_background")
	}

	function onSerialize( _out )
	{
		this.building.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.building.onDeserialize(_in);
	}
});

