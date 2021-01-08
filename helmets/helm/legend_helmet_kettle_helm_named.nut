
this.legend_helmet_kettle_helm_named <- this.inherit("scripts/items/legend_helmets/legend_named_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Helm;
		this.m.ID = "armor.head.legend_helmet_kettle_helm_named";
		this.m.Name = "Kettle Helm";
        this.m.NameList = this.Const.Strings.LegendArmorLayers;
		this.m.Description = "An exceptional and sturdy kettle helm. Blackened and polished, it has a gilded point.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [1];
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 2300;
		this.m.Condition = 160;
		this.m.ConditionMax = 160;
		this.m.StaminaModifier = -6;
		this.m.Vision = -2;
		this.m.IsLowerVanity = false;
		this.m.HideHair = true;
		this.m.HideBeard = false;
        this.randomizeValues();
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_kettle_helm_named" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_kettle_helm_named" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_kettle_helm_named" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_kettle_helm_named" + "_" + variant + ".png";
        this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

	function randomizeValues()
	{
        this.m.Vision = this.Math.rand(0, 0);
		this.m.StaminaModifier = this.Math.rand(-6, -3);
		this.m.Condition = this.Math.rand(160, 185);
		this.m.ConditionMax = this.m.Condition;
	}
});
