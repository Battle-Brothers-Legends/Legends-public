this.legend_scrap_metal_armor <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "legend_armor.body.scrap_metal_armor";
		this.m.Name = "Scrap Metal Armor";
		this.m.Description = "This armor is pieced together from scavenged metal parts that are fixed to a crude leather tunic.";
		this.m.ArmorDescription = "Includes armor that is pieced together from scavenged metal parts that are fixed to a crude leather tunic.";
		local variant = 94;
		this.m.SpriteBack = "bust_body_" + variant;
		this.m.SpriteDamagedBack = "bust_body_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "bust_body_" + variant + "_dead";
		this.m.Icon = "legend_armor/plate/legend_scrap_metal_armor.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/plate/icon_legend_scrap_metal_armor.png";
		this.m.OverlayIconLarge = "legend_armor/plate/inventory_legend_scrap_metal_armor.png";
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 250;
		this.m.Condition = 65;
		this.m.ConditionMax = 65;
		this.m.StaminaModifier = -10;
	}

});

