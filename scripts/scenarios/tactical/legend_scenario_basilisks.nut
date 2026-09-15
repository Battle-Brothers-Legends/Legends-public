this.legend_scenario_basilisks <- this.inherit("scripts/scenarios/tactical/scenario_template", {
	m = {},
	function generate()
	{
		this.logDebug("ScenarioDefendTheHill::generate()");
		this.createStash();
		this.initMap();
		this.initEntities();
		this.initStash();
		this.m.Music = ::Const.Music.BeastsTracks;
		local entity;

		for( local i = 0; i < 8; i = ++i )
		{
			entity = this.spawnEntity("scripts/entity/tactical/humans/militia");
			entity.assignRandomEquipment();
			entity.killSilently();
		}

		::Tactical.Entities.makeEnemiesKnownToAI();
		local clouds = ::Tactical.getWeather().createCloudSettings();
		clouds.Type = this.getconsttable().CloudType.StaticFog;
		clouds.MinClouds = 12;
		clouds.MaxClouds = 18;
		clouds.MinAlpha = 0.25;
		clouds.MaxAlpha = 0.5;
		clouds.MinScale = 2.0;
		clouds.MaxScale = 3.0;
		::Tactical.getWeather().buildCloudCover(clouds);
		local rain = ::Tactical.getWeather().createRainSettings();
		rain.MinDrops = 150;
		rain.MaxDrops = 150;
		rain.NumSplats = 50;
		rain.MinVelocity = 400.0;
		rain.MaxVelocity = 500.0;
		rain.MinAlpha = 1.0;
		rain.MaxAlpha = 1.0;
		rain.MinScale = 0.75;
		rain.MaxScale = 1.0;
		::Tactical.getWeather().buildRain(rain);
		::Tactical.getWeather().setAmbientLightingPreset(5);
		::Tactical.getWeather().setAmbientLightingSaturation(0.9);
		::Sound.setAmbience(0, ::Const.SoundAmbience.Rain, ::Const.Sound.Volume.Ambience, 0);
	}

	function initMap()
	{
		local testMap = this.MapGen.get("tactical.defend_the_hill");
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
		entity = this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_helm]]));
		items.equip(this.new("scripts/items/armor/coat_of_plates"));
		items.equip(this.new("scripts/items/weapons/legend_zweihander"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Named.norse_helmet]]));
		items.equip(this.new("scripts/items/armor/mail_shirt"));
		items.equip(this.new("scripts/items/weapons/hand_axe"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
		items.equip(this.new("scripts/items/armor/mail_shirt"));
		items.equip(this.new("scripts/items/weapons/hand_axe"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]));
		items.equip(this.new("scripts/items/armor/mail_shirt"));
		items.equip(this.new("scripts/items/weapons/winged_mace"));
		items.equip(this.new("scripts/items/shields/named/named_red_white_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/boar_spear"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		items.equip(this.new("scripts/items/armor/gambeson"));
		items.equip(this.new("scripts/items/weapons/crossbow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		items.equip(this.new("scripts/items/legend_armor/cloth/legend_armor_quilted_aketon"));
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/hatchet"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/padded_leather"));
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_basilisk_drone", 12, 18, 7, 10);
		entity.setFaction(::Const.Faction.Beasts);
		entity.assignRandomEquipment();

		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_basilisk_drone", 12, 18, 7, 10);
		entity.setFaction(::Const.Faction.Beasts);
		entity.assignRandomEquipment();

		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_basilisk_drone", 12, 18, 7, 10);
		entity.setFaction(::Const.Faction.Beasts);
		entity.assignRandomEquipment();

		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_basilisk_drone", 12, 18, 7, 10);
		entity.setFaction(::Const.Faction.Beasts);
		entity.assignRandomEquipment();
	}

	function spawnEntity( _script, _minX = 8, _maxX = 26, _minY = 8, _maxY = 26 )
	{
		local x = 0;
		local y = 0;

		while (1)
		{
			x = ::Math.rand(_minX, _maxX);
			y = ::Math.rand(_minY, _maxY) - x / 2;

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
		::Stash.resize(117);
		::Stash.setLocked(false);
		::Stash.add(this.new("scripts/items/weapons/dagger"));
		::Stash.add(this.new("scripts/items/weapons/hand_axe"));
		::Stash.add(this.new("scripts/items/weapons/warhammer"));
		::Stash.add(this.new("scripts/items/weapons/warhammer"));
		::Stash.add(this.new("scripts/items/weapons/falchion"));
		::Stash.add(this.new("scripts/items/weapons/arming_sword"));
		::Stash.add(this.new("scripts/items/weapons/noble_sword"));
		::Stash.add(this.new("scripts/items/weapons/military_cleaver"));
		::Stash.add(this.new("scripts/items/weapons/military_cleaver"));
		::Stash.add(this.new("scripts/items/weapons/legend_zweihander"));
		::Stash.add(this.new("scripts/items/weapons/legend_zweihander"));
		::Stash.add(this.new("scripts/items/weapons/billhook"));
		::Stash.add(this.new("scripts/items/weapons/billhook"));
		::Stash.add(this.new("scripts/items/weapons/winged_mace"));
		::Stash.add(this.new("scripts/items/weapons/winged_mace"));
		::Stash.add(this.new("scripts/items/weapons/flail"));
		::Stash.add(this.new("scripts/items/weapons/flail"));
		::Stash.add(this.new("scripts/items/weapons/boar_spear"));
		::Stash.add(this.new("scripts/items/weapons/boar_spear"));
		::Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		::Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		::Stash.add(this.new("scripts/items/weapons/crossbow"));
		::Stash.add(this.new("scripts/items/weapons/crossbow"));
		::Stash.add(this.new("scripts/items/shields/wooden_shield"));
		::Stash.add(this.new("scripts/items/shields/wooden_shield"));
		::Stash.add(this.new("scripts/items/shields/wooden_shield"));
		::Stash.add(this.new("scripts/items/shields/kite_shield"));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_aketon_cap]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.padded_nasal_helmet]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.flat_top_helmet]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_helm]]));
		::Stash.add(this.new("scripts/items/armor/gambeson"));
		::Stash.add(this.new("scripts/items/legend_armor/cloth/legend_armor_quilted_aketon"));
		::Stash.add(this.new("scripts/items/armor/padded_leather"));
		::Stash.add(this.new("scripts/items/armor/mail_shirt"));
		::Stash.add(this.new("scripts/items/armor/lamellar_harness"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
	}

});

