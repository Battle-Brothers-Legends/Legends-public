this.enchanter_building <- this.inherit("scripts/entity/world/camp/item_crafting_building", {
	m = {
		ActivityName = "Enchant",
		BaseCraft = 30.0,
	},
	function create() {
		this.camp_building.create();
		this.m.ID = ::Legends.Camp.CampBuildings.Enchanter;
		this.m.Slot = "enchant";
		this.m.Name = "Enchant";
		this.m.Description = "Oooo.. Pretty glowing things...";
		this.m.BannerImage = "ui/buttons/banner_enchant.png";
		local sounds = this.getCampSounds(14, this.m.Slot);
		this.m.Sounds = sounds;
		this.m.SoundsAtNight = sounds;
	}

	function isHidden() {
		return ::World.getPlayerRoster().getAll().filter(@(_, _bro) _bro.getBackground().getModifiers().Enchanting > 0).len() != 0;
	}

	function getDescription() {
		return "Inscribe runes in selected order when encamped. Partial progress is kept. Only the Vala can work here.";
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
});
