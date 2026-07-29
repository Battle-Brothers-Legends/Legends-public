this.enchanter_building <- this.inherit("scripts/entity/world/camp/item_crafting_building", {
	m = {
		ActivityName = "Enchant",
		BaseCraft = 30.0,
	},
	function create() {
		this.camp_building.create();
		this.m.ID = this.Const.World.CampBuildings.Enchanter;
		this.m.Slot = "enchant";
		this.m.Name = "Enchant";
		this.m.Description = "Oooo.. Pretty glowing things...";
		this.m.BannerImage = "ui/buttons/banner_enchant.png";
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

	function isHidden() {
		foreach (bro in ::World.getPlayerRoster().getAll()) {
			if (bro.getBackground().getModifiers().Enchanting > 0) {
				return false;
			}
		}
		return true;
	}

	function getDescription() {
		local desc = "";
		desc += "Tha Vala emporium of mystical (and maybe even magical) mischief. While encamped, the Vala can retreat into her books and experiments. ";
		desc += "Rune requests can be queued up for the Vala to try her hand at. What comes of them, you'll just have to wait and see what she inscribes. ";
		desc += "Only the Vala can be assigned to the Enchanting tent. The Vala can innately enchant runes, but the enchanting speed will increase by 30% if she is over level 12.";
		desc += "\n\n";
		desc += "The Enchanting tent can be upgraded by purchasing a crafting cart from a settlement merchant. An upgraded tent has a 15% increase in enchanting speed.";
		desc += "Additionally, the upgraded tools and equipment from the cart allows the Vala to produce potentially more powerful Runes.";
		return desc;
	}

	function getModifierTooltip() {
		this.init();
		local mod = this.getModifiers();
		local ret = [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/plus.png",
				text = "There are [color=%positive%]" + this.m.Queue.len() + "[/color] rune inscriptions in the queue."
			},
			{
				id = 4,
				type = "text",
				icon = "ui/buttons/icon_time.png",
				text = "It will take [color=%positive%]" + this.getRequiredTime() + "[/color] hours to inscribe all runes."
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/repair_item.png",
				text = "Total enchanting modifier is [color=%positive%]" + mod.Craft + "[/color] units per hour."
			}
		];
		local id = 6;
		foreach (bro in mod.Modifiers)
		{
			ret.push({
				id = id,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]" + bro[0] + "[/color] units/hour " + bro[1] + " (" + bro[2] + ")"
			});
			++id;
		}
		return ret;
	}

	function getModifiers()	{
		local ret =	{
			Craft = 0.0,
			Assigned = 0,
			Modifiers = []
		}
		foreach(bro in ::World.getPlayerRoster().getAll()) {
			if (bro.getCampAssignment() != this.m.ID) {
				continue;
			}

			local rm = this.m.BaseCraft * bro.getBackground().getModifiers().Enchanting;
			if (bro.getLevel() >= 12) {
				rm *= 1.3;
			}
			ret.Craft += rm;
			++ret.Assigned;
			ret.Modifiers.push([rm, bro.getName(), bro.getBackground().getNameOnly()]);
		}

		if (this.getUpgraded())	{
			ret.Craft *= 1.15;
		}

		return ret;
	}

	function onBroEnter ( _bro ) {
		return _bro.getBackground().getModifiers().Enchanting > 0;
	}

	function onClicked( _campScreen ) {
		_campScreen.showEnchanterDialog();
		this.camp_building.onClicked(_campScreen);
	}
});
