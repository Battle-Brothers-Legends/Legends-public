this.legend_leather_neckguard_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_leather_neckguard";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Leather Neckguard";
		this.m.Description = "A neckguard of cured leather capable of softening a blow that could otherwise prove lethal.";
		this.m.ArmorDescription = "Includes a neckguard of cured leather.";
		this.m.Variants = [1,2,3,4,5];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 250;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = -2;
		this.m.DirectDamageModifier = -20.0;
	}
		
	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_leather_neck_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_leather_neck_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_leather_neck_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_leather_neck_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_leather_neck_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_leather_neck_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_leather_neck_"  + variant + ".png";
	}
});