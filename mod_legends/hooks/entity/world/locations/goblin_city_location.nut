::mods_hookExactClass("entity/world/locations/goblin_city_location", function(o)
{
	o.create = function ()
	{
		this.location.create();
		this.m.TypeID = "location.goblin_city";
		this.m.LocationType = this.Const.World.LocationType.Lair | this.Const.World.LocationType.Unique;
		this.m.CombatLocation.Template[0] = "tactical.goblin_camp";
		this.m.CombatLocation.Fortification = this.Const.Tactical.FortificationType.Walls;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = true;
		this.m.IsDespawningDefenders = false;
		this.m.VisibilityMult = 0.8;
		this.m.Resources = 500;

		local dateToSkip = 0;
		switch (this.World.Assets.getCombatDifficulty())
		{
			case this.Const.Difficulty.Easy:
				dateToSkip = 400;
				break;
			case this.Const.Difficulty.Normal:
				dateToSkip = 300;
				break;
			case this.Const.Difficulty.Hard:
				dateToSkip = 200;
				break;
			case this.Const.Difficulty.Legendary:
				dateToSkip = 100;
				break;
		}

		if (this.World.getTime().Days >= dateToSkip)
		{
			local bonus = this.Math.floor(this.World.getTime().Days - dateToSkip);
			this.m.Resources += bonus;
		}
	}

	o.onDropLootForPlayer = function ( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(0, 100), _lootTable);
		this.dropArmorParts(this.Math.rand(10, 20), _lootTable);
		this.dropAmmo(this.Math.rand(25, 100), _lootTable);
		this.dropMedicine(this.Math.rand(0, 10), _lootTable);
		this.dropFood(this.Math.rand(4, 8), [
			"strange_meat_item",
			"roots_and_berries_item",
			"pickled_mushrooms_item"
		], _lootTable);
		this.dropTreasure(this.Math.rand(2, 3), [
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
		_lootTable.push(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Legendary.legend_emperors_countenance]]));
	}
});
