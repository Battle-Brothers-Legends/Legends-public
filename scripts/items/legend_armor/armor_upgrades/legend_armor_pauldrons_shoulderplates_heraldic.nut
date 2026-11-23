this.legend_armor_pauldrons_shoulderplates_heraldic <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_armor_pauldrons_shoulderplates_heraldic";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Heraldic Shoulderplates";
		this.m.Description = "A set of painted heavy plates that provides a layer of protection and a sense of belonging.";
		this.m.ArmorDescription = "Includes a set of painted metal shoulderplates.";
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Variants = [1,2,3,4,5];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Value = 500;
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
		this.m.StaminaModifier = -4;
		this.m.ResolveModifier = 5;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_shoulderplates_heraldic_" + variant + "_back";
		this.m.SpriteDamagedBack = "pauldrons_shoulderplates_heraldic_" + variant + "_back_damaged";
		this.m.SpriteCorpseBack = "pauldrons_shoulderplates_heraldic_" + variant + "_back_dead";
		this.m.SpriteFront = "pauldrons_shoulderplates_heraldic_" + variant + "_front";
		this.m.SpriteDamagedFront = "pauldrons_shoulderplates_heraldic_" + variant + "_front_damaged";
		this.m.SpriteCorpseFront = "pauldrons_shoulderplates_heraldic_" + variant + "_front_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_shoulderplates_heraldic_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_shoulderplates_heraldic_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_shoulderplates_heraldic_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_shoulderplates_heraldic_"  + variant + ".png";
	}
});