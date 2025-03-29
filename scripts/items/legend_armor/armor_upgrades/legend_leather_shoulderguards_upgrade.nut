this.legend_leather_shoulderguards_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_leather_shoulderguards";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Leather Shoulderguards";
		this.m.Description = "Studded leather shoulderguards can help in making even light armors a little bit more resilient.";
		this.m.ArmorDescription = "Shoulderguards made of studded leather have been added to this armor for additional protection.";
		this.m.Icon = "armor_upgrades/upgrade_08.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_08.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_08.png";
		this.m.SpriteBack = "upgrade_08_back";
		this.m.SpriteDamagedBack = "upgrade_08_back_damaged";
		this.m.SpriteCorpseBack = "upgrade_08_back_dead";

		this.m.Value = 250;
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
		this.m.StaminaModifier = -2;
	}
});

