::mods_hookExactClass("scenarios/tactical/scenario_combat_basics_orcs", function(o)
{
	o.initEntities = function ()
	{
		local entity;
		local items;
		this.Tactical.getTileSquare(13, 15).removeObject();
		entity = this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, 15 - 13 / 2);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/sackcloth"));
		items.equip(this.new("scripts/items/weapons/boar_spear"));
		this.Tactical.getTileSquare(13, 16).removeObject();
		entity = this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, 16 - 13 / 2);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet]]));
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/hand_axe"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		this.Tactical.getTileSquare(13, 14).removeObject();
		entity = this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, 14 - 13 / 2);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		items.equip(this.new("scripts/items/armor/padded_surcoat"));
		items.equip(this.new("scripts/items/weapons/noble_sword"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/orc_berserker", 19, 15 - 19 / 2);
		items = entity.getItems();
		items.equip(this.new("scripts/items/weapons/greenskins/orc_flail_2h"));
	}
});
