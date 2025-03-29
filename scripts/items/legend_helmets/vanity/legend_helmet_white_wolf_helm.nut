
this.legend_helmet_white_wolf_helm <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {
		ThreatBonus = 10
	},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Vanity;
		this.m.ID = "armor.head.legend_helmet_white_wolf_helm";
		this.m.Name = "White Wolf Helm";
		// this.m.NameList = [
		// 	"Crown of the king of beasts",
		// 	"Helmet of the White Wolf",
		// 	"Wulfserker Coif",
		// 	"Wolf Kings Helm",
		// 	"White Wolf Crown",
		// 	"Predator Crown"
		// ];
		// this.m.Name = this.m.NameList[this.Math.rand(0, this.m.NameList.len())];
		this.m.Description = "The trophy of a white wolf head.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [1];
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
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.ThreatBonus + "[/color]"
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.legend_helmet_upgrade.onUpdateProperties(_properties);
		_properties.Threat += this.m.ThreatBonus;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_white_wolf_helm" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_white_wolf_helm" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_white_wolf_helm" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_white_wolf_helm" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}
});
