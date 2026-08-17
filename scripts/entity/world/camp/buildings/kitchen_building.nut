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
