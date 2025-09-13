::mods_hookExactClass("entity/tactical/enemies/spider_eggs", function(o)
{
	o.m.SpawnDelay <- 0; // Number of combat rounds before the egg can spawn spiders; 0 = on Round 1 onwards, 1 = only on Round 2 onwards etc.
	o.m.MaxSpawnCount <- 4; // The maximum number of spider spawns allowed. Vanilla is always 4

	local create = o.create;
	o.create = function () {
		create();
		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++)
		{
			this.m.OnDeathLootTable.extend([
				[60, "scripts/items/loot/webbed_valuables_item"],
				[30, "scripts/items/misc/spider_silk_item"]
			]);
		}
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);

	}

	o.assignRandomEquipment <- function ()
	{
		local armor = [
			[1, ::Legends.Armor.Ancient.ancient_priest_attire]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[99, ::Legends.Helmet.Ancient.ancient_priest_diadem]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

	o.onSpawn = function ( _tile )
	{
		if (_tile.IsEmpty)
		{
			return;
		}

		if (!_tile.IsOccupiedByActor || _tile.getEntity().getType() != this.Const.EntityType.SpiderEggs || ::Tactical.TurnSequenceBar.getCurrentRound() < 1 + this.getSpawnDelay())
		{
			return;
		}

		if (this.Tactical.Entities.isEnemyRetreating())
		{
			return;
		}

		local tile;

		for( local i = 0; i < 6; i = ++i )
		{
			if (!_tile.hasNextTile(i))
			{
			}
			else
			{
				local nextTile = _tile.getNextTile(i);

				if (!nextTile.IsEmpty || this.Math.abs(nextTile.Level - _tile.Level) > 1)
				{
				}
				else
				{
					tile = nextTile;
					break;
				}
			}
		}

		if (tile != null)
		{
			local spawn = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_spider_cluster", tile.Coords);
			// spawn.setSize(this.Math.rand(60, 75) * 0.01);
			spawn.setFaction(this.getFaction());
			// spawn.m.XP = spawn.m.XP / 2;
			// spawn.setName(spawn.getName() + " Hatchling");
			local allies = this.Tactical.Entities.getInstancesOfFaction(this.getFaction());

			foreach( a in allies )
			{
				if (a.getType() == this.Const.EntityType.Hexe)
				{
					::Legends.Effects.grant(spawn, ::Legends.Effect.FakeCharmed);
					break;
				}
			}

			++this.m.Count;
		}

		if (this.m.Count < this.getMaxSpawnCount())
		{
			this.registerSpawnEvent();
		}
		else
		{
			this.killSilently();
		}
	}

	o.getSpawnDelay <- function ()
	{
		return this.m.SpawnDelay;
	}

	o.setSpawnDelay <- function ( _turns )
	{
		this.m.SpawnDelay = _turns;
	}

	o.getMaxSpawnCount <- function ()
	{
		return this.m.MaxSpawnCount;
	}

	o.setMaxSpawnCount <- function ( _int )
	{
		this.m.MaxSpawnCount = _int;
	}
});
