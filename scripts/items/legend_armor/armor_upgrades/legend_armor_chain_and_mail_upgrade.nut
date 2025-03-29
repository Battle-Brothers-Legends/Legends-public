this.legend_armor_chain_and_mail_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_armor_chain_and_mail";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Amulet Coif";
		this.m.Description = "The amulet and gold chains on this coif are expensive and certainly attract attention";
		this.m.ArmorDescription = "This armor is topped with attractive gold chains";
		this.m.Icon = "armor_upgrades/upgrade_chain_and_mail_01.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_chain_and_mail_01.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_chain_and_mail_01.png";
		this.m.SpriteBack = "upgrade_chain_and_mail";
		this.m.SpriteDamagedBack = "upgrade_chain_and_mail_damaged";
		this.m.SpriteCorpseBack = "upgrade_chain_and_mail_dead";
		this.m.Value = 3000;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.StaminaModifier = -3;
	}
	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+3[/color] Resolve"
		});
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Doubles enemy desire to attack you in battle"
		});
		return result;
	}		
	function onUpdateProperties( _properties )
	{
		this.legend_armor_upgrade.onUpdateProperties(_properties);
		_properties.Bravery += 3;
		_properties.TargetAttractionMult *= 2.0;
	}
});

