this.painter_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {},
	function create()
	{
		this.camp_building.create();
		this.m.ID = ::Const.World.CampBuildings.Painter;
		this.m.Slot = "painter";
		this.m.Name = "Painting Tent";
		this.m.Description = "Here you can repaint your armor.";
		this.m.InCommanderTent = false;
		this.m.TerrainLabel = "00";
		local sounds = getCampSounds(6, "scrap");
		this.m.Sounds = sounds;
		this.m.SoundsAtNight = sounds;
	}

	function getDescription() {
		return "Customize the appearance of weapons and armor in the company.";
	}

	function getLevel()	{
		return "empty";
	}

	function isHidden() {
		return ::Legends.Settings.skipCamp() ? false : !::World.Flags.get(::Legends.Camp.Flag.Painter);
	}
});

