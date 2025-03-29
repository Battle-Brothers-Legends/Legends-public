this.legend_armor_vala_dress <- this.inherit("scripts/items/legend_armor/legend_armor", {
	m = {},
	function create()
	{
		this.legend_armor.create();
		this.m.ID = "legend_armor.body.legend_vala_dress";
		this.m.Name = "Vala\'s Dress";
		this.m.Description = "A strong leather dress worn by a vala on her travels.";
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 507;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 80;
		this.m.Condition = 50;
		this.m.ConditionMax = 50;
		this.m.StaminaModifier = 0;
		// this.blockUpgrades();
		// this.m.Blocked[ this.Const.Items.ArmorUpgrades.Attachment] = false
		// this.m.Blocked[ this.Const.Items.ArmorUpgrades.Rune] = false
	}

});
