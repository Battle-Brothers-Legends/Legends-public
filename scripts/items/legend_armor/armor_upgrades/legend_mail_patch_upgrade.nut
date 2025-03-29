this.legend_mail_patch_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_mail_patch";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Mail Patch";
		this.m.Description = "A large patch of mail that can be added to any armor to further protect the most vulnerable areas.";
		this.m.ArmorDescription = "A large patch of mail has been added to this armor to further protect the most vulnerable areas.";
		this.m.Icon = "armor_upgrades/upgrade_09.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_09.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_09.png";
		this.m.SpriteBack = "upgrade_09_back";
		this.m.SpriteDamagedBack = "upgrade_09_back_damaged";
		this.m.SpriteCorpseBack = "upgrade_09_back_dead";

		this.m.Value = 500;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.StaminaModifier = -4;
		this.m.DirectDamageModifier = -25.0;
	}
});

