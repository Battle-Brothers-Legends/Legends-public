::mods_hookExactClass("entity/world/locations/goblin_city_location", function(o)
{
	o.create = function ()
	{
		this.location.create();
		this.m.TypeID = "location.goblin_city";
		this.m.LocationType = ::Const.World.LocationType.Lair | ::Const.World.LocationType.Unique;
		this.m.CombatLocation.Template[0] = "tactical.goblin_camp";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.Walls;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = true;
		this.m.IsDespawningDefenders = false;
		this.m.VisibilityMult = 0.8;
		this.m.Resources = 500;

		this.m.Resources += ::Math.floor(::Math.max(0, ::World.getTime().Days - ::Legends.Difficulty.GoblinCity[::World.Assets.getCombatDifficulty()]));
	}

	o.onDropLootForPlayer = function ( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(::Math.rand(0, 100), _lootTable);
		this.dropArmorParts(::Math.rand(10, 20), _lootTable);
		this.dropAmmo(::Math.rand(25, 100), _lootTable);
		this.dropMedicine(::Math.rand(0, 10), _lootTable);
		this.dropFood(::Math.rand(4, 8), [
			"strange_meat_item",
			"roots_and_berries_item",
			"pickled_mushrooms_item"
		], _lootTable);
		this.dropTreasure(::Math.rand(2, 3), [
			"trade/salt_item",
			"trade/dies_item",
			"trade/amber_shards_item",
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/ancient_gold_coins_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/goblin_carved_ivory_iconographs_item",
			"loot/goblin_minted_coins_item",
			"loot/goblin_rank_insignia_item",
			"trade/salt_item",
			"trade/dies_item",
			"trade/amber_shards_item",
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/ancient_gold_coins_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/goblin_carved_ivory_iconographs_item",
			"loot/goblin_minted_coins_item",
			"loot/goblin_rank_insignia_item",
			"trade/salt_item",
			"trade/dies_item",
			"trade/amber_shards_item",
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/ancient_gold_coins_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/goblin_carved_ivory_iconographs_item",
			"loot/goblin_minted_coins_item",
			"loot/goblin_rank_insignia_item",
			"misc/legend_ancient_scroll_item"
		], _lootTable);
		_lootTable.push(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Legendary.legend_emperors_countenance]]));
	}
});
