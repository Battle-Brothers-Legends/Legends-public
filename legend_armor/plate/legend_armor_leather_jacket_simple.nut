
this.legend_armor_leather_jacket_simple <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "legend_armor.body.legend_armor_leather_jacket_simple";
		this.m.Name = "Simple Leather Jacket";
		this.m.Description = "A simple leather jacket for minimal protection.";
		this.m.ArmorDescription = "Includes a simple leather jacket for added protection.";
		this.m.Variants = [1, 2, 3, 4, 5, 6];
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 30;
		this.m.Condition = 15;
		this.m.ConditionMax = 15;
		this.m.StaminaModifier = -2;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "bust_legend_leather_jacket_simple" + "_" + variant;
		this.m.SpriteDamagedBack = "bust_legend_leather_jacket_simple" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "bust_legend_leather_jacket_simple" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/plate/legend_armor_leather_jacket_simple" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/plate/icon_legend_armor_leather_jacket_simple" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/plate/inventory_legend_armor_leather_jacket_simple" + "_" + variant + ".png";
	}
});
