this.legend_metal_pauldrons_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_metal_pauldrons";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Metal Pauldrons";
		this.m.Description = "Sturdy metal pauldrons providing an additional layer of protection for shoulders and arms, while considerably weighing the wearer down.";
		this.m.ArmorDescription = "Includes a set of sturdy metal pauldrons.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 800;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.m.StaminaModifier = -6;
	}
		
	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_metal_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_metal_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_metal_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_metal_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_metal_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_metal_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_metal_"  + variant + ".png";
	}
});