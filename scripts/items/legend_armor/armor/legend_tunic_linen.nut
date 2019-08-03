this.legend_tunic_linen <- this.inherit("scripts/items/legend_armor/legend_armor", {
	m = {},
	function create()
	{
		this.legend_armor.create();
		this.m.ID = "legend.armor.body.linen_tunic";
		this.m.Name = "Linen Tunic";
		this.m.Description = "A simple cloth tunic. Fashionable but offering little in protection.";
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = this.Math.rand(3, 7);
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 45;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.StaminaModifier = 0;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "bust_body_" + variant;
		this.m.SpriteDamaged = "bust_body_" + variant + "_damaged";
		this.m.SpriteCorpse = "bust_body_" + variant + "_dead";
		this.m.IconLarge = "armor/inventory_body_armor_" + variant + ".png";
		this.m.Icon = "armor/icon_body_armor_" + variant + ".png";
	}

});

