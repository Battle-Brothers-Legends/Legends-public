this.legend_armor_vala_cloak <- this.inherit("scripts/items/legend_armor/legend_armor", {
	m = {},
	function create()
	{
		this.legend_armor.create();
		this.m.ID = "legend_armor.body.legend_vala_cloak";
		this.m.Name = "Vala\'s Cloak";
		this.m.Description = "A rugged cloak for a vala\'s journeys through the lands.";
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variants = [506, 517];
		this.m.Variant = 506;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 120;
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
		this.m.StaminaModifier = 0;
		// this.blockUpgrades();
		// this.m.Blocked[ this.Const.Items.ArmorUpgrades.Attachment] = false
		// this.m.Blocked[ this.Const.Items.ArmorUpgrades.Rune] = false
	}

});
