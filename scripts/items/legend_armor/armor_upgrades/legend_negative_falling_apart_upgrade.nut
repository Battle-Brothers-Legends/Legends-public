this.legend_negative_falling_apart_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_negative_falling_apart";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Falling Apart";
		this.m.Description = "";
		this.m.ArmorDescription = "This armor is close to falling apart. Negligence and long use have left it in a sad state long beyond repairability.";
		this.m.Icon = null;
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_downgrade_01.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_downgrade_01.png";
		this.m.SpriteBack = "downgrade_01_back";
		this.m.SpriteDamagedBack = "downgrade_01_back";
		this.m.SpriteCorpseBack = "downgrade_01_back_dead";
		this.m.Value = -200;
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
		this.m.Armor.m.Condition += -20;
		this.m.Armor.m.ConditionMax += -20;
	}

});

