this.legend_leather_neckguard_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_leather_neckguard";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Leather Neckguard";
		this.m.Description = "This neckguard of cured leather can be attached to any armor for some additional protection.";
		this.m.ArmorDescription = "A neckguard of cured leather has been attached to this armor for additional protection.";
		this.m.Icon = "armor_upgrades/upgrade_13.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_13.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_13.png";
		this.m.SpriteBack = "upgrade_13_back";
		this.m.SpriteDamagedBack = "upgrade_13_back_damaged";
		this.m.SpriteCorpseBack = "upgrade_13_back_dead";

		this.m.Value = 250;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = -2;
		this.m.DirectDamageModifier = -20.0;
	}
});

