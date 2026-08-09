this.crafting_building <- this.inherit("scripts/entity/world/camp/item_crafting_building", {
	m = {
		ActivityName = "Craft"
	},
	function create() {
		this.camp_building.create();
		this.m.ID = ::Legends.Camp.CampBuildings.Crafting;
		this.m.ModName = "Crafting";
		this.m.BaseCraft = 10.0;
		this.m.Slot = "craft";
		this.m.Name = "Craft";
		this.m.Description = "Craft items";
		this.m.BannerImage = "ui/buttons/banner_craft.png";
		local sounds = this.getCampSounds(7, "taxidermist");
		this.m.Sounds = sounds;
		this.m.SoundsAtNight = sounds;
	}

	function getDescription() {
		//"An upgraded tent has a 15% increase in crafting speed.";
		return "Craft items in selected order when encamped. Partial progress is kept.";
	}

	function getModifierTooltip() {
		this.init();
		local mod = this.getModifiers();
		local ret = [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/plus.png",
				text = "There are [color=%positive%]" + this.m.Queue.len() + "[/color] items in the crafting queue."
			},
			{
				id = 4,
				type = "text",
				icon = "ui/buttons/icon_time.png",
				text = "It will take [color=%positive%]" + this.getRequiredTime() + "[/color] hours to craft all items."
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/repair_item.png",
				text = "Total crafting modifier is [color=%positive%]" + mod.Craft + "[/color] units per hour."
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
});
