this.legend_grand_diviner_robes <- this.inherit("scripts/items/legend_armor/legend_armor", {
	m = {},
	function create()
	{
		this.legend_armor.create();
		this.m.ID = "legend_armor.body.grand_diviner_robes";
		this.m.Name = "Robes of Divination";
		this.m.Description = "The robes worn by the Grand Diviner. The sturdy layers of leather and heavy linen offer excellent protection.";
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variants = [114];
		this.m.Variant = 114;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 1200;
		this.m.Condition = 125;
		this.m.ConditionMax = 125;
		this.m.StaminaModifier = -9;
		this.blockUpgrades();
		this.m.Blocked[this.Const.Items.ArmorUpgrades.Attachment] = false;
		this.m.Blocked[this.Const.Items.ArmorUpgrades.Rune] = false;
	}

});
