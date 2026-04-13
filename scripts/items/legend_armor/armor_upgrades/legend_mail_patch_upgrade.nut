this.legend_mail_patch_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_mail_patch";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Mail Patch";
		this.m.Description = "A large patch of mail that can be added to any armor to protect the most arms and the shoulders.";
		this.m.ArmorDescription = "Includes a large patch of mail worn on the shoulders.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 500;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.StaminaModifier = -4;
		this.m.DirectDamageModifier = -25.0;
	}
		
	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_mail_patch_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_mail_patch_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_mail_patch_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_mail_patch_" + variant + "_upgrade.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_mail_patch_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_mail_patch_"  + variant + ".png";
	}
});

