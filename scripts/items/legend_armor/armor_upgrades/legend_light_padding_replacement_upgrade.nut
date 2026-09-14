this.legend_light_padding_replacement_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_light_padding_replacement";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Light Padding Replacement";
		this.m.Description = "A light yet durable replacement padding crafted from exotic materials.";
		this.m.ArmorDescription = "Includes a light yet durable padding replacement.";
		this.m.Variants = [1, 2, 3, 4, 5];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 2000;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = 0;
		this.m.FatiguePenaltyMultiplier = -30.0;
	}
		
	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_padding_light_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_padding_light_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_padding_light_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_padding_light_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_padding_light_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_padding_light_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_padding_light_"  + variant + ".png";
	}
});

