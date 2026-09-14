this.legend_basilisk_cloak <- this.inherit("scripts/items/legend_armor/legend_armor_cloak", {
	m = {},
	function create()
	{
		this.legend_armor_cloak.create();
		this.m.ID = "legend_armor.body.legend_basilisk_cloak";
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak;
		this.m.Name = "Basilisk Cloak";
		this.m.Description = "A cloak made from the feathers of a basilisk. The weave offers additional padding and protects the wearer from poison.";
		this.m.ArmorDescription = "Includes a cloak made from the feathers of a Basilisk.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 2800;
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
		this.m.StaminaModifier = -3;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "cloak_basilisk_" + variant + "";
		this.m.SpriteDamagedBack = "cloak_basilisk_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "cloak_basilisk_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_cloak_basilisk_" + variant + ".png";
		this.m.IconLarge = "legend_armor/inventory_cloak_basilisk_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_cloak_basilisk_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cloak_basilisk_"  + variant + ".png";
	}

	function getTooltip()
	{
		local result = this.legend_armor_cloak.getTooltip();
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Unaffected by poison"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Unaffected by poison"
		});
	}

	function onUpdateProperties( _properties )
	{
		this.legend_armor_cloak.onUpdateProperties(_properties);
		_properties.IsImmuneToPoison = true;
	}
});
