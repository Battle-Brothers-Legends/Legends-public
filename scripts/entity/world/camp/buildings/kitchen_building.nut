this.kitchen_building <- this.inherit("scripts/entity/world/camp/item_crafting_building", {
	m = {
		ActivityName = "Cook",
		BaseCraft = 40.0 // only the Cooking modifier of a brother counts, so one with 25% cooks at 10 an hour
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
		return "Cook food in selected order when encamped. Partial progress is kept. Only brothers that know how to cook can work here.";
	}

	function getModifiers() {
		local ret = {
			Craft = 0.0,
			Assigned = 0,
			Modifiers = []
		}
		local self = this;
		local assignedBros = ::World.getPlayerRoster().getAll().filter(@(_, _bro)(_bro.getCampAssignment() == self.m.ID));
		foreach (bro in assignedBros) {
			local rm = this.m.BaseCraft * bro.getCurrentProperties().Modifiers.Cooking;
			ret.Craft += rm;
			++ret.Assigned;
			ret.Modifiers.push([rm, bro.getName(), bro.getBackground().getNameOnly()]);
		}

		if (this.getUpgraded()) {
			ret.Craft *= 1.15;
		}

		return ret;
	}

	function onBroEnter(_bro) {
		return _bro.getCurrentProperties().Modifiers.Cooking > 0;
	}
});
