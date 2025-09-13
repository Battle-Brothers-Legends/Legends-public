::mods_hookExactClass("scenarios/tactical/legend_scenario_test_map", function(o)
{
	o.initEntities = function() {
		local entity;
		local items;

		entity = this.Tactical.spawnEntity("scripts/entity/tactical/player", 5, 5);
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName("Bro1");
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/mail_hauberk"));
		items.equip(this.new("scripts/items/weapons/arming_sword"));
		items.equip(this.new("scripts/items/shields/heater_shield"));
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet]]));

		entity = this.Tactical.spawnEntity("scripts/entity/tactical/player", 6, 5);
		this.World.getPlayerRoster().add(entity);
		entity.setFaction(this.Const.Faction.Player);
		entity.setName("Bro2");
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.equip(this.new("scripts/items/weapons/dagger"));

		entity = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_thug", 20, 10);
		entity.setFaction(this.Const.Faction.Bandits);
		entity.assignRandomEquipment();

		entity = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/orc_young", 22, 12);
		entity.setFaction(this.Const.Faction.Orcs);
		entity.assignRandomEquipment();

		entity = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/goblin", 18, 8);
		entity.setFaction(this.Const.Faction.Goblins);
		entity.assignRandomEquipment();
	}
});
