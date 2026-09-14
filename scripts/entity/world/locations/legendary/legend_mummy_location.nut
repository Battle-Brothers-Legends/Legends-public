this.legend_mummy_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "An ancient ruin, in a style of architecture you have never seen before.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.legend_mummy";
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = true;
		this.m.IsAttackable = false;
		this.m.IsDestructible = false;
		this.m.VisibilityMult = 0.8;
		this.m.Resources = 0;
		this.m.OnEnter = "event.location.legend_mummy_enter";
	}

	function onSpawned()
	{
		this.m.Name = "Ancient Pyramid";
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
		body.setBrush("legend_pyramid");
		local banner = this.addSprite("banner");
		banner.setOffset(this.createVec(-60, 50));
	}

	function onDropLootForPlayer ( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(this.Math.rand(0, 60), _lootTable);
		this.dropTreasure(this.Math.rand(3, 4), [
			"loot/white_pearls_item",
			"loot/jeweled_crown_item",
			"loot/gemstones_item",
			"loot/golden_chalice_item",
			"loot/ancient_gold_coins_item",
			"misc/legend_ancient_scroll_item",
			"misc/legend_masterwork_metal",
			"misc/legend_masterwork_fabric",
			"misc/legend_masterwork_tools"
		], _lootTable);
	}

});

