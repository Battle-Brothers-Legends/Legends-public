this.legend_named_warlock_hood <- this.inherit("scripts/items/legend_helmets/legend_named_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Vanity;
		this.m.ID = "armor.head.legend_named_warlock_hood";
		this.m.Name = "Warlock Hood";
		this.m.Description = "An ominous hood crafted from witches hair to hide evil intentions.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [1, 2, 3, 4];
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 100;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = 0;
		this.m.Vision = 0;
		this.m.IsLowerVanity = false;
		this.m.HideHair = true;
		this.m.HideBeard = false;
        this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Cultist;
        this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] hitpoints"
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.legend_named_helmet_upgrade.onUpdateProperties( _properties )
		_properties.Hitpoints += 10;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_warlock_hood" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_warlock_hood" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_warlock_hood" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_warlock_hood" + "_" + variant + ".png";
        this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}
});
