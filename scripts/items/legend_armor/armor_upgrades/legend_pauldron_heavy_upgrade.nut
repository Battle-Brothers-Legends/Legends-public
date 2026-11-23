this.legend_pauldron_heavy_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_pauldron_heavy";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Heavy Pauldrons";
		this.m.Description = "Extremely heavy segments of iron plate, but excellent for protecting shoulders and arms. Worn over armor, they can help deflect incoming blows.";
		this.m.ArmorDescription = "Includes a set of heavy pauldrons.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2200;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.m.StaminaModifier = -8;
		this.m.DirectDamageModifier = -40.0;
	}
		
	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_heavy_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_heavy_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_heavy_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_heavy_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_heavy_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_heavy_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_heavy_"  + variant + ".png";
	}
});