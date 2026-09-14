
this.legend_helmet_nach_helm <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.ID = "armor.head.legend_helmet_nach_helm";
		this.m.Type = this.Const.Items.HelmetUpgrades.Vanity;
		this.m.Name = "Skin Ghoul Helmet";
		this.m.Description = "A helmet fashioned made from the face and horns of a skin ghoul.";
		this.m.ArmorDescription = "Includes some skin ghoul's parts.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 200;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = -1;
		this.m.Vision = 0;
		this.m.Lower = false;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		// this.m.NameList = ["Rotten visage","Helm of the Ghoul","Ghoul Crown","Ghoul Helm","Ghoul Crown","Skin Crown"];
		// this.m.Name = this.m.NameList[this.Math.rand(0, this.m.NameList.len())];
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_nach_helm_" + variant;
		this.m.SpriteDamaged = "legendhelms_nach_helm_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_nach_helm_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_nach_helm_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

	function getTooltip()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		return this.onArmorTooltip(result);
	}

	function onArmorTooltip( result )
	{
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants the Gruesome Feast active skill"
		});

		return result;
	}

	function onEquip()
	{
		this.legend_helmet_upgrade.onEquip();
		if (!this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendGruesomeFeast))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendGruesomeFeast);
		}
	}
});
