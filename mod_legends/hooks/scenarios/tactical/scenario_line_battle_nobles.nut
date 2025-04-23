::mods_hookExactClass("scenarios/tactical/scenario_line_battle_nobles", function(o)
{
	o.initMap = function ()
	{
		local testMap = this.MapGen.get("tactical.hill_camp");
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
	
	o.initEntities = function ()
	{
		local entity;
		local items;

		for( local x = 10; x < 20; x = ++x )
		{
			for( local y = 10; y < 20; y = ++y )
			{
				local tile = this.Tactical.getTile(x, y);
				tile.removeObject();
			}
		}

		entity = this.spawnEntity("scripts/entity/tactical/player", 7, 7, 15, 15);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
		items.equip(this.new("scripts/items/armor/padded_leather"));
		items.equip(this.new("scripts/items/weapons/billhook"));
		::Legends.Actives.grant(entity, ::Legends.Active.RallyTheTroops);
		entity = this.spawnEntity("scripts/entity/tactical/player", 7, 7, 13, 13);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/billhook"));
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		::Legends.Actives.grant(entity, ::Legends.Active.RallyTheTroops);
		entity = this.spawnEntity("scripts/entity/tactical/player", 6, 6, 14, 14);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/thick_tunic"));
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		::Legends.Actives.grant(entity, ::Legends.Active.RallyTheTroops);
		entity = this.spawnEntity("scripts/entity/tactical/player", 6, 6, 15, 15);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		items.equip(this.new("scripts/items/armor/gambeson"));
		items.equip(this.new("scripts/items/weapons/crossbow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		::Legends.Actives.grant(entity, ::Legends.Active.RallyTheTroops);
		entity = this.spawnEntity("scripts/entity/tactical/player", 8, 8, 11, 11);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Named.sallet_green_helmet]]));
		items.equip(this.new("scripts/items/armor/lamellar_harness"));
		items.equip(this.new("scripts/items/weapons/greatsword"));
		::Legends.Actives.grant(entity, ::Legends.Active.RallyTheTroops);
		entity = this.spawnEntity("scripts/entity/tactical/player", 8, 8, 13, 13);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/named/blue_studded_mail_armor"));
		items.equip(this.new("scripts/items/weapons/hand_axe"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		::Legends.Actives.grant(entity, ::Legends.Active.RallyTheTroops);
		entity = this.spawnEntity("scripts/entity/tactical/player", 8, 8, 14, 14);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Named.wolf_helmet]]));
		items.equip(this.new("scripts/items/armor/named/black_leather_armor"));
		items.equip(this.new("scripts/items/weapons/boar_spear"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		::Legends.Actives.grant(entity, ::Legends.Active.RallyTheTroops);
		entity = this.spawnEntity("scripts/entity/tactical/player", 8, 8, 16, 16);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Named.norse_helmet]]));
		items.equip(this.new("scripts/items/armor/padded_surcoat"));
		items.equip(this.new("scripts/items/weapons/winged_mace"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		::Legends.Actives.grant(entity, ::Legends.Active.RallyTheTroops);
		entity = this.spawnEntity("scripts/entity/tactical/player", 8, 8, 17, 17);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]));
		items.equip(this.new("scripts/items/armor/coat_of_plates"));
		items.equip(this.new("scripts/items/weapons/greatsword"));
		::Legends.Actives.grant(entity, ::Legends.Active.RallyTheTroops);
		entity = this.spawnEntity("scripts/entity/tactical/humans/standard_bearer", 12, 12, 16, 16);
		entity.setFaction(this.Const.Faction.Goblins);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/humans/noble_sergeant", 12, 12, 12, 12);
		entity.setFaction(this.Const.Faction.Goblins);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/humans/knight", 11, 11, 12, 12);
		entity.setFaction(this.Const.Faction.Goblins);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/humans/legend_noble_fencer", 13, 13, 15, 15);
		entity.setFaction(this.Const.Faction.Goblins);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/humans/noble_footman", 13, 13, 12, 12);
		entity.setFaction(this.Const.Faction.Goblins);
		entity.assignRandomEquipment();
		local x;
		x = 19;
		entity = this.spawnEntity("scripts/entity/tactical/humans/noble_footman", x, x, 11, 11);
		entity.setFaction(this.Const.Faction.Goblins);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/humans/noble_footman", x, x, 12, 12);
		entity.setFaction(this.Const.Faction.Goblins);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/humans/noble_footman_veteran", x, x, 13, 13);
		//entity.setFaction(this.Const.Faction.Goblins);
		//entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/humans/knight", x, x, 14, 14);
		entity.setFaction(this.Const.Faction.Goblins);
		entity.assignRandomEquipment();
		//entity = this.spawnEntity("scripts/entity/tactical/humans/noble_man_at_arms", x, x, 15, 15);
		//entity.setFaction(this.Const.Faction.Goblins);
		//entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/humans/noble_greatsword", x, x, 16, 16);
		entity.setFaction(this.Const.Faction.Goblins);
		entity.assignRandomEquipment();
		x = x + 1;
		entity = this.spawnEntity("scripts/entity/tactical/humans/noble_arbalester", x, x, 12, 12);
		entity.setFaction(this.Const.Faction.Goblins);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/humans/noble_billman", x, x, 16, 16);
		entity.setFaction(this.Const.Faction.Goblins);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/humans/noble_arbalester", x, x, 17, 17);
		entity.setFaction(this.Const.Faction.Goblins);
		entity.assignRandomEquipment();
		x = x + 1;
		entity = this.spawnEntity("scripts/entity/tactical/humans/standard_bearer", x, x, 16, 16);
		entity.setFaction(this.Const.Faction.Goblins);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/humans/noble_arbalester", x, x, 18, 18);
		entity.setFaction(this.Const.Faction.Goblins);
		entity.assignRandomEquipment();
	}

	o.initStash = function ()
	{
		this.Stash.clear();
		this.Stash.resize(117);
		this.Stash.setLocked(false);
		this.Stash.add(this.new("scripts/items/weapons/dagger"));
		this.Stash.add(this.new("scripts/items/weapons/scramasax"));
		this.Stash.add(this.new("scripts/items/weapons/javelin"));
		this.Stash.add(this.new("scripts/items/weapons/javelin"));
		this.Stash.add(this.new("scripts/items/weapons/throwing_axe"));
		this.Stash.add(this.new("scripts/items/weapons/throwing_axe"));
		this.Stash.add(this.new("scripts/items/weapons/hatchet"));
		this.Stash.add(this.new("scripts/items/weapons/hatchet"));
		this.Stash.add(this.new("scripts/items/weapons/hand_axe"));
		this.Stash.add(this.new("scripts/items/weapons/hand_axe"));
		this.Stash.add(this.new("scripts/items/weapons/warhammer"));
		this.Stash.add(this.new("scripts/items/weapons/warhammer"));
		this.Stash.add(this.new("scripts/items/weapons/shortsword"));
		this.Stash.add(this.new("scripts/items/weapons/shortsword"));
		this.Stash.add(this.new("scripts/items/weapons/falchion"));
		this.Stash.add(this.new("scripts/items/weapons/falchion"));
		this.Stash.add(this.new("scripts/items/weapons/arming_sword"));
		this.Stash.add(this.new("scripts/items/weapons/arming_sword"));
		this.Stash.add(this.new("scripts/items/weapons/military_cleaver"));
		this.Stash.add(this.new("scripts/items/weapons/military_cleaver"));
		this.Stash.add(this.new("scripts/items/weapons/greatsword"));
		this.Stash.add(this.new("scripts/items/weapons/greatsword"));
		this.Stash.add(this.new("scripts/items/weapons/greatsword"));
		this.Stash.add(this.new("scripts/items/weapons/greatsword"));
		this.Stash.add(this.new("scripts/items/weapons/greataxe"));
		this.Stash.add(this.new("scripts/items/weapons/greataxe"));
		this.Stash.add(this.new("scripts/items/weapons/greataxe"));
		this.Stash.add(this.new("scripts/items/weapons/billhook"));
		this.Stash.add(this.new("scripts/items/weapons/billhook"));
		this.Stash.add(this.new("scripts/items/weapons/billhook"));
		this.Stash.add(this.new("scripts/items/weapons/militia_spear"));
		this.Stash.add(this.new("scripts/items/weapons/militia_spear"));
		this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
		this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
		this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
		this.Stash.add(this.new("scripts/items/weapons/bludgeon"));
		this.Stash.add(this.new("scripts/items/weapons/bludgeon"));
		this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
		this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
		this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
		this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
		this.Stash.add(this.new("scripts/items/weapons/flail"));
		this.Stash.add(this.new("scripts/items/weapons/flail"));
		this.Stash.add(this.new("scripts/items/weapons/flail"));
		this.Stash.add(this.new("scripts/items/weapons/short_bow"));
		this.Stash.add(this.new("scripts/items/weapons/short_bow"));
		this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		this.Stash.add(this.new("scripts/items/weapons/crossbow"));
		this.Stash.add(this.new("scripts/items/weapons/crossbow"));
		this.Stash.add(this.new("scripts/items/weapons/crossbow"));
		this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
		this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
		this.Stash.add(this.new("scripts/items/shields/kite_shield"));
		this.Stash.add(this.new("scripts/items/shields/kite_shield"));
		this.Stash.add(this.new("scripts/items/shields/kite_shield"));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_aketon_cap]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.padded_nasal_helmet]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet_with_mail]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.closed_mail_coif]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.reinforced_mail_coif]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.padded_kettle_hat]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat_with_mail]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.flat_top_helmet]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.flat_top_with_mail]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_helm]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_helm]]));
		this.Stash.add(this.new("scripts/items/armor/padded_surcoat"));
		this.Stash.add(this.new("scripts/items/armor/gambeson"));
		this.Stash.add(this.new("scripts/items/armor/gambeson"));
		this.Stash.add(this.new("scripts/items/armor/padded_leather"));
		this.Stash.add(this.new("scripts/items/armor/padded_leather"));
		this.Stash.add(this.new("scripts/items/armor/mail_shirt"));
		this.Stash.add(this.new("scripts/items/armor/mail_shirt"));
		this.Stash.add(this.new("scripts/items/armor/mail_shirt"));
		this.Stash.add(this.new("scripts/items/armor/lamellar_harness"));
		this.Stash.add(this.new("scripts/items/armor/coat_of_plates"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
	}
});
