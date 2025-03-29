this.legend_spider_nest_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "Webknechts have made a nest here. Their eggs and webs make for a treacherous place for both unsuspecting travellers and the hapless townsfolk abducted from nearby settlements.";
	}

	function create()
	{
		this.location.create();
		this.m.Name = "Webknecht Nest";
		this.m.TypeID = "location.spider_nest";
		this.m.LocationType = ::Const.World.LocationType.Lair | ::Const.World.LocationType.Passive;
		this.m.IsDespawningDefenders = false;
		this.m.IsAttackable = true; // No enemies in the location; currently relies on the contract to define it. TODO: make this a naturally spawnable location with spiders?
		this.m.Resources = 0;
	}

	function onSpawned()
	{
		this.m.Name = "Webknecht Nest";
		this.location.onSpawned();
	}

	function onDropLootForPlayer( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		local treasure = [
			"misc/spider_silk_item",
			"misc/spider_silk_item",
			"misc/poison_gland_item",
			"misc/poison_gland_item",
			"loot/webbed_valuables_item",
		];
		this.dropTreasure(this.Math.rand(1, 2), treasure, _lootTable);
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("legend_spider_nest");
		body.setHorizontalFlipping(this.Math.rand(0, 1) == 1);
	}

});

