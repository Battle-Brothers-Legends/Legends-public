
this.legend_helmet_witchhunter_helm <- this.inherit("scripts/items/legend_helmets/legend_named_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Vanity;
		this.m.ID = "armor.head.legend_helmet_witchhunter_helm";
		this.m.Name = "Witchhunter\'s Capotain";
		this.m.Description = "A tough leather hat that provides decent protection against scratches.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [1, 2, 3, 4, 5, 6, 7, 8];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 200;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = -1;
		this.m.Vision = 0;
		this.m.IsLowerVanity = false;
		this.m.HideHair = true;
		this.m.HideBeard = false;
	}

	function getTooltip()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		this.onArmorTooltip(result);
		return result;
	}

	function onArmorTooltip( result )
	{
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Resolve at morale checks against fear, panic or mind control effects"
		});
		return result;
	}

	function onUpdateProperties(_properties)
	{
		this.legend_helmet_upgrade.onUpdateProperties(_properties);
		_properties.MoraleCheckBravery[1] += 5;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_witchhunter_helm" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_witchhunter_helm" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_witchhunter_helm" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_witchhunter_helm" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

});
