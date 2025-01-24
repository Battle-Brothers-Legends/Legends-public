this.legend_basilisk_drone_low <- this.inherit("scripts/entity/tactical/enemies/legend_basilisk_drone", {
	m = {},
	function create()
	{
		m.NormalAIChance = 90;
		this.legend_basilisk_drone.create();
		getFlags().add("low");
	}

	function onInit()
	{
		this.legend_basilisk_drone.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendBasiliskDroneLow); //weaker version of Drone

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		getSkills().update();
	}

});

