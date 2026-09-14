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
		return "Craft items in selected order when encamped. Partial progress is kept.";
	}
});
