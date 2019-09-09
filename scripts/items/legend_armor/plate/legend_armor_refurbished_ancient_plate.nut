this.legend_armor_refurbished_ancient_plate <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate
		this.m.ID = "legend_armor.refurbished_ancient_plate";
		this.m.Name = "Refurbished Ancient Plate";
		this.m.Description = "Heavy metal plates to be riveted upon lower armors. A very heavy armor that offers great protection.";
		this.m.ArmorDescription = "Has heavy metal plates riveted ontop.";
		this.m.Icon = "legend_armor/plate/icon_legend_armor_refurbished_ancient_plate.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/plate/icon_legend_armor_refurbished_ancient_plate.png";
		this.m.OverlayIconLarge = "legend_armor/plate/inventory_legend_armor_refurbished_ancient_plate.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "legend_armor_refurbished_ancient_plate";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "legend_armor_refurbished_ancient_plate_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "legend_armor_refurbished_ancient_plate_dead";
		this.m.Value = 3500;
		this.m.Condition = 230;
		this.m.ConditionMax = 230;
		this.m.StaminaModifier = 30;
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+230[/color] Durability"
		});
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-30[/color] Maximum Fatigue"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
	}

});

