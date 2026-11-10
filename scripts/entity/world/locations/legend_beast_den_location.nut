this.legend_beast_den_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function create()
	{
		this.location.create();
		this.m.TypeID = "location.legend_beast_den";
		this.m.LocationType = this.Const.World.LocationType.Lair | this.Const.World.LocationType.Passive;
		this.m.IsAttackable = false;
		this.m.IsSpawningDefenders = false;
		this.m.IsDespawningDefenders = false;
		this.m.IsShowingDefenders = false;
		this.m.IsDroppingLoot = false;
		this.m.Resources = 0;
	}

	function onSpawned()
	{
		this.m.Name = "Beast Den";
		this.m.Description = "Tracks lead into this cave in the rocks. Whatever made them is still inside.";
		this.location.onSpawned();
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");

		if (this.getTile().Type == this.Const.World.TerrainType.Steppe)
		{
			body.setBrush("world_cave_steppe_01");
		}
		else
		{
			body.setBrush("world_cave_01");
		}
	}

});
