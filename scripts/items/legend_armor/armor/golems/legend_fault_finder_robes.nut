this.legend_fault_finder_robes <- this.inherit("scripts/items/legend_armor/legend_armor", {
	m = {},
	function create()
	{
		this.legend_armor.create();
		this.m.ID = "legend_armor.body.fault_finder_robes";
		this.m.Name = "Occult Robes";
		this.m.Description = "Thick, padded robes permeated with the faint, lingering smell of blood and decay.";
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variants = [115];
		this.m.Variant = 115;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 200;
		this.m.Condition = 75;
		this.m.ConditionMax = 75;
		this.m.StaminaModifier = -7;
		this.blockUpgrades();
		this.m.Blocked[this.Const.Items.ArmorUpgrades.Attachment] = false;
		this.m.Blocked[this.Const.Items.ArmorUpgrades.Rune] = false;
	}

});
