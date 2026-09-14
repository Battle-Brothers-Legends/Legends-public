this.legend_heraldic_plates_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_heraldic_plates";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Heraldic Shoulderplates";
		this.m.Description = "A set of large protective plates to be fixed at the shoulders of an armor, a neckguard and a belt.";
		this.m.ArmorDescription = "Includes a set of shoulderplates, a neckguard and a belt.";
		this.m.Variants = [1, 2];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 1800;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.m.StaminaModifier = -10;
		this.m.ResolveModifier = 10;
	}

	function updateVariant() {
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_heraldic_plates_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_heraldic_plates_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_heraldic_plates_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_heraldic_plates_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_heraldic_plates_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_heraldic_plates_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_heraldic_plates_"  + variant + ".png";
	}
});