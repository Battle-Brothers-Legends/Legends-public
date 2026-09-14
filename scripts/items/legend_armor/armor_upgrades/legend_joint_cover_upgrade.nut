this.legend_joint_cover_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_joint_cover";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Metal Joint Covers";
		this.m.Description = "A set of large, circular metal plates that cover the vulnerable shoulder joints.";
		this.m.ArmorDescription = "Includes a set of large metal plates added to shoulder joints.";
		this.m.Variants = [1,2,3,4,5,6,7,8];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 750;
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
		this.m.StaminaModifier = -6;
		this.m.DirectDamageModifier = -30.0;
	}
		
	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_joint_cover_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_joint_cover_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_joint_cover_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_joint_cover_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_joint_cover_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_joint_cover_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_joint_cover_"  + variant + ".png";
	}
});