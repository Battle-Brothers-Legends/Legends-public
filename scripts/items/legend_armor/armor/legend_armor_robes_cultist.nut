this.legend_armor_robes_cultist <- this.inherit("scripts/items/legend_armor/legend_armor", {
	m = {},
	function create()
	{
		this.legend_armor.create();
		this.m.ID = "legend_armor.body.cultist_leather_robe";
		this.m.Name = "Cultist Leather Robe";
		this.m.Description = "A thick leather armor covered with additional leather patches and occult insignia.";
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 106;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 240;
		this.m.Condition = 88;
		this.m.ConditionMax = 88;
		this.m.StaminaModifier = -9;
		this.blockUpgrades();
		this.m.Blocked[ this.Const.Items.ArmorUpgrades.Attachment] = false;
		this.m.Blocked[ this.Const.Items.ArmorUpgrades.Rune] = false;
		this.addItemType(this.Const.Items.ItemType.Cultist);
	}

});

