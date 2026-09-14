this.legend_heavy_gladiator_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_heavy_gladiator_upgrade";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Metal Armor Pieces";
		this.m.Description = "A metal armguard that provides additional protection, used by gladiators in fighting pits.";
		this.m.ArmorDescription = "Includes a metal armguard.";
		this.m.Variants = [1,2,3,4,5,6,7];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 800;
		this.m.Condition = 75;
		this.m.ConditionMax = 75;
		this.m.StaminaModifier = -6;
	}
		
	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_gladiator_heavy_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_gladiator_heavy_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_gladiator_heavy_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_gladiator_heavy_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_gladiator_heavy_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_gladiator_heavy_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_gladiator_heavy_"  + variant + ".png";
	}
});