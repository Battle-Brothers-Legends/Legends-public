this.legend_armor_spiked_collar_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_armor_spiked_collar";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Spiked Coif";
		this.m.Description = "A spiked mail coif which adds another layer of defense, at the expense of weight and sound as it jangles";
		this.m.ArmorDescription = "This armor is topped with a noisey spiked mail coif";
		this.m.Icon = "armor_upgrades/upgrade_spiked_chain_collar_01.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_spiked_chain_collar_01.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_spiked_chain_collar_01.png";
		this.m.SpriteBack = "upgrade_spiked_collar";
		this.m.SpriteDamagedBack = "upgrade_spiked_collar_damaged";
		this.m.SpriteCorpseBack = "upgrade_spiked_collar_dead";
		this.m.Value = 200;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.StaminaModifier = -3;
	}
	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+3[/color] Melee Defense"
		});
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-6[/color] Initiative"
		});		
		return result;
	}	
	function onArmorTooltip( _result )
	{
		_result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+3[/color] Melee Defense"
		});

		_result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-6[/color] Initiative"
		});
	}	
	function onUpdateProperties( _properties )
	{
		this.legend_armor_upgrade.onUpdateProperties(_properties);
		_properties.MeleeDefense += 3;
		_properties.Initiative -= 6;
	}
});

