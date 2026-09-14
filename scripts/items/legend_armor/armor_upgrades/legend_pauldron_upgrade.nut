this.legend_pauldron_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_pauldron";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Iron Pauldrons";
		this.m.Description = "Heavy segments of iron plate excellent for protecting shoulders. Worn over armor, they can help deflect incoming blows.";
		this.m.ArmorDescription = "Includes a set of iron pauldrons.";
		this.m.Variants = [1,2,3,4,5,6];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2000;
		this.m.Condition = 50;
		this.m.ConditionMax = 50;
		this.m.StaminaModifier = -8;
		this.m.DirectDamageModifier = -40.0;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_"  + variant + ".png";
	}
});