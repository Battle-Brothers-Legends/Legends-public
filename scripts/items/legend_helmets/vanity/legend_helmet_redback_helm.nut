
this.legend_helmet_redback_helm <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.ID = "armor.head.legend_helmet_redback_helm";
		this.m.Type = this.Const.Items.HelmetUpgrades.Vanity;
		this.m.Name = "Redback Helm";
		this.m.Description = "A light helmet made from the carapace of a redback spider.";
		this.m.ArmorDescription = "Includes a redback carapace helmet.";
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
		// this.m.NameList = ["Redback Carapace","Helm of the Spider","Arachnid Crown","Spider Queen Helm","Redback Crown","Poison Crown"];
		// this.m.Name = this.m.NameList[this.Math.rand(0, this.m.NameList.len())];
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_redback_helm_" + variant;
		this.m.SpriteDamaged = "legendhelms_redback_helm_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_redback_helm_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_redback_helm_" + variant + ".png";
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

	function onArmorTooltip( result )
	{
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants poison immunity"
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants the Web Cast active skill"
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.legend_helmet_upgrade.onUpdateProperties(_properties);
		_properties.IsImmuneToPoison = true;
	}

	function onEquip()
	{
		this.legend_helmet_upgrade.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Web);
	}
});
