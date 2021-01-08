
this.legend_helmet_faceplate_pointed <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Top;
		this.m.ID = "armor.head.legend_helmet_faceplate_pointed";
		this.m.Name = "Pointed Faceplate";
		this.m.Description = "A long nosed faceplate designed to deflect glancing blows";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [1];
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 450;
		this.m.Condition = 47;
		this.m.ConditionMax = 47;
		this.m.StaminaModifier = -3;
		this.m.Vision = -1;
		this.m.IsLowerVanity = false;
		this.m.HideHair = false;
		this.m.HideBeard = true;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_faceplate_pointed" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_faceplate_pointed" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_faceplate_pointed" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_faceplate_pointed" + "_" + variant + ".png";
        this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}
});
