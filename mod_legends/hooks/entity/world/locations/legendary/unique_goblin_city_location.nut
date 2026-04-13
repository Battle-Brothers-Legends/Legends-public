::mods_hookExactClass("entity/world/locations/legendary/unique_goblin_city_location", function(o)
{
	o.m.MeleeEnemies <- [
		[75, this.Const.World.Spawn.Troops.LegendGoblinHarrier],
		[25, this.Const.World.Spawn.Troops.LegendGoblinPlunderer],
		[35, this.Const.World.Spawn.Troops.LegendGoblinBerserker]
	];
	o.m.RiderEnemies <- [
		[75, this.Const.World.Spawn.Troops.LegendGoblinWhiteDirewolfRider],
		[25, this.Const.World.Spawn.Troops.LegendGoblinDirewolfRider]
	];
	o.m.RangedEnemies <- [
		[35, this.Const.World.Spawn.Troops.GoblinAmbusher],
		[65, this.Const.World.Spawn.Troops.LegendGoblinTribeDefender]
	];
	o.m.SpecialEnemies <- [
		[35, this.Const.World.Spawn.Troops.GoblinShaman],
		[35, this.Const.World.Spawn.Troops.LegendGoblinWitchDoctor],
		[50, this.Const.World.Spawn.Troops.GoblinOverseer]
	];

	o.onSpawned = function ()
	{
		// 3 melee champs, 3 ranged champs, 3 rider champs and 4 special champs 
		this.m.Name = "Rul\'gazhix";
		this.location.onSpawned();
		for( local i = 0; i < 10; i++ )
		{
			this.Const.World.Common.addTroop(this, {
				Type = ::MSU.Class.WeightedContainer(this.m.MeleeEnemies).roll()
			}, false);
		}

		for( local i = 0; i < 3; i++ )
		{
			this.Const.World.Common.addTroop(this, {
				Type = ::MSU.Class.WeightedContainer(this.m.MeleeEnemies).roll()
			}, false, 100);
		}

		for( local i = 0; i < 4; i++ )
		{
			this.Const.World.Common.addTroop(this, {
				Type = ::MSU.Class.WeightedContainer(this.m.RangedEnemies).roll()
			}, false);
		}

		for( local i = 0; i < 7; i++ )
		{
			this.Const.World.Common.addTroop(this, {
				Type = ::MSU.Class.WeightedContainer(this.m.RiderEnemies).roll()
			}, false);
		}

		for( local i = 0; i < 2; i++ )
		{
			this.Const.World.Common.addTroop(this, {
			Type = this.Const.World.Spawn.Troops.LegendGoblinWitchDoctor
			}, false, 100);

			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.GoblinOverseer
			}, false, 100);
		}

		for( local i = 0; i < 7; i++ )
		{
			this.Const.World.Common.addTroop(this, {
				Type = ::MSU.Class.WeightedContainer(this.m.RangedEnemies).roll()
			}, false, 100);
		}

		for( local i = 0; i < 3; i++ )
		{
			this.Const.World.Common.addTroop(this, {
				Type = ::MSU.Class.WeightedContainer(this.m.RiderEnemies).roll()
			}, false, 100);
		}

		for( local i = 0; i < 5; i++ )
		{
			this.Const.World.Common.addTroop(this, {
				Type = ::MSU.Class.WeightedContainer(this.m.RiderEnemies).roll()
			}, false);
		}

		for( local i = 0; i < 8; i++ )
		{
			this.Const.World.Common.addTroop(this, {
				Type = ::MSU.Class.WeightedContainer(this.m.MeleeEnemies).roll()
			}, false);
		}

		for( local i = 0; i < 7; i++ )
		{
			this.Const.World.Common.addTroop(this, {
				Type = ::MSU.Class.WeightedContainer(this.m.RangedEnemies).roll()
			}, false);
		}

		for( local i = 0; i < 3; i++ )
		{
			this.Const.World.Common.addTroop(this, {
				Type = ::MSU.Class.WeightedContainer(this.m.SpecialEnemies).roll()
			}, false);
		}
	}

	o.onBeforeCombatStarted = function ()
	{
		this.location.onBeforeCombatStarted();
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
			"trade/furs_item",
			"trade/salt_item",
			"trade/dies_item",
			"trade/amber_shards_item",
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/ancient_gold_coins_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"misc/legend_ancient_scroll_item",
			"misc/legend_masterwork_metal",
			"misc/legend_masterwork_fabric",
			"misc/legend_masterwork_tools"
		], _lootTable);
		// _lootTable.push(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Legendary.legend_emperors_countenance]]));
	}
});
