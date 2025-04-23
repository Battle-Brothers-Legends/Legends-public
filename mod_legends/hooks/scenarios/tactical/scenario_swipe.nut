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
				this.Tactical.getTile(x, y - x / 2).removeObject();
			}
		}

		entity = this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet]]));
		items.equip(this.new("scripts/items/armor/mail_shirt"));
		items.equip(this.new("scripts/items/weapons/noble_sword"));
		items.equip(this.new("scripts/items/shields/heater_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]));
		items.equip(this.new("scripts/items/armor/mail_shirt"));
		items.equip(this.new("scripts/items/weapons/arming_sword"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_aketon_cap]]));
		items.equip(this.new("scripts/items/armor/gambeson"));
		items.equip(this.new("scripts/items/weapons/crossbow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		items.equip(this.new("scripts/items/armor/padded_surcoat"));
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/hatchet"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16);
		this.World.getPlayerRoster().add(entity);
		entity.setScenarioValues();
		entity.setName(this.getRandomPlayerName());
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/sackcloth"));
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/enemies/direwolf");
		entity.setFaction(this.Const.Faction.Beasts);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/direwolf");
		entity.setFaction(this.Const.Faction.Beasts);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/direwolf");
		entity.setFaction(this.Const.Faction.Beasts);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/direwolf");
		entity.setFaction(this.Const.Faction.Beasts);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/direwolf");
		entity.setFaction(this.Const.Faction.Beasts);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/direwolf");
		entity.setFaction(this.Const.Faction.Beasts);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/direwolf");
		entity.setFaction(this.Const.Faction.Beasts);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/direwolf");
		entity.setFaction(this.Const.Faction.Beasts);
		entity.assignRandomEquipment();
	}

	o.initStash = function ()
	{
		this.Stash.clear();
		this.Stash.resize(117);
		this.Stash.setLocked(false);
		this.Stash.add(this.new("scripts/items/weapons/knife"));
		this.Stash.add(this.new("scripts/items/weapons/dagger"));
		this.Stash.add(this.new("scripts/items/weapons/rondel_dagger"));
		this.Stash.add(this.new("scripts/items/weapons/hand_axe"));
		this.Stash.add(this.new("scripts/items/weapons/hand_axe"));
		this.Stash.add(this.new("scripts/items/weapons/military_cleaver"));
		this.Stash.add(this.new("scripts/items/weapons/greatsword"));
		this.Stash.add(this.new("scripts/items/weapons/pike"));
		this.Stash.add(this.new("scripts/items/weapons/billhook"));
		this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
		this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
		this.Stash.add(this.new("scripts/items/weapons/morning_star"));
		this.Stash.add(this.new("scripts/items/weapons/morning_star"));
		this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		this.Stash.add(this.new("scripts/items/weapons/crossbow"));
		this.Stash.add(this.new("scripts/items/weapons/crossbow"));
		this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
		this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
		this.Stash.add(this.new("scripts/items/armor/leather_tunic"));
		this.Stash.add(this.new("scripts/items/armor/padded_surcoat"));
		this.Stash.add(this.new("scripts/items/armor/padded_leather"));
		this.Stash.add(this.new("scripts/items/armor/mail_shirt"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
	}
});
