::mods_hookExactClass("scenarios/tactical/scenario_combat_basics", function(o)
{
	o.initEntities = function ()
	{
		local entity;
		local items;
		::Tactical.getTileSquare(13, 15).removeObject();
		entity = ::Tactical.spawnEntity("scripts/entity/tactical/player", 13, 15 - 13 / 2);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/sackcloth"));
		items.equip(this.new("scripts/items/weapons/boar_spear"));
		::Tactical.getTileSquare(13, 16).removeObject();
		entity = ::Tactical.spawnEntity("scripts/entity/tactical/player", 13, 16 - 13 / 2);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet]]));
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/hand_axe"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		::Tactical.getTileSquare(13, 14).removeObject();
		entity = ::Tactical.spawnEntity("scripts/entity/tactical/player", 13, 14 - 13 / 2);
		::World.getPlayerRoster().add(entity);
		entity.setFaction(::Const.Faction.Player);
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		items.equip(this.new("scripts/items/legend_armor/cloth/legend_armor_quilted_aketon"));
		items.equip(this.new("scripts/items/weapons/noble_sword"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		::Tactical.getTileSquare(19, 16).removeObject();
		entity = ::Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_bandit_thug", 19, 16 - 19 / 2);
		entity.getAIAgent().getProperties().OverallDefensivenessMult = 0.25;
		entity.getAIAgent().getProperties().BehaviorMult[::Const.AI.Behavior.ID.Roam] = 0.0;
		entity.setFaction(::Const.Faction.Bandits);
		entity.getBaseProperties().Initiative = 60;
		entity.assignRandomEquipment();
		::Tactical.getTileSquare(19, 14).removeObject();
		entity = ::Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_bandit_thug", 19, 14 - 19 / 2);
		entity.getAIAgent().getProperties().OverallDefensivenessMult = 0.25;
		entity.getAIAgent().getProperties().BehaviorMult[::Const.AI.Behavior.ID.Roam] = 0.0;
		entity.setFaction(::Const.Faction.Bandits);
		entity.getBaseProperties().Initiative = 60;
		items = entity.getItems();
		items.equip(this.new("scripts/items/weapons/shortsword"));
		items.equip(this.new("scripts/items/shields/wooden_shield_old"));
	}
});
