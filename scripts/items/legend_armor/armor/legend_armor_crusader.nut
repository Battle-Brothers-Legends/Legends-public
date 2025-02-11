this.legend_armor_crusader <- this.inherit("scripts/items/legend_armor/legend_armor", {
	m = {},
	function create()
	{
		this.legend_armor.create();
		this.m.ID = "legend_armor.body.legend_armor_crusader";
		this.m.Name = "Crusader Armor";
		this.m.Description = "A mail shirt with shoulder guards providing excellent protection against most weapons.";
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variants = [509, 519];
		this.m.Variant = 509;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 1000;
		this.m.Condition = 160;
		this.m.ConditionMax = 160;
		this.m.StaminaModifier = -10;
		this.blockUpgrades();
		this.m.Blocked[this.Const.Items.ArmorUpgrades.Attachment] = false;
		this.m.Blocked[this.Const.Items.ArmorUpgrades.Rune] = false;
	}

});
