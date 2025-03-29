this.legend_heraldic_plates_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_heraldic_plates";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Heraldic Shoulderplates";
		this.m.Description = "Large protective plates to be fixed at the shoulders of an armor.";
		this.m.ArmorDescription = "Large protective plates have been fixed at the shoulders of this armor.";
		this.m.Variants = [1, 2];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.m.Value = 1800;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.m.StaminaModifier = -10;
		this.m.ResolveModifier = 10;
		this.updateVariant();
	}

	function updateVariant() {
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Icon = "armor_upgrades/icon_heraldic_plates_" + variant + ".png";
		this.m.IconLarge = "legend_armor/upgrades/inventory_heraldic_plates_" + variant + ".png";
		this.m.OverlayIcon = "armor_upgrades/icon_heraldic_plates_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/upgrades/inventory_heraldic_plates_" + variant + ".png";
		this.m.SpriteBack = "upgrade_heraldic_plates_" + variant;
		this.m.SpriteDamagedBack = "upgrade_heraldic_plates_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "upgrade_heraldic_plates_" + variant + "_dead";
	}
});

