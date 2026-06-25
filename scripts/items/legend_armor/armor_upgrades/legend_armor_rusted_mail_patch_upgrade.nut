this.legend_armor_rusted_mail_patch_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_armor_rusted_mail_patch";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Rusted Mail Patch";
		this.m.Description = "A large rusty patch of mail that can be added to any armor to protect the arms and the shoulders.";
		this.m.ArmorDescription = "Includes a large rusty patch of mail worn on the shoulders.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 250;
		this.m.Condition = 15;
		this.m.ConditionMax = 15;
		this.m.StaminaModifier = -4;
		this.m.DirectDamageModifier = -15.0;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_rusted_mail_patch_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_rusted_mail_patch_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_rusted_mail_patch_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_rusted_mail_patch_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_rusted_mail_patch_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_rusted_mail_patch_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_rusted_mail_patch_"  + variant + ".png";
	}
});
