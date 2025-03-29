this.legend_negative_weathered_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_negative_weathered";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Weathered";
		this.m.Description = "";
		this.m.ArmorDescription = "This armor is slightly weathered from dust and rain, which has made the metal dull and leather brittle.";
		this.m.Icon = null;
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_downgrade_04.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_downgrade_04.png";
		this.m.SpriteBack = "downgrade_04_back";
		this.m.SpriteDamagedBack = "downgrade_04_back";
		this.m.SpriteCorpseBack = "downgrade_04_back_dead";
		this.m.Value = -150;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "No armor attachment slot"
		});
	}

	function onAdded()
	{
		this.m.Armor.m.Condition += -15;
		this.m.Armor.m.ConditionMax += -15;
	}

});

