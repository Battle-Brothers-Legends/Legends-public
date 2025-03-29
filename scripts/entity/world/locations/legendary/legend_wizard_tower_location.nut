this.legend_wizard_tower_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "The tallest tower you have ever seen, looks like it might fall over";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.legend_wizard_tower";
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = false;
		this.m.VisibilityMult = 0.8;
		this.m.Resources = 0;
		this.m.OnEnter = "event.location.legend_enter_wizard_tower";
	}

	function onSpawned()
	{
		this.m.Name = "Teetering Tower";
		this.location.onSpawned();
	}

	function onDiscovered()
	{
		this.location.onDiscovered();
		this.World.Flags.increment("LegendaryLocationsDiscovered", 1);

		if (this.World.Flags.get("LegendaryLocationsDiscovered") >= 10)
		{
			this.updateAchievement("FamedExplorer", 1, 1);
		}
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("seer_tower");
	}

});
