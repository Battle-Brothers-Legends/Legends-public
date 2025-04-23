this.legend_scenario_basilisks <- this.inherit("scripts/scenarios/tactical/scenario_template", {
	m = {},
	function generate()
	{
		this.logDebug("ScenarioDefendTheHill::generate()");
		this.createStash();
		this.initMap();
		this.initEntities();
		this.initStash();
		this.m.Music = this.Const.Music.BeastsTracks;
		local entity;

		for( local i = 0; i < 8; i = ++i )
		{
			entity = this.spawnEntity("scripts/entity/tactical/humans/militia");
			entity.assignRandomEquipment();
			entity.killSilently();
		}

		this.Tactical.Entities.makeEnemiesKnownToAI();
		local clouds = this.Tactical.getWeather().createCloudSettings();
		clouds.Type = this.getconsttable().CloudType.StaticFog;
		clouds.MinClouds = 12;
		clouds.MaxClouds = 18;
		clouds.MinAlpha = 0.25;
		clouds.MaxAlpha = 0.5;
		clouds.MinScale = 2.0;
		clouds.MaxScale = 3.0;
		this.Tactical.getWeather().buildCloudCover(clouds);
		local rain = this.Tactical.getWeather().createRainSettings();
		rain.MinDrops = 150;
		rain.MaxDrops = 150;
		rain.NumSplats = 50;
		rain.MinVelocity = 400.0;
		rain.MaxVelocity = 500.0;
		rain.MinAlpha = 1.0;
		rain.MaxAlpha = 1.0;
		rain.MinScale = 0.75;
		rain.MaxScale = 1.0;
		this.Tactical.getWeather().buildRain(rain);
		this.Tactical.getWeather().setAmbientLightingPreset(5);
		this.Tactical.getWeather().setAmbientLightingSaturation(0.9);
		this.Sound.setAmbience(0, this.Const.SoundAmbience.Rain, this.Const.Sound.Volume.Ambience, 0);
	}

	function initMap()
	{
		local testMap = this.MapGen.get("tactical.defend_the_hill");
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
		entity = this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16);
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_helm]]));
		items.equip(this.new("scripts/items/armor/coat_of_plates"));
		items.equip(this.new("scripts/items/weapons/greatsword"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16);
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Named.norse_helmet]]));
		items.equip(this.new("scripts/items/armor/mail_shirt"));
		items.equip(this.new("scripts/items/weapons/hand_axe"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16);
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
		items.equip(this.new("scripts/items/armor/mail_shirt"));
		items.equip(this.new("scripts/items/weapons/hand_axe"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16);
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]));
		items.equip(this.new("scripts/items/armor/mail_shirt"));
		items.equip(this.new("scripts/items/weapons/winged_mace"));
		items.equip(this.new("scripts/items/shields/named/named_red_white_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16);
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/boar_spear"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16);
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		items.equip(this.new("scripts/items/armor/gambeson"));
		items.equip(this.new("scripts/items/weapons/crossbow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16);
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		items.equip(this.new("scripts/items/armor/padded_surcoat"));
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/hatchet"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16);
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/padded_leather"));
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_basilisk_drone", 12, 18, 7, 10);
		entity.setFaction(this.Const.Faction.Beasts);
		entity.assignRandomEquipment();

		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_basilisk_drone", 12, 18, 7, 10);
		entity.setFaction(this.Const.Faction.Beasts);
		entity.assignRandomEquipment();

		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_basilisk_drone", 12, 18, 7, 10);
		entity.setFaction(this.Const.Faction.Beasts);
		entity.assignRandomEquipment();

		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_basilisk_drone", 12, 18, 7, 10);
		entity.setFaction(this.Const.Faction.Beasts);
		entity.assignRandomEquipment();
	}

	function spawnEntity( _script, _minX = 8, _maxX = 26, _minY = 8, _maxY = 26 )
	{
		local x = 0;
		local y = 0;

		while (1)
		{
			x = this.Math.rand(_minX, _maxX);
			y = this.Math.rand(_minY, _maxY) - x / 2;

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
		this.Stash.resize(117);
		this.Stash.setLocked(false);
		this.Stash.add(this.new("scripts/items/weapons/dagger"));
		this.Stash.add(this.new("scripts/items/weapons/hand_axe"));
		this.Stash.add(this.new("scripts/items/weapons/warhammer"));
		this.Stash.add(this.new("scripts/items/weapons/warhammer"));
		this.Stash.add(this.new("scripts/items/weapons/falchion"));
		this.Stash.add(this.new("scripts/items/weapons/arming_sword"));
		this.Stash.add(this.new("scripts/items/weapons/noble_sword"));
		this.Stash.add(this.new("scripts/items/weapons/military_cleaver"));
		this.Stash.add(this.new("scripts/items/weapons/military_cleaver"));
		this.Stash.add(this.new("scripts/items/weapons/greatsword"));
		this.Stash.add(this.new("scripts/items/weapons/greatsword"));
		this.Stash.add(this.new("scripts/items/weapons/billhook"));
		this.Stash.add(this.new("scripts/items/weapons/billhook"));
		this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
		this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
		this.Stash.add(this.new("scripts/items/weapons/flail"));
		this.Stash.add(this.new("scripts/items/weapons/flail"));
		this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
		this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
		this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		this.Stash.add(this.new("scripts/items/weapons/crossbow"));
		this.Stash.add(this.new("scripts/items/weapons/crossbow"));
		this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
		this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
		this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
		this.Stash.add(this.new("scripts/items/shields/kite_shield"));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_aketon_cap]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.padded_nasal_helmet]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.flat_top_helmet]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_helm]]));
		this.Stash.add(this.new("scripts/items/armor/gambeson"));
		this.Stash.add(this.new("scripts/items/armor/padded_surcoat"));
		this.Stash.add(this.new("scripts/items/armor/padded_leather"));
		this.Stash.add(this.new("scripts/items/armor/mail_shirt"));
		this.Stash.add(this.new("scripts/items/armor/lamellar_harness"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
	}

});

