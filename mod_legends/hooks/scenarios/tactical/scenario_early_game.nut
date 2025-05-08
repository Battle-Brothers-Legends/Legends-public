::mods_hookExactClass("scenarios/tactical/scenario_early_game", function(o)
{
	o.initEntities = function ()
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
			entity = this.spawnEntity("scripts/entity/tactical/enemies/zombie");
			entity.setFaction(this.Const.Faction.Undead);
			entity.assignRandomEquipment();
		}

		for( local i = 0; i < 4; i = ++i )
		{
			entity = this.spawnEntity("scripts/entity/tactical/enemies/zombie_yeoman");
			entity.setFaction(this.Const.Faction.Undead);
			entity.assignRandomEquipment();
		}

		entity = this.spawnEntity("scripts/entity/tactical/enemies/necromancer", 15, 23, 15, 23);
		entity.setFaction(this.Const.Faction.Undead);
		entity.assignRandomEquipment();
	}

	o.initStash = function ()
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
