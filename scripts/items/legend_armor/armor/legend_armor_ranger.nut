this.legend_armor_ranger <- this.inherit("scripts/items/legend_armor/legend_armor", {
	m = {},
	function create()
	{
		this.legend_armor.create();
		this.m.ID = "legend_armor.body.legend_ranger_armor";
		this.m.Name = "Ranger\'s Armor";
		this.m.Description = "A sturdy and heavy padded tunic made from rare materials that offers good protection while being light to wear.";
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variants = [512, 518];
		this.m.Variant = 512;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 500;
		this.m.Condition = 110;
		this.m.ConditionMax = 110;
		this.m.StaminaModifier = -6;
		this.blockUpgrades();
		this.m.Blocked[ this.Const.Items.ArmorUpgrades.Attachment] = false;
		this.m.Blocked[ this.Const.Items.ArmorUpgrades.Rune] = false;
	}

});
