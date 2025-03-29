this.legend_negative_shabby_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_negative_shabby";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Shabby";
		this.m.Description = "";
		this.m.ArmorDescription = "It appears that the previous owner did not take care of it at all; parts are missing or have been replaced with improvised patchings.";
		this.m.Icon = null;
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_downgrade_02.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_downgrade_02.png";
		this.m.SpriteBack = "downgrade_02_back";
		this.m.SpriteDamagedBack = "downgrade_02_back";
		this.m.SpriteCorpseBack = "downgrade_02_back_dead";
		this.m.Value = -100;
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
		this.m.Armor.m.Condition += -10;
		this.m.Armor.m.ConditionMax += -10;
	}

});

