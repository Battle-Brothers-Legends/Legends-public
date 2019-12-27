this.legend_metal_plating_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.metal_plating";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Metal Plates and Rivets";
		this.m.Description = "Thick metal plates that are rivetted to the underlying armor. Very crude, but an easy way to quickly add protection.";
		this.m.ArmorDescription = "This armor has a layer of crudely riveted metal plates for additional protection.";
		this.m.Icon = "armor_upgrades/upgrade_12.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_12.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_12.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "upgrade_12_back";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "upgrade_12_back_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "upgrade_12_back_dead";
		this.m.Value = 300;
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
		this.m.ConditionModifier = 30;
		this.m.StaminaModifier = -3;
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+30[/color] Durability"
		});
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-3[/color] Maximum Fatigue"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
	}

});

