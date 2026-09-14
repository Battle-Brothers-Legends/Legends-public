
this.legend_helmet_hunter_cap <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.ID = "armor.head.legend_helmet_hunter_cap";
		this.m.Type = this.Const.Items.HelmetUpgrades.Vanity;
		this.m.Name = "Hunter's Cap";
		this.m.Description = "The distinctive hat of a game hunter, the pointed shape focuses vision and its ornate feather and shape bristles with confidence, but also makes it an easy target for others.";
		this.m.ArmorDescription = "Includes a distinctive hat of a game hunter.";
		this.m.Variants = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 1200;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = -1;
		this.m.Vision = 1;
		this.m.Lower = false;
		this.m.HideHair = false;
		this.m.HideBeard = false;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_hunter_cap_" + variant;
		this.m.SpriteDamaged = "legendhelms_hunter_cap_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_hunter_cap_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_hunter_cap_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

	function getTooltip()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		this.onArmorTooltip(result);
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = "Makes enemies much more likely to attack you"
		});

		return _result;
	}

	function onUpdateProperties(_properties)
	{
		this.legend_helmet_upgrade.onUpdateProperties(_properties);
		_properties.TargetAttractionMult *= 1.4; // 1.0 = normal aggression, 0.1 = minimal aggression
	}
});
