this.legend_armor_cloak <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {
		Bravery = 0	// [Legacy] This should not be used anymore in the future. Instead use this.m.ResolveModifier
	},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak;
		this.m.ID = "legend_armor.cloak";
		this.m.Name = "Cloak";
		this.m.Description = "The Cloak. Everyone needs a good cloak. Offers minimal protection and small boost to moral.";
		this.m.ArmorDescription = "Has a flowing cloth cloak";
		this.m.Variant = this.Math.rand(1, 35);
		this.updateVariant();
		this.m.Value = 350;
		this.m.Condition = 3;
		this.m.ConditionMax = 3;
		this.m.StaminaModifier = -1;
	}

	function getResolveModifier()	// Temporary solution to grant backwards compatibility
	{
		return this.m.Bravery;
	}

	function updateVariant()
	{
		local variant = this.m.Variant < 10 ? "0" + this.m.Variant : this.m.Variant;
		this.m.SpriteBack = "bust_cloak_" + variant + "";
		this.m.SpriteDamagedBack = "bust_cloak_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "bust_cloak_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_cloak_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_cloak_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cloak_"  + variant + ".png";
	}
});

