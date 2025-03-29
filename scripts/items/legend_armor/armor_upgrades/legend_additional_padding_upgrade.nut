this.legend_additional_padding_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_additional_padding";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Additional Fur Padding";
		this.m.Description = "Crafted from thick furs, this additional padding helps dampen the impact of any blow.";
		this.m.ArmorDescription = "Additional fur padding helps to further dampen the impact of any blow.";
		this.m.Icon = "armor_upgrades/upgrade_03.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_03.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_03.png";
		this.m.SpriteBack = "upgrade_03_back";
		this.m.SpriteDamagedBack = "upgrade_03_back";
		this.m.SpriteCorpseBack = "upgrade_03_back_dead";

		this.m.Value = 1200;
		this.m.Condition = 1;
		this.m.ConditionMax = 1;
		this.m.StaminaModifier = -2;
		this.m.DirectDamageModifier = -35.0;
	}
});

