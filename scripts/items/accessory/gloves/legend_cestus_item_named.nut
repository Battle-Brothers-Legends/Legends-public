this.legend_cestus_item_named <- this.inherit("scripts/items/accessory/gloves/legend_named_glove", {
	m = {
		RegularDamage = 12,
		RegularDamageMax = 18,
		ChokeMin = 12,
		ChokeMax = 18,
		ArmorDamageMult = 0.3,
		DirectDamageMult = 0.2,
		InventorySound = "sounds/combat/armor_halfplate_impact_01.wav",
		StaminaModifier = -4
	},
	function create() {
		this.legend_named_glove.create();
		this.m.ID = "accessory.legend_cestus_item_named";
		this.m.Name = "Gladiator\'s Golden Cestus";
		this.m.Description = "A pair of gloves, made from gilded metal plates and quality leather, enclosing and protecting a fighter\'s lower arm and fist. Used to unleash devastating punches.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/cestus_golden.png";
		this.m.Value = 4300;
		this.randomizeValues();
		this.m.NameList = ["Gilder's Judgement", "Final Sermon", "Calamity's Grip", "Grand Arena Knuckles", "Titan's Fists", "Devil Grip", "Iron Breakers"];
		this.m.Name = this.m.NameList[this.Math.rand(0, this.m.NameList.len() - 1)];
	}
});