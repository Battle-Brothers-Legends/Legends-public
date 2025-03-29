this.legend_negative_mouldered_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_negative_mouldered";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Mouldered";
		this.m.Description = "";
		this.m.ArmorDescription = "This armor has been exposed to the elements for a long time. Leather is falling apart, cloth is rotten, metal is rusty and perforated.";
		this.m.Icon = null;
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_downgrade_03.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_downgrade_03.png";
		this.m.SpriteBack = "downgrade_03_back";
		this.m.SpriteDamagedBack = "downgrade_03_back";
		this.m.SpriteCorpseBack = "downgrade_03_back_dead";
		this.m.Value = -250;
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
		this.m.Armor.m.Condition += -30;
		this.m.Armor.m.ConditionMax += -30;
	}

});

