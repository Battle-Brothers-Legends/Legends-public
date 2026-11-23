this.legend_metal_plating_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_metal_plating";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Metal Plates and Rivets";
		this.m.Description = "Thick metal plates riveted to the underlying armor. Crude, but simple way to add protection.";
		this.m.ArmorDescription = "Includes a set of riveted metal plates.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 800;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = 0;
		this.m.DamageReceivedArmorMult = -15.0;
		this.m.FatiguePenaltyMultiplier = 25.0;
	}
		
	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_metal_plates_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_metal_plates_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_metal_plates_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_metal_plates_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_metal_plates_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_metal_plates_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_metal_plates_"  + variant + ".png";
	}
});