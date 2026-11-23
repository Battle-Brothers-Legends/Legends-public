this.legend_leather_shoulderguards_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_leather_shoulderguards";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Leather Shoulderguards";
		this.m.Description = "A set of studded leather shoulderguards adding a little bit of resiliency to the shoulders.";
		this.m.ArmorDescription = "Includes a set of studded leather shoulderguards.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 250;
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
		this.m.StaminaModifier = -2;
	}
		
	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_leather_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_leather_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_leather_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_leather_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_leather_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_leather_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_leather_"  + variant + ".png";
	}
});