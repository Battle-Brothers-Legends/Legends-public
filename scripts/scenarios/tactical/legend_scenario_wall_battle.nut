this.legend_scenario_wall_battle <- this.inherit("scripts/scenarios/tactical/scenario_template", {
	m = {},
	function generate()
	{
		this.logDebug("ScenarioEarlyGame::generate()");
		this.createStash();
		this.initMap();
		this.initEntities();
		this.initStash();
		this.m.Music = this.Const.Music.UndeadTracks;
		local clouds = this.Tactical.getWeather().createCloudSettings();
		clouds.Type = this.getconsttable().CloudType.Fog;
		clouds.MinClouds = 16;
		clouds.MaxClouds = 16;
		clouds.MinVelocity = 3.0;
		clouds.MaxVelocity = 9.0;
		clouds.MinAlpha = 0.3;
		clouds.MaxAlpha = 0.4;
		clouds.MinScale = 2.0;
		clouds.MaxScale = 3.0;
		this.Tactical.getWeather().buildCloudCover(clouds);
		this.Tactical.CameraDirector.addJumpToTileEvent(0, this.Tactical.getTile(6, 6 - 6 / 2), 1, null, null, 0, 100);
	}

	function initMap()
	{
		local testMap = this.MapGen.get("tactical.plains_camp");
		local minX = testMap.getMinX();
		local minY = testMap.getMinY();
		this.Tactical.resizeScene(minX, minY);
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
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/bludgeon"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/billhook"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet]]));
		items.equip(this.new("scripts/items/armor/padded_surcoat"));
		items.equip(this.new("scripts/items/weapons/boar_spear"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		items.equip(this.new("scripts/items/armor/padded_leather"));
		items.equip(this.new("scripts/items/weapons/shortsword"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		items.equip(this.new("scripts/items/armor/padded_surcoat"));
		items.equip(this.new("scripts/items/weapons/boar_spear"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/scramasax"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/sackcloth"));
		items.equip(this.new("scripts/items/weapons/short_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.straw_hat]]));
		items.equip(this.new("scripts/items/armor/sackcloth"));
		items.equip(this.new("scripts/items/weapons/short_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));

		for( local i = 0; i < 10; i = ++i )
		{
			entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_bandit_thug");
			entity.setFaction(this.Const.Faction.Undead);
			entity.assignRandomEquipment();
		}

		for( local i = 0; i < 5; i = ++i )
		{
			entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_bandit_poacher");
			entity.setFaction(this.Const.Faction.Undead);
			entity.assignRandomEquipment();
		}

		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_bandit_raider", 15, 23, 15, 23);
		entity.setFaction(this.Const.Faction.Undead);
		entity.assignRandomEquipment();
	}

	function spawnEntity( _script, _minX = 10, _maxX = 25, _minY = 10, _maxY = 25 )
	{
		local x = 0;
		local y = 0;

		while (1)
		{
			x = this.Math.rand(_minX, _maxX);
			y = this.Math.rand(_minY, _maxY) - x / 2;

			if (x < _minX && y < _minY - x / 2)
			{
				continue;
			}

			if (this.Tactical.getTile(x, y).Level == 3)
			{
				continue;
			}

			if (this.Tactical.getTile(x, y).IsEmpty)
			{
				break;
			}
		}

		return this.Tactical.spawnEntity(_script, x, y);
	}

	function initStash()
	{
		this.Stash.clear();
		this.Stash.resize(63);
		this.Stash.setLocked(false);
		this.Stash.add(this.new("scripts/items/weapons/knife"));
		this.Stash.add(this.new("scripts/items/weapons/dagger"));
		this.Stash.add(this.new("scripts/items/weapons/scramasax"));
		this.Stash.add(this.new("scripts/items/weapons/hatchet"));
		this.Stash.add(this.new("scripts/items/weapons/hatchet"));
		this.Stash.add(this.new("scripts/items/weapons/hatchet"));
		this.Stash.add(this.new("scripts/items/weapons/billhook"));
		this.Stash.add(this.new("scripts/items/weapons/militia_spear"));
		this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
		this.Stash.add(this.new("scripts/items/weapons/wooden_stick"));
		this.Stash.add(this.new("scripts/items/weapons/bludgeon"));
		this.Stash.add(this.new("scripts/items/weapons/bludgeon"));
		this.Stash.add(this.new("scripts/items/weapons/bludgeon"));
		this.Stash.add(this.new("scripts/items/weapons/reinforced_wooden_flail"));
		this.Stash.add(this.new("scripts/items/weapons/reinforced_wooden_flail"));
		this.Stash.add(this.new("scripts/items/weapons/butchers_cleaver"));
		this.Stash.add(this.new("scripts/items/weapons/butchers_cleaver"));
		this.Stash.add(this.new("scripts/items/weapons/pitchfork"));
		this.Stash.add(this.new("scripts/items/weapons/short_bow"));
		this.Stash.add(this.new("scripts/items/weapons/short_bow"));
		this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
		this.Stash.add(this.new("scripts/items/shields/buckler_shield"));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		this.Stash.add(this.new("scripts/items/armor/sackcloth"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
	}

});

