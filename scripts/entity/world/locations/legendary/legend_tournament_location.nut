this.legend_tournament_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "A walled tournament ground.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.legend_tournament";
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = true;
		this.m.IsAttackable = false;
		this.m.IsDestructible = false;
		this.m.VisibilityMult = 0.8;
		this.m.Resources = 0;
		this.m.OnEnter = "event.location.legend_tournament_enter";
	}

	function onSpawned()
	{
		this.m.Name = "Tournament";
		this.location.onSpawned();
	}

	function onDiscovered()
	{
		this.location.onDiscovered();
		this.World.Flags.increment("LegendaryLocationsDiscovered", 1);
	}


	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("legend_tournament");
		local banner = this.addSprite("banner");
		banner.setOffset(this.createVec(-60, 50));
	}

	function onEnter()
	{
		this.World.Events.fire(this.m.OnEnter);
	}


});

