this.legend_scenario_wall_battle <- this.inherit("scripts/scenarios/tactical/scenario_template", {
	m = {},
	function generate()
	{
		this.logDebug("ScenarioEarlyGame::generate()");
		this.createStash();
		this.initMap();
		this.initEntities();
		this.initStash();
		this.m.Music = ::Const.Music.UndeadTracks;
		local clouds = ::Tactical.getWeather().createCloudSettings();
		clouds.Type = this.getconsttable().CloudType.Fog;
		clouds.MinClouds = 16;
		clouds.MaxClouds = 16;
		clouds.MinVelocity = 3.0;
		clouds.MaxVelocity = 9.0;
		clouds.MinAlpha = 0.3;
		clouds.MaxAlpha = 0.4;
		clouds.MinScale = 2.0;
		clouds.MaxScale = 3.0;
		::Tactical.getWeather().buildCloudCover(clouds);
		::Tactical.CameraDirector.addJumpToTileEvent(0, ::Tactical.getTile(6, 6 - 6 / 2), 1, null, null, 0, 100);
	}

	function initMap()
	{
		local testMap = this.MapGen.get("tactical.plains_camp");
		local minX = testMap.getMinX();
		local minY = testMap.getMinY();
		::Tactical.resizeScene(minX, minY);
		testMap.fill({
			X = 0,
			Y = 0,
			W = minX,
			H = minY
		}, null);
	}

	function initEntities()
	{
		local entity;
		local items;
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 3, 4, 7);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/bludgeon"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/billhook"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet]]));
		items.equip(this.new("scripts/items/legend_armor/cloth/legend_armor_quilted_aketon"));
		items.equip(this.new("scripts/items/weapons/boar_spear"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		items.equip(this.new("scripts/items/armor/padded_leather"));
		items.equip(this.new("scripts/items/weapons/shortsword"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		items.equip(this.new("scripts/items/legend_armor/cloth/legend_armor_quilted_aketon"));
		items.equip(this.new("scripts/items/weapons/boar_spear"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/scramasax"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/sackcloth"));
		items.equip(this.new("scripts/items/weapons/short_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.straw_hat]]));
		items.equip(this.new("scripts/items/armor/sackcloth"));
		items.equip(this.new("scripts/items/weapons/short_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));

		for( local i = 0; i < 10; i = ++i )
		{
			entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_bandit_thug");
			entity.setFaction(::Const.Faction.Undead);
			entity.assignRandomEquipment();
		}

		for( local i = 0; i < 5; i = ++i )
		{
			entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_bandit_poacher");
			entity.setFaction(::Const.Faction.Undead);
			entity.assignRandomEquipment();
		}

		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_bandit_raider", 15, 23, 15, 23);
		entity.setFaction(::Const.Faction.Undead);
		entity.assignRandomEquipment();
	}

	function spawnEntity( _script, _minX = 10, _maxX = 25, _minY = 10, _maxY = 25 )
	{
		local x = 0;
		local y = 0;

		while (1)
		{
			x = ::Math.rand(_minX, _maxX);
			y = ::Math.rand(_minY, _maxY) - x / 2;

			if (x < _minX && y < _minY - x / 2)
			{
				continue;
			}

			if (::Tactical.getTile(x, y).Level == 3)
			{
				continue;
			}

			if (::Tactical.getTile(x, y).IsEmpty)
			{
				break;
			}
		}

		return ::Tactical.spawnEntity(_script, x, y);
	}

	function initStash()
	{
		::Stash.clear();
		::Stash.resize(63);
		::Stash.setLocked(false);
		::Stash.add(this.new("scripts/items/weapons/knife"));
		::Stash.add(this.new("scripts/items/weapons/dagger"));
		::Stash.add(this.new("scripts/items/weapons/scramasax"));
		::Stash.add(this.new("scripts/items/weapons/hatchet"));
		::Stash.add(this.new("scripts/items/weapons/hatchet"));
		::Stash.add(this.new("scripts/items/weapons/hatchet"));
		::Stash.add(this.new("scripts/items/weapons/billhook"));
		::Stash.add(this.new("scripts/items/weapons/militia_spear"));
		::Stash.add(this.new("scripts/items/weapons/boar_spear"));
		::Stash.add(this.new("scripts/items/weapons/wooden_stick"));
		::Stash.add(this.new("scripts/items/weapons/bludgeon"));
		::Stash.add(this.new("scripts/items/weapons/bludgeon"));
		::Stash.add(this.new("scripts/items/weapons/bludgeon"));
		::Stash.add(this.new("scripts/items/weapons/reinforced_wooden_flail"));
		::Stash.add(this.new("scripts/items/weapons/reinforced_wooden_flail"));
		::Stash.add(this.new("scripts/items/weapons/butchers_cleaver"));
		::Stash.add(this.new("scripts/items/weapons/butchers_cleaver"));
		::Stash.add(this.new("scripts/items/weapons/pitchfork"));
		::Stash.add(this.new("scripts/items/weapons/short_bow"));
		::Stash.add(this.new("scripts/items/weapons/short_bow"));
		::Stash.add(this.new("scripts/items/shields/wooden_shield"));
		::Stash.add(this.new("scripts/items/shields/buckler_shield"));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		::Stash.add(this.new("scripts/items/armor/sackcloth"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
	}

});

