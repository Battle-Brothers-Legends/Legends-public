this.commander_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {},
	function create()
	{
		this.camp_building.create();
		this.m.ID = this.Const.World.CampBuildings.Commander;
		this.m.Slot = "commander";
		this.m.Name = "Commanders Tent";
		this.m.Description = "Assign company members to different tasks while encamped";
		// this.m.UIImage = "ui/settlements/commander_day";
		// this.m.UIImageNight = "ui/settlements/commander_night";
		// this.m.UIImageFull = "ui/settlements/commander_day";
		// this.m.UIImageNightFull = "ui/settlements/commander_night";
		this.m.InCommanderTent = false;
	}

	function getLevel()
	{
		return "full";
	}

	function getDescription()
	{
		local desc = "";
		desc += "The camp system allows your company to be more self sufficient while out on campaign. ";
		desc += "Injuries treated, equipment repaired, tools salvaged from old equipment, hunt for food, gather medicine, training, crafting, restock ammo supplies... ";
		desc += "Inside the commanders, each brother can be assigned to a tent to perform the task. Need food? Assign a couple brothers to hunt. Need more ammo, assign to fletchers tent. ";
		desc += "In general, the currency of camping is time. It requires time to perform all the actions. The more brothers assigned to the task, the less time it'll take to perform it.";
		desc += "While all backgrounds can perform any task, some backgrounds are more suited to the task. Hunters will be better at hunting than the tailors.";
		desc += "\n\n";
		desc += "Company starts out only knowing how to do repairs and rest. Visiting settlements that perform the analogous task will unlock it in the camp. All camp activities can be upgraded ";
		desc += "by purchasing an upgraded tent variant from a settlement marketplace. Upgraded tents increase performance and many come with significant bonuses.";
		return desc;
	}

	function onClicked( _campScreen )
	{
		_campScreen.showCommanderDialog();
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
