::mods_hookExactClass("scenarios/tactical/scenario_swipe", function(o)
{
	o.initEntities = function ()
	{
		local entity;
		local items;

		for( local x = 2; x <= 6; x = ++x )
		{
			for( local y = 11; y <= 16; y = ++y )
			{
				::Tactical.getTile(x, y - x / 2).removeObject();
			}
		}

		entity = this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet]]));
		items.equip(this.new("scripts/items/armor/mail_shirt"));
		items.equip(this.new("scripts/items/weapons/noble_sword"));
		items.equip(this.new("scripts/items/shields/heater_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]));
		items.equip(this.new("scripts/items/armor/mail_shirt"));
		items.equip(this.new("scripts/items/weapons/arming_sword"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_aketon_cap]]));
		items.equip(this.new("scripts/items/armor/gambeson"));
		items.equip(this.new("scripts/items/weapons/crossbow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		items.equip(this.new("scripts/items/legend_armor/cloth/legend_armor_quilted_aketon"));
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/hatchet"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16);
		::World.getPlayerRoster().add(entity);
		entity.setScenarioValues();
		entity.setName(this.getRandomPlayerName());
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/sackcloth"));
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/enemies/direwolf");
		entity.setFaction(::Const.Faction.Beasts);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/direwolf");
		entity.setFaction(::Const.Faction.Beasts);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/direwolf");
		entity.setFaction(::Const.Faction.Beasts);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/direwolf");
		entity.setFaction(::Const.Faction.Beasts);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/direwolf");
		entity.setFaction(::Const.Faction.Beasts);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/direwolf");
		entity.setFaction(::Const.Faction.Beasts);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/direwolf");
		entity.setFaction(::Const.Faction.Beasts);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/direwolf");
		entity.setFaction(::Const.Faction.Beasts);
		entity.assignRandomEquipment();
	}

	o.initStash = function ()
	{
		::Stash.clear();
		::Stash.resize(117);
		::Stash.setLocked(false);
		::Stash.add(this.new("scripts/items/weapons/knife"));
		::Stash.add(this.new("scripts/items/weapons/dagger"));
		::Stash.add(this.new("scripts/items/weapons/rondel_dagger"));
		::Stash.add(this.new("scripts/items/weapons/hand_axe"));
		::Stash.add(this.new("scripts/items/weapons/hand_axe"));
		::Stash.add(this.new("scripts/items/weapons/military_cleaver"));
		::Stash.add(this.new("scripts/items/weapons/legend_zweihander"));
		::Stash.add(this.new("scripts/items/weapons/pike"));
		::Stash.add(this.new("scripts/items/weapons/billhook"));
		::Stash.add(this.new("scripts/items/weapons/boar_spear"));
		::Stash.add(this.new("scripts/items/weapons/boar_spear"));
		::Stash.add(this.new("scripts/items/weapons/morning_star"));
		::Stash.add(this.new("scripts/items/weapons/morning_star"));
		::Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		::Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		::Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		::Stash.add(this.new("scripts/items/weapons/crossbow"));
		::Stash.add(this.new("scripts/items/weapons/crossbow"));
		::Stash.add(this.new("scripts/items/shields/wooden_shield"));
		::Stash.add(this.new("scripts/items/shields/wooden_shield"));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
		::Stash.add(this.new("scripts/items/armor/leather_tunic"));
		::Stash.add(this.new("scripts/items/legend_armor/cloth/legend_armor_quilted_aketon"));
		::Stash.add(this.new("scripts/items/armor/padded_leather"));
		::Stash.add(this.new("scripts/items/armor/mail_shirt"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
	}
});
