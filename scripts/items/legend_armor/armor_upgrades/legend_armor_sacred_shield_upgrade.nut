this.legend_armor_sacred_shield_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_armor_sacred_shield";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Sacred Shield";
		this.m.Description = "A holy relic shield to be strapped to your shoulder, it protects both physically and spiritually. This is primarily of benefit to those who are strong of mind";
		this.m.ArmorDescription = "A holy relic shield has been attached to this armor, it protects both physically and spiritually";
		this.m.Icon = "armor_upgrades/icon_upgrade_belt_and_shield_01.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_belt_and_shield_01.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_belt_and_shield_01.png";
		this.m.SpriteBack = "upgrade_belt_and_shield";
		this.m.SpriteDamagedBack = "upgrade_belt_and_shield_damaged";
		this.m.SpriteCorpseBack = "upgrade_belt_and_shield_dead";

		this.m.Value = 200;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = -1;
	}
	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Resolve"
		});
		return result;
	}	
	function onUpdateProperties( _properties )
	{
		this.legend_armor_upgrade.onUpdateProperties(_properties);
		_properties.BraveryMult *= 1.05;
	}
});

