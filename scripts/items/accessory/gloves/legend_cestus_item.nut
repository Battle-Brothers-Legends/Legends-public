this.legend_cestus_item <- this.inherit("scripts/items/accessory/gloves/legend_glove_item", {
	m = {
		RegularDamage = 6,
		RegularDamageMax = 12,
		ChokeMin = 10,
		ChokeMax = 16,
		ArmorDamageMult = 0.1,
		DirectDamageMult = 0.1,
		InventorySound = "sounds/combat/armor_leather_impact_01.wav"
	},
	function create()
	{
		this.legend_glove_item.create();
		this.m.ID = "accessory.legend_cestus";
		this.m.Name = "Gladiator\'s Cestus";
		this.m.Description = "A pair of gloves, made from studded leather straps, enclosing and protecting a fighter\'s lower arm and fist. Used to deal more powerful punches.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/cestus.png";
		this.m.Value = 2300;
		this.m.StaminaModifier = -1;
	}
});
