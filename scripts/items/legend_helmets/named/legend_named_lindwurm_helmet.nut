this.legend_named_lindwurm_helmet <- this.inherit("scripts/items/legend_helmets/legend_named_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Helm;
		this.m.ID = "armor.head.legend_named_lindwurm_helmet";
        this.m.NameList = [
			"Lindwurm\'s Head",
			"Lizard Headpiece",
			"Dragon\'s Dome",
			"Lindwurm Ward",
			"Wurmscale Helmet",
			"Lindwurm Mask"
		];
		this.m.Description = "Covered in the scales of the dreaded Lindwurm, not only does this helmet deflect blows and hits, but they also remain unscathed by the acidic Lindwurm blood.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [1];
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 3000;
		this.m.Condition = 110;
		this.m.ConditionMax = 110;
		this.m.StaminaModifier = -5;
		this.m.Vision = 0;
		this.m.IsLowerVanity = false;
		this.m.HideHair = false;
		this.m.HideBeard = true;
        this.m.ItemType = this.m.ItemType;
        this.randomizeValues();
	}

	function resetStats()
	{
		this.m.Condition = 110;
		this.m.ConditionMax = 110;
		this.m.StaminaModifier = -5;
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
			icon = "ui/icons/special.png",
			text = "Unaffected by acidic Lindwurm blood"
		});
		return result;
	}

	function onEquip()
	{
		this.legend_named_helmet_upgrade.onEquip();
		local c = this.m.Armor.getContainer();

		if (!c.isNull() && !c.getActor().isNull())
		{
			c.getActor().getFlags().add("head_immune_to_acid");
		}
	}

	function onUnequip()
	{
		local c = this.m.Armor.getContainer();

		if (!c.isNull() && !c.getActor().isNull())
		{
			c.getActor().getFlags().remove("head_immune_to_acid");
		}

		this.legend_named_helmet_upgrade.onUnequip();
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_wild_helmet" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_wild_helmet" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_wild_helmet" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_wild_helmet" + "_" + variant + ".png";
        this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}
});
