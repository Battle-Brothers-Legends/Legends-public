this.legend_pauldron_swan_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_pauldron_swan";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Swan Pauldrons";
		this.m.Description = "Segments of worked iron curved like swans and excellent for protecting shoulders and arms. Worn over armor, they can help deflect incoming blows.";
		this.m.ArmorDescription = "Includes a set of swan-shaped pauldrons.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2700;
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
		this.m.StaminaModifier = -3;
		this.m.DirectDamageModifier = -30.0;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_swan_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_swan_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_swan_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_swan_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_swan_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_swan_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_swan_"  + variant + ".png";
	}
});