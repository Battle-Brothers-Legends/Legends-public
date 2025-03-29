this.legend_joint_cover_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_joint_cover";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Metal Joint Covers";
		this.m.Description = "Large metal plates that cover the vulnerable shoulder joints.";
		this.m.ArmorDescription = "Large metal plates have been added to protect the vulnerable shoulder joints.";
		this.m.Icon = "armor_upgrades/upgrade_10.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_10.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_10.png";
		this.m.SpriteBack = "upgrade_10_back";
		this.m.SpriteDamagedBack = "upgrade_10_back_damaged";
		this.m.SpriteCorpseBack = "upgrade_10_back_dead";

		this.m.Value = 750;
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
		this.m.StaminaModifier = -6;
		this.m.DirectDamageModifier = -30.0;
	}
});

