this.legend_double_mail_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_double_mail";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Double Mail";
		this.m.Description = "A couple of thick double mail patches. Heavy, but effective in further adding to an armor\'s protection.";
		this.m.ArmorDescription = "A thick double mail has been added to this armor for further protection.";
		this.m.Icon = "armor_upgrades/upgrade_19.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_19.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_19.png";
		this.m.SpriteBack = "upgrade_19_back";
		this.m.SpriteDamagedBack = "upgrade_19_back_damaged";
		this.m.SpriteCorpseBack = "upgrade_19_back_dead";

		this.m.Value = 600;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.StaminaModifier = 0;
		this.m.DamageReceivedArmorMult = -10.0;
		this.m.FatiguePenaltyMultiplier = 20.0;
	}
});

