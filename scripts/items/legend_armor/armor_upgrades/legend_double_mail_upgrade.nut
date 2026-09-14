this.legend_double_mail_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_double_mail";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Double Mail";
		this.m.Description = "A set of thick double mail patches worn as shoulderguards. Heavy, but effective in adding to an armor\'s protection.";
		this.m.ArmorDescription = "Includes a set of thick double mail shoulderguards.";
		this.m.Variants = [1,2,3,4];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 600;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.StaminaModifier = 0;
		this.m.DamageReceivedArmorMult = -10.0;
		this.m.FatiguePenaltyMultiplier = 20.0;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_double_mail_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_double_mail_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_double_mail_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_double_mail_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_double_mail_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_double_mail_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_double_mail_"  + variant + ".png";
	}
});