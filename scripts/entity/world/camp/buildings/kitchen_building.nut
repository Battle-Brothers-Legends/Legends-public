this.kitchen_building <- this.inherit("scripts/entity/world/camp/item_crafting_building", {
	m = {
		ActivityName = "Cook"
	},
	function create() {
		this.camp_building.create();
		this.m.ID = ::Legends.Camp.CampBuildings.Kitchen;
		this.m.Slot = "cook";
		this.m.Name = "Kitchen";
		this.m.TerrainLabel = "00";
		this.m.BannerImage = "ui/buttons/banner_cook.png";
	}

	function getDescription() {
		return "Cook food in selected order when encamped. Partial progress is kept.";
	}

	function getModifierTooltip() {
		this.init();
		local mod = this.getModifiers();
		local ret = [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/plus.png",
				text = "There is [color=%positive%]" + this.m.Queue.len() + "[/color] food in the queue."
			},
			{
				id = 4,
				type = "text",
				icon = "ui/buttons/icon_time.png",
				text = "It will take [color=%positive%]" + this.getRequiredTime() + "[/color] hours to cook all food."
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/repair_item.png",
				text = "Total cooking modifier is [color=%positive%]" + mod.Craft + "[/color] units per hour."
			}
		];
		local id = 6;
		foreach (bro in mod.Modifiers) {
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

	function getModifiers() {
		local ret = {
			Craft = 0.0,
			Assigned = 0,
			Modifiers = []
		}
		foreach (bro in ::World.getPlayerRoster().getAll()) {
			if (bro.getCampAssignment() != this.m.ID) {
				continue;
			}

			local rm = this.m.BaseCraft * bro.getBackground().getModifiers().Cooking;
			ret.Craft += rm;
			++ret.Assigned;
			ret.Modifiers.push([rm, bro.getName(), bro.getBackground().getNameOnly()]);
		}

		if (this.getUpgraded()) {
			ret.Craft *= 1.15;
		}

		return ret;
	}
});
