this.legend_pauldron_strong_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_pauldron_strong";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Reinforced Pauldrons";
		this.m.Description = "Strong segments of iron plate, excellent for protecting shoulders and neck. Worn over armor, they can help deflect incoming blows.";
		this.m.ArmorDescription = "Includes a set of strong pauldrons.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2500;
		this.m.Condition = 55;
		this.m.ConditionMax = 55;
		this.m.StaminaModifier = -6;
		this.m.DirectDamageModifier = -40.0;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_strong_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_strong_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_strong_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_strong_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_strong_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_strong_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_strong_"  + variant + ".png";
	}
});