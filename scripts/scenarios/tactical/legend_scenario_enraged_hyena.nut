this.legend_scenario_enraged_hyena <- this.inherit("scripts/scenarios/tactical/scenario_template", {
	m = {},

	function generate() {
		this.logDebug("ScenarioLineBattle::generate()");
		this.createStash();
		this.initMap();
		this.initEntities();
		this.initStash();
		::Tactical.Entities.makeEnemiesKnownToAI();
		this.m.Music = ::Const.Music.BeastsTracks;
		::Tactical.getCamera().Level = 1;
		::Tactical.CameraDirector.addMoveToTileEvent(0, ::Tactical.getTile(15, 14 - 15 / 2), 1, null, null, 0, 100);
	}

	function initMap() {
		local testMap = this.MapGen.get("tactical.steppe");
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

	function initEntities() {
		local entity;
		local items;

		for (local x = 10; x < 20; x++) {
			for (local y = 10; y < 20; y++) {
				local tile = ::Tactical.getTile(x, y);
				tile.removeObject();
			}
		}

		entity = this.spawnEntity("scripts/entity/tactical/player", 12, 12, 15, 15);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
		items.equip(this.new("scripts/items/armor/padded_leather"));
		items.equip(this.new("scripts/items/weapons/billhook"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/billhook"));
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/thick_tunic"));
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		items.equip(this.new("scripts/items/armor/gambeson"));
		items.equip(this.new("scripts/items/weapons/crossbow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 11, 11);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Named.sallet_green_helmet]]));
		items.equip(this.new("scripts/items/armor/lamellar_harness"));
		items.equip(this.new("scripts/items/weapons/legend_zweihander"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/named/blue_studded_mail_armor"));
		items.equip(this.new("scripts/items/weapons/hand_axe"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Named.wolf_helmet]]));
		items.equip(this.new("scripts/items/armor/named/black_leather_armor"));
		items.equip(this.new("scripts/items/weapons/boar_spear"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Named.norse_helmet]]));
		items.equip(this.new("scripts/items/legend_armor/cloth/legend_armor_quilted_aketon"));
		items.equip(this.new("scripts/items/weapons/winged_mace"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]));
		items.equip(this.new("scripts/items/armor/coat_of_plates"));
		items.equip(this.new("scripts/items/weapons/legend_zweihander"));

		local x = 19;
		for (local y = 12; y <= 23; y++) {
			entity = this.spawnEntity("scripts/entity/tactical/legend_enraged_hyena", x, x, y, y);
			entity.setFaction(::Const.Faction.Beasts);
		}

	}

	function spawnEntity(_script, _minX, _maxX, _minY, _maxY) {
		local x = 0;
		local y = 0;
		local n = 0;
		while (1) {
			x = ::Math.rand(_minX, _maxX);
			y = ::Math.rand(_minY, _maxY) - x / 2;

			if (::Tactical.getTile(x, y).IsOccupiedByActor) {
				continue;
			}

			if (!::Tactical.getTile(x, y).IsEmpty) {
				::Tactical.getTile(x, y).removeObject();
			}

			if (::Tactical.getTile(x, y).IsEmpty) {
				break;
			}
		}

		return ::Tactical.spawnEntity(_script, x, y);
	}

	function initStash() {
		::Stash.clear();
		::Stash.resize(117);
		::Stash.setLocked(false);
		::Stash.add(this.new("scripts/items/weapons/dagger"));
		::Stash.add(this.new("scripts/items/weapons/scramasax"));
		::Stash.add(this.new("scripts/items/weapons/javelin"));
		::Stash.add(this.new("scripts/items/weapons/javelin"));
		::Stash.add(this.new("scripts/items/weapons/throwing_axe"));
		::Stash.add(this.new("scripts/items/weapons/throwing_axe"));
		::Stash.add(this.new("scripts/items/weapons/hatchet"));
		::Stash.add(this.new("scripts/items/weapons/hatchet"));
		::Stash.add(this.new("scripts/items/weapons/hand_axe"));
		::Stash.add(this.new("scripts/items/weapons/hand_axe"));
		::Stash.add(this.new("scripts/items/weapons/warhammer"));
		::Stash.add(this.new("scripts/items/weapons/warhammer"));
		::Stash.add(this.new("scripts/items/weapons/shortsword"));
		::Stash.add(this.new("scripts/items/weapons/shortsword"));
		::Stash.add(this.new("scripts/items/weapons/falchion"));
		::Stash.add(this.new("scripts/items/weapons/falchion"));
		::Stash.add(this.new("scripts/items/weapons/arming_sword"));
		::Stash.add(this.new("scripts/items/weapons/arming_sword"));
		::Stash.add(this.new("scripts/items/weapons/military_cleaver"));
		::Stash.add(this.new("scripts/items/weapons/military_cleaver"));
		::Stash.add(this.new("scripts/items/weapons/legend_zweihander"));
		::Stash.add(this.new("scripts/items/weapons/legend_zweihander"));
		::Stash.add(this.new("scripts/items/weapons/legend_zweihander"));
		::Stash.add(this.new("scripts/items/weapons/legend_zweihander"));
		::Stash.add(this.new("scripts/items/weapons/greataxe"));
		::Stash.add(this.new("scripts/items/weapons/greataxe"));
		::Stash.add(this.new("scripts/items/weapons/greataxe"));
		::Stash.add(this.new("scripts/items/weapons/billhook"));
		::Stash.add(this.new("scripts/items/weapons/billhook"));
		::Stash.add(this.new("scripts/items/weapons/billhook"));
		::Stash.add(this.new("scripts/items/weapons/militia_spear"));
		::Stash.add(this.new("scripts/items/weapons/militia_spear"));
		::Stash.add(this.new("scripts/items/weapons/boar_spear"));
		::Stash.add(this.new("scripts/items/weapons/boar_spear"));
		::Stash.add(this.new("scripts/items/weapons/boar_spear"));
		::Stash.add(this.new("scripts/items/weapons/bludgeon"));
		::Stash.add(this.new("scripts/items/weapons/bludgeon"));
		::Stash.add(this.new("scripts/items/weapons/winged_mace"));
		::Stash.add(this.new("scripts/items/weapons/winged_mace"));
		::Stash.add(this.new("scripts/items/weapons/winged_mace"));
		::Stash.add(this.new("scripts/items/weapons/winged_mace"));
		::Stash.add(this.new("scripts/items/weapons/flail"));
		::Stash.add(this.new("scripts/items/weapons/flail"));
		::Stash.add(this.new("scripts/items/weapons/flail"));
		::Stash.add(this.new("scripts/items/weapons/short_bow"));
		::Stash.add(this.new("scripts/items/weapons/short_bow"));
		::Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		::Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		::Stash.add(this.new("scripts/items/weapons/crossbow"));
		::Stash.add(this.new("scripts/items/weapons/crossbow"));
		::Stash.add(this.new("scripts/items/weapons/crossbow"));
		::Stash.add(this.new("scripts/items/shields/wooden_shield"));
		::Stash.add(this.new("scripts/items/shields/wooden_shield"));
		::Stash.add(this.new("scripts/items/shields/kite_shield"));
		::Stash.add(this.new("scripts/items/shields/kite_shield"));
		::Stash.add(this.new("scripts/items/shields/kite_shield"));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_aketon_cap]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.padded_nasal_helmet]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet_with_mail]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.closed_mail_coif]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.reinforced_mail_coif]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.padded_kettle_hat]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat_with_mail]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.flat_top_helmet]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.flat_top_with_mail]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_helm]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_helm]]));
		::Stash.add(this.new("scripts/items/legend_armor/cloth/legend_armor_quilted_aketon"));
		::Stash.add(this.new("scripts/items/armor/gambeson"));
		::Stash.add(this.new("scripts/items/armor/gambeson"));
		::Stash.add(this.new("scripts/items/armor/padded_leather"));
		::Stash.add(this.new("scripts/items/armor/padded_leather"));
		::Stash.add(this.new("scripts/items/armor/mail_shirt"));
		::Stash.add(this.new("scripts/items/armor/mail_shirt"));
		::Stash.add(this.new("scripts/items/armor/mail_shirt"));
		::Stash.add(this.new("scripts/items/armor/lamellar_harness"));
		::Stash.add(this.new("scripts/items/armor/coat_of_plates"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
	}

});
