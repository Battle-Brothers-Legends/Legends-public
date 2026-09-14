this.legend_armor_pauldrons_kraken <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_armor_pauldrons_kraken";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Kraken Pauldrons";
		this.m.Description = "These segments of horn plate are made from one of the hardest yet flexible materials nature has to offer. Worn over common armor, they can help to deflect incoming blows.";
		this.m.ArmorDescription = "Segments of horn plate provide additional protection.";
		this.m.Variants = [1,2,3,4];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 4000;
		this.m.Condition = 45;
		this.m.ConditionMax = 45;
		this.m.StaminaModifier = -4;
		this.m.DirectDamageModifier = -35.0;
	}
		
	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_kraken_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_kraken_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_kraken_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_pauldrons_kraken_" + variant + ".png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_kraken_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_kraken_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_kraken_"  + variant + ".png";
	}
});