this.legend_heavy_gladiator_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "armor_upgrade.legend_heavy_gladiator_upgrade";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Metal Armor Pieces";
		this.m.Description = "Metal armor pieces that provides additional protection.";
		this.m.ArmorDescription = "This harness has metal armor pieces attached that provide additional protection.";
		this.m.Icon = "armor_upgrades/upgrade_25.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_25.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_25.png";
		this.m.SpriteBack = "upgrade_25_front";
		this.m.SpriteDamagedBack = "upgrade_25_front_damaged";
		this.m.SpriteCorpseBack = "upgrade_25_front_dead";

		this.m.Value = 800;
		this.m.Condition = 75;
		this.m.ConditionMax = 75;
		this.m.StaminaModifier = -6;
	}
});

