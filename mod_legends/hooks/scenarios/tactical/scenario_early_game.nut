::mods_hookExactClass("scenarios/tactical/scenario_early_game", function(o)
{
	o.initEntities = function ()
	{
		local entity;
		local items;
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 3, 4, 7);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/bludgeon"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/billhook"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet]]));
		items.equip(this.new("scripts/items/legend_armor/cloth/legend_armor_quilted_aketon"));
		items.equip(this.new("scripts/items/weapons/boar_spear"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		items.equip(this.new("scripts/items/armor/padded_leather"));
		items.equip(this.new("scripts/items/weapons/shortsword"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		items.equip(this.new("scripts/items/legend_armor/cloth/legend_armor_quilted_aketon"));
		items.equip(this.new("scripts/items/weapons/boar_spear"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/scramasax"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/sackcloth"));
		items.equip(this.new("scripts/items/weapons/short_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.straw_hat]]));
		items.equip(this.new("scripts/items/armor/sackcloth"));
		items.equip(this.new("scripts/items/weapons/short_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));

		for( local i = 0; i < 10; i = ++i )
		{
			entity = this.spawnEntity("scripts/entity/tactical/enemies/zombie");
			entity.setFaction(::Const.Faction.Undead);
			entity.assignRandomEquipment();
		}

		for( local i = 0; i < 4; i = ++i )
		{
			entity = this.spawnEntity("scripts/entity/tactical/enemies/zombie_yeoman");
			entity.setFaction(::Const.Faction.Undead);
			entity.assignRandomEquipment();
		}

		entity = this.spawnEntity("scripts/entity/tactical/enemies/necromancer", 15, 23, 15, 23);
		entity.setFaction(::Const.Faction.Undead);
		entity.assignRandomEquipment();
	}

	o.initStash = function ()
	{
		::Stash.clear();
		::Stash.resize(63);
		::Stash.setLocked(false);
		::Stash.add(this.new("scripts/items/weapons/knife"));
		::Stash.add(this.new("scripts/items/weapons/dagger"));
		::Stash.add(this.new("scripts/items/weapons/scramasax"));
		::Stash.add(this.new("scripts/items/weapons/hatchet"));
		::Stash.add(this.new("scripts/items/weapons/hatchet"));
		::Stash.add(this.new("scripts/items/weapons/hatchet"));
		::Stash.add(this.new("scripts/items/weapons/billhook"));
		::Stash.add(this.new("scripts/items/weapons/militia_spear"));
		::Stash.add(this.new("scripts/items/weapons/boar_spear"));
		::Stash.add(this.new("scripts/items/weapons/wooden_stick"));
		::Stash.add(this.new("scripts/items/weapons/bludgeon"));
		::Stash.add(this.new("scripts/items/weapons/bludgeon"));
		::Stash.add(this.new("scripts/items/weapons/bludgeon"));
		::Stash.add(this.new("scripts/items/weapons/reinforced_wooden_flail"));
		::Stash.add(this.new("scripts/items/weapons/reinforced_wooden_flail"));
		::Stash.add(this.new("scripts/items/weapons/butchers_cleaver"));
		::Stash.add(this.new("scripts/items/weapons/butchers_cleaver"));
		::Stash.add(this.new("scripts/items/weapons/pitchfork"));
		::Stash.add(this.new("scripts/items/weapons/short_bow"));
		::Stash.add(this.new("scripts/items/weapons/short_bow"));
		::Stash.add(this.new("scripts/items/shields/wooden_shield"));
		::Stash.add(this.new("scripts/items/shields/buckler_shield"));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		::Stash.add(this.new("scripts/items/armor/sackcloth"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
	}
});
