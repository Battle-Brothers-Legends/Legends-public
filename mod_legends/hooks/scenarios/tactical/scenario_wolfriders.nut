::mods_hookExactClass("scenarios/tactical/scenario_wolfriders", function(o)
{
	o.initEntities = function ()
	{
		local entity;
		local items;

		for( local x = 10; x <= 16; x = ++x )
		{
			for( local y = 11; y <= 17; y = ++y )
			{
				local tile = ::Tactical.getTileSquare(x, y);
				tile.removeObject();
				tile.Level = 0;
			}
		}

		entity = this.spawnEntity("scripts/entity/tactical/objective/donkey", 13, 13, 14, 14);
		entity.setFaction(::Const.Faction.PlayerAnimals);
		entity = this.spawnEntity("scripts/entity/tactical/player", 14, 14, 15, 15);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/padded_leather"));
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
		items.equip(this.new("scripts/items/armor/padded_leather"));
		items.equip(this.new("scripts/items/weapons/longaxe"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 12, 12);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/pike"));
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 12, 12, 14, 14);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mouth_piece]]));
		items.equip(this.new("scripts/items/armor/thick_tunic"));
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 15, 15);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		items.equip(this.new("scripts/items/armor/gambeson"));
		items.equip(this.new("scripts/items/weapons/crossbow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
		items.equip(this.new("scripts/items/armor/lamellar_harness"));
		items.equip(this.new("scripts/items/weapons/legend_zweihander"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 10, 10, 15, 15);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.dented_nasal_helmet]]));
		items.equip(this.new("scripts/items/armor/padded_leather"));
		items.equip(this.new("scripts/items/weapons/arming_sword"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 11, 11, 13, 13);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet_with_rusty_mail]]));
		items.equip(this.new("scripts/items/armor/mail_shirt"));
		items.equip(this.new("scripts/items/weapons/hand_axe"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 11, 11, 16, 16);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.closed_mail_coif]]));
		items.equip(this.new("scripts/items/armor/mail_shirt"));
		items.equip(this.new("scripts/items/weapons/boar_spear"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 15, 15, 16, 16);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.flat_top_with_mail]]));
		items.equip(this.new("scripts/items/armor/mail_shirt"));
		items.equip(this.new("scripts/items/weapons/warhammer"));
		items.equip(this.new("scripts/items/shields/named/named_full_metal_heater_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 16, 16, 15, 15);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.witchhunter_hat]]));
		items.equip(this.new("scripts/items/armor/ragged_surcoat"));
		items.equip(this.new("scripts/items/weapons/winged_mace"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 15, 15, 13, 13);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]));
		items.equip(this.new("scripts/items/armor/coat_of_plates"));
		items.equip(this.new("scripts/items/weapons/legend_zweihander"));

		for( local i = 0; i < 4; i = ++i )
		{
			entity = this.spawnEnemy("scripts/entity/tactical/enemies/legend_goblin_direwolf_rider");
			entity.setFaction(::Const.Faction.Goblins);
			entity.assignRandomEquipment();
		}
		for( local i = 0; i < 4; i = ++i )
		{
			entity = this.spawnEnemy("scripts/entity/tactical/enemies/goblin_wolfrider");
			entity.setFaction(::Const.Faction.Goblins);
			entity.assignRandomEquipment();
		}
		for( local i = 0; i < 4; i = ++i )
		{
			entity = this.spawnEnemy("scripts/entity/tactical/enemies/legend_goblin_white_direwolf_rider");
			entity.setFaction(::Const.Faction.Goblins);
			entity.assignRandomEquipment();
		}
	}

	o.initStash = function ()
	{
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
		::Stash.add(this.new("scripts/items/accessory/legend_wardog_item"));
		::Stash.add(this.new("scripts/items/accessory/legend_wardog_item"));
		::Stash.add(this.new("scripts/items/accessory/legend_wardog_item"));
		::Stash.add(this.new("scripts/items/accessory/legend_wardog_item"));
		::Stash.add(this.new("scripts/items/accessory/legend_wardog_item"));
		::Stash.add(this.new("scripts/items/accessory/legend_wardog_item"));
	}
});
