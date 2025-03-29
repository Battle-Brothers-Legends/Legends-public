this.legend_light_gladiator_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "armor_upgrade.legend_light_gladiator_upgrade";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Padded Armor Pieces";
		this.m.Description = "Padded armpieces that provides additional protection.";
		this.m.ArmorDescription = "This harness has padded armpieces attached that provide additional protection.";
		this.m.Icon = "armor_upgrades/upgrade_24.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_24.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_24.png";
		this.m.SpriteBack = "upgrade_24_front";
		this.m.SpriteDamagedBack = "upgrade_24_front_damaged";
		this.m.SpriteCorpseBack = "upgrade_24_front_dead";

		this.m.Value = 400;
		this.m.Condition = 45;
		this.m.ConditionMax = 45;
		this.m.StaminaModifier = -2;
	}
});

