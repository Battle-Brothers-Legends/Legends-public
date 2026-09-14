//unused (an effect was supposed to be added?)
this.legend_grand_diviner_robes <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "armor.body.grand_diviner_robes";
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.Name = "Robes of Divination";
		this.m.Description = "The robes worn by the Grand Diviner. The sturdy layers of leather and heavy linen offer excellent protection.";
		this.m.ArmorDescription = "Includes sturdy robes made of heavy linen and leather.";
		this.m.Variants = [1,2];
		this.m.Variant = this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 5000;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.m.StaminaModifier = -3;
		this.m.ItemType = this.Const.Items.ItemType.Cultist | this.Const.Items.ItemType.Legendary;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "diviner_jacket_" + variant;
		this.m.SpriteDamagedBack = "diviner_jacket_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "diviner_jacket_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_diviner_jacket_" + variant + ".png";
		this.m.IconLarge = "legend_armor/inventory_diviner_jacket_" + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_diviner_jacket_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_diviner_jacket_" + variant + ".png";
	}
});
