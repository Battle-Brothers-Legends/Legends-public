this.legend_armor_warlock_cloak <- this.inherit("scripts/items/legend_armor/legend_armor", {
	m = {},
	function create()
	{
		this.legend_armor.create();
		this.m.ID = "legend_armor.body.legend_armor_warlock_cloak";
		this.m.Name = "Warlock Cloak";
		this.m.Description = "A cloak made from clothes of powerful men long dead";
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 508;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 200;
		this.m.Condition = 100;
		this.m.ConditionMax = 100;
		this.m.StaminaModifier = 4;
		// this.blockUpgrades();
		// this.m.Blocked[ this.Const.Items.ArmorUpgrades.Attachment] = false
		// this.m.Blocked[ this.Const.Items.ArmorUpgrades.Rune] = false
	}

});
