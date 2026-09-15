// this.legend_scenario_line_battle_kobolds <- this.inherit("scripts/scenarios/tactical/scenario_template", {
// 	m = {},
// 	function generate()
// 	{
// 		this.logDebug("ScenarioLineBattle::generate()");
// 		this.createStash();
// 		this.initMap();
// 		this.initEntities();
// 		this.initStash();
// 		this.m.Music = ::Const.Music.GoblinsTracks;
// 		::Tactical.Entities.makeEnemiesKnownToAI();
// 		::Tactical.getCamera().Level = 1;
// 		::Tactical.CameraDirector.addMoveToTileEvent(0, ::Tactical.getTile(15, 14 - 15 / 2), 1, null, null, 0, 100);
// 	}

// 	function initMap()
// 	{
// 		local testMap = this.MapGen.get("tactical.swamp_green");
// 		local minX = testMap.getMinX();
// 		local minY = testMap.getMinY();
// 		::Tactical.resizeScene(minX, minY);
// 		testMap.fill({
// 			X = 0,
// 			Y = 0,
// 			W = minX,
// 			H = minY
// 		}, null);
// 	}

// 	function initEntities()
// 	{
// 		local entity;
// 		local items;
// 		entity = this.spawnEntity("scripts/entity/tactical/player", 12, 12, 15, 15);
// 		::World.getPlayerRoster().add(entity);
// 		entity.setName(this.getRandomPlayerName());
// 		entity.setScenarioValues();
// 		items = entity.getItems();
// 		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
// 		items.equip(this.new("scripts/items/armor/padded_leather"));
// 		items.equip(this.new("scripts/items/weapons/pike"));
// 		items.equip(this.new("scripts/items/accessory/legend_wardog_item"));
// 		entity = this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13);
// 		::World.getPlayerRoster().add(entity);
// 		entity.setName(this.getRandomPlayerName());
// 		entity.setScenarioValues();
// 		items = entity.getItems();
// 		items.equip(this.new("scripts/items/armor/leather_tunic"));
// 		items.equip(this.new("scripts/items/weapons/pike"));
// 		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
// 		items.addToBag(this.new("scripts/items/weapons/dagger"));
// 		items.equip(this.new("scripts/items/accessory/legend_armored_wardog_item"));
// 		entity = this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14);
// 		::World.getPlayerRoster().add(entity);
// 		entity.setName(this.getRandomPlayerName());
// 		entity.setScenarioValues();
// 		items = entity.getItems();
// 		items.equip(this.new("scripts/items/armor/thick_tunic"));
// 		items.equip(this.new("scripts/items/weapons/hunting_bow"));
// 		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
// 		items.addToBag(this.new("scripts/items/weapons/dagger"));
// 		items.equip(this.new("scripts/items/accessory/legend_armored_wardog_item"));
// 		entity = this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15);
// 		::World.getPlayerRoster().add(entity);
// 		entity.setName(this.getRandomPlayerName());
// 		entity.setScenarioValues();
// 		items = entity.getItems();
// 		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
// 		items.equip(this.new("scripts/items/armor/gambeson"));
// 		items.equip(this.new("scripts/items/weapons/crossbow"));
// 		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
// 		items.addToBag(this.new("scripts/items/weapons/dagger"));
// 		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 11, 11);
// 		::World.getPlayerRoster().add(entity);
// 		entity.setName(this.getRandomPlayerName());
// 		entity.setScenarioValues();
// 		items = entity.getItems();
// 		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
// 		items.equip(this.new("scripts/items/armor/lamellar_harness"));
// 		items.equip(this.new("scripts/items/weapons/warbrand"));
// 		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 12, 12);
// 		::World.getPlayerRoster().add(entity);
// 		entity.setName(this.getRandomPlayerName());
// 		entity.setScenarioValues();
// 		items = entity.getItems();
// 		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet]]));
// 		items.equip(this.new("scripts/items/armor/padded_leather"));
// 		items.equip(this.new("scripts/items/weapons/noble_sword"));
// 		items.equip(this.new("scripts/items/shields/heater_shield"));
// 		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13);
// 		::World.getPlayerRoster().add(entity);
// 		entity.setName(this.getRandomPlayerName());
// 		entity.setScenarioValues();
// 		items = entity.getItems();
// 		items.equip(this.new("scripts/items/armor/mail_shirt"));
// 		items.equip(this.new("scripts/items/weapons/hand_axe"));
// 		items.equip(this.new("scripts/items/shields/kite_shield"));
// 		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14);
// 		::World.getPlayerRoster().add(entity);
// 		entity.setName(this.getRandomPlayerName());
// 		entity.setScenarioValues();
// 		items = entity.getItems();
// 		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
// 		items.equip(this.new("scripts/items/armor/mail_shirt"));
// 		items.equip(this.new("scripts/items/weapons/boar_spear"));
// 		items.equip(this.new("scripts/items/shields/wooden_shield"));
// 		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 15, 15);
// 		::World.getPlayerRoster().add(entity);
// 		entity.setName(this.getRandomPlayerName());
// 		entity.setScenarioValues();
// 		items = entity.getItems();
// 		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet]]));
// 		items.equip(this.new("scripts/items/armor/mail_shirt"));
// 		items.equip(this.new("scripts/items/weapons/warhammer"));
// 		items.equip(this.new("scripts/items/shields/kite_shield"));
// 		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16);
// 		::World.getPlayerRoster().add(entity);
// 		entity.setName(this.getRandomPlayerName());
// 		entity.setScenarioValues();
// 		items = entity.getItems();
// 		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
// 		items.equip(this.new("scripts/items/legend_armor/cloth/legend_armor_quilted_aketon"));
// 		items.equip(this.new("scripts/items/weapons/winged_mace"));
// 		items.equip(this.new("scripts/items/shields/wooden_shield"));
// 		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17);
// 		::World.getPlayerRoster().add(entity);
// 		entity.setName(this.getRandomPlayerName());
// 		entity.setScenarioValues();
// 		items = entity.getItems();
// 		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]));
// 		items.equip(this.new("scripts/items/armor/coat_of_plates"));
// 		items.equip(this.new("scripts/items/weapons/legend_zweihander"));
// 		entity = this.spawnEntity("scripts/entity/tactical/enemies/serpent", 5, 5, 10, 10);
// 		entity.setFaction(::Const.Faction.Goblins);
// 		entity.assignRandomEquipment();
// 		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_kobold_fighter", 19, 19, 11, 11);
// 		entity.setFaction(::Const.Faction.Goblins);
// 		entity.assignRandomEquipment();
// 		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_kobold_fighter", 19, 19, 12, 12);
// 		entity.setFaction(::Const.Faction.Goblins);
// 		entity.assignRandomEquipment();
// 		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_kobold_fighter", 19, 19, 13, 13);
// 		entity.setFaction(::Const.Faction.Goblins);
// 		entity.assignRandomEquipment();
// 		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_kobold_fighter", 19, 19, 14, 14);
// 		entity.setFaction(::Const.Faction.Goblins);
// 		entity.assignRandomEquipment();
// 		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_kobold_fighter", 19, 19, 15, 15);
// 		entity.setFaction(::Const.Faction.Goblins);
// 		entity.assignRandomEquipment();
// 		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_kobold_fighter", 19, 19, 16, 16);
// 		entity.setFaction(::Const.Faction.Goblins);
// 		entity.assignRandomEquipment();
// 		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_kobold_fighter", 19, 19, 17, 17);
// 		entity.setFaction(::Const.Faction.Goblins);
// 		entity.assignRandomEquipment();
// 		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_kobold_fighter", 20, 20, 11, 11);
// 		entity.setFaction(::Const.Faction.Goblins);
// 		entity.assignRandomEquipment();
// 		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_kobold_fighter", 20, 20, 12, 12);
// 		entity.setFaction(::Const.Faction.Goblins);
// 		entity.assignRandomEquipment();
// 		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_kobold_fighter", 20, 20, 13, 13);
// 		entity.setFaction(::Const.Faction.Goblins);
// 		entity.assignRandomEquipment();
// 		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_kobold_fighter", 20, 20, 14, 14);
// 		entity.setFaction(::Const.Faction.Goblins);
// 		entity.assignRandomEquipment();
// 		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_kobold_fighter", 20, 20, 15, 15);
// 		entity.setFaction(::Const.Faction.Goblins);
// 		entity.assignRandomEquipment();
// 		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_kobold_fighter", 20, 20, 16, 16);
// 		entity.setFaction(::Const.Faction.Goblins);
// 		entity.assignRandomEquipment();
// 		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_kobold_fighter", 20, 20, 17, 17);
// 		entity.setFaction(::Const.Faction.Goblins);
// 		entity.assignRandomEquipment();
// 		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_kobold_fighter", 20, 20, 18, 18);
// 		entity.setFaction(::Const.Faction.Goblins);
// 		entity = this.spawnEntity("scripts/entity/tactical/enemies/serpent", 5, 5, 19, 19);
// 		entity.setFaction(::Const.Faction.Goblins);
// 	}

// 	function spawnEntity( _script, _minX = 10, _maxX = 28, _minY = 3, _maxY = 28 )
// 	{
// 		local x = 0;
// 		local y = 0;
// 		local n = 0;

// 		while (1)
// 		{
// 			x = ::Math.rand(_minX, _maxX);
// 			y = ::Math.rand(_minY, _maxY) - x / 2;

// 			if (::Tactical.getTile(x, y).IsOccupiedByActor)
// 			{
// 				continue;
// 			}

// 			::Tactical.getTile(x, y).removeObject();

// 			if (::Tactical.getTile(x, y).IsEmpty)
// 			{
// 				break;
// 			}
// 		}

// 		return ::Tactical.spawnEntity(_script, x, y);
// 	}

// 	function initStash()
// 	{
// 		::Stash.clear();
// 		::Stash.resize(117);
// 		::Stash.setLocked(false);
// 		::Stash.add(this.new("scripts/items/weapons/dagger"));
// 		::Stash.add(this.new("scripts/items/weapons/scramasax"));
// 		::Stash.add(this.new("scripts/items/weapons/javelin"));
// 		::Stash.add(this.new("scripts/items/weapons/javelin"));
// 		::Stash.add(this.new("scripts/items/weapons/throwing_axe"));
// 		::Stash.add(this.new("scripts/items/weapons/throwing_axe"));
// 		::Stash.add(this.new("scripts/items/weapons/hatchet"));
// 		::Stash.add(this.new("scripts/items/weapons/hatchet"));
// 		::Stash.add(this.new("scripts/items/weapons/hand_axe"));
// 		::Stash.add(this.new("scripts/items/weapons/hand_axe"));
// 		::Stash.add(this.new("scripts/items/weapons/warhammer"));
// 		::Stash.add(this.new("scripts/items/weapons/warhammer"));
// 		::Stash.add(this.new("scripts/items/weapons/shortsword"));
// 		::Stash.add(this.new("scripts/items/weapons/shortsword"));
// 		::Stash.add(this.new("scripts/items/weapons/falchion"));
// 		::Stash.add(this.new("scripts/items/weapons/falchion"));
// 		::Stash.add(this.new("scripts/items/weapons/arming_sword"));
// 		::Stash.add(this.new("scripts/items/weapons/arming_sword"));
// 		::Stash.add(this.new("scripts/items/weapons/military_cleaver"));
// 		::Stash.add(this.new("scripts/items/weapons/military_cleaver"));
// 		::Stash.add(this.new("scripts/items/weapons/legend_zweihander"));
// 		::Stash.add(this.new("scripts/items/weapons/legend_zweihander"));
// 		::Stash.add(this.new("scripts/items/weapons/legend_zweihander"));
// 		::Stash.add(this.new("scripts/items/weapons/legend_zweihander"));
// 		::Stash.add(this.new("scripts/items/weapons/greataxe"));
// 		::Stash.add(this.new("scripts/items/weapons/greataxe"));
// 		::Stash.add(this.new("scripts/items/weapons/greataxe"));
// 		::Stash.add(this.new("scripts/items/weapons/billhook"));
// 		::Stash.add(this.new("scripts/items/weapons/billhook"));
// 		::Stash.add(this.new("scripts/items/weapons/billhook"));
// 		::Stash.add(this.new("scripts/items/weapons/militia_spear"));
// 		::Stash.add(this.new("scripts/items/weapons/militia_spear"));
// 		::Stash.add(this.new("scripts/items/weapons/boar_spear"));
// 		::Stash.add(this.new("scripts/items/weapons/boar_spear"));
// 		::Stash.add(this.new("scripts/items/weapons/boar_spear"));
// 		::Stash.add(this.new("scripts/items/weapons/bludgeon"));
// 		::Stash.add(this.new("scripts/items/weapons/bludgeon"));
// 		::Stash.add(this.new("scripts/items/weapons/winged_mace"));
// 		::Stash.add(this.new("scripts/items/weapons/winged_mace"));
// 		::Stash.add(this.new("scripts/items/weapons/winged_mace"));
// 		::Stash.add(this.new("scripts/items/weapons/winged_mace"));
// 		::Stash.add(this.new("scripts/items/weapons/flail"));
// 		::Stash.add(this.new("scripts/items/weapons/flail"));
// 		::Stash.add(this.new("scripts/items/weapons/flail"));
// 		::Stash.add(this.new("scripts/items/weapons/short_bow"));
// 		::Stash.add(this.new("scripts/items/weapons/short_bow"));
// 		::Stash.add(this.new("scripts/items/weapons/hunting_bow"));
// 		::Stash.add(this.new("scripts/items/weapons/hunting_bow"));
// 		::Stash.add(this.new("scripts/items/weapons/crossbow"));
// 		::Stash.add(this.new("scripts/items/weapons/crossbow"));
// 		::Stash.add(this.new("scripts/items/weapons/crossbow"));
// 		::Stash.add(this.new("scripts/items/shields/wooden_shield"));
// 		::Stash.add(this.new("scripts/items/shields/wooden_shield"));
// 		::Stash.add(this.new("scripts/items/shields/kite_shield"));
// 		::Stash.add(this.new("scripts/items/shields/kite_shield"));
// 		::Stash.add(this.new("scripts/items/shields/kite_shield"));
// 		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
// 		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
// 		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_aketon_cap]]));
// 		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet]]));
// 		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.padded_nasal_helmet]]));
// 		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet_with_mail]]));
// 		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]));
// 		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.closed_mail_coif]]));
// 		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.reinforced_mail_coif]]));
// 		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
// 		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.padded_kettle_hat]]));
// 		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat_with_mail]]));
// 		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.flat_top_helmet]]));
// 		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.flat_top_with_mail]]));
// 		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_helm]]));
// 		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_helm]]));
// 		::Stash.add(this.new("scripts/items/legend_armor/cloth/legend_armor_quilted_aketon"));
// 		::Stash.add(this.new("scripts/items/armor/gambeson"));
// 		::Stash.add(this.new("scripts/items/armor/gambeson"));
// 		::Stash.add(this.new("scripts/items/armor/padded_leather"));
// 		::Stash.add(this.new("scripts/items/armor/padded_leather"));
// 		::Stash.add(this.new("scripts/items/armor/mail_shirt"));
// 		::Stash.add(this.new("scripts/items/armor/mail_shirt"));
// 		::Stash.add(this.new("scripts/items/armor/mail_shirt"));
// 		::Stash.add(this.new("scripts/items/armor/lamellar_harness"));
// 		::Stash.add(this.new("scripts/items/armor/coat_of_plates"));
// 		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
// 		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
// 		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
// 		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
// 		::Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
// 		::Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
// 		::Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
// 		::Stash.add(this.new("scripts/items/accessory/legend_wardog_item"));
// 		::Stash.add(this.new("scripts/items/accessory/legend_wardog_item"));
// 		::Stash.add(this.new("scripts/items/accessory/legend_wardog_item"));
// 		::Stash.add(this.new("scripts/items/accessory/legend_wardog_item"));
// 		::Stash.add(this.new("scripts/items/accessory/legend_wardog_item"));
// 		::Stash.add(this.new("scripts/items/accessory/legend_wardog_item"));
// 	}

// });

