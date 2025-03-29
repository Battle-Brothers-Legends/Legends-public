this.legend_pauldron_strong_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_pauldron_strong";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Reinforced Pauldrons";
		this.m.Description = "These segments of iron plate are strong and excellent for protecting shoulders and neck. Worn over common armor, they can help to deflect incoming blows.";
		this.m.ArmorDescription = "Segments of strong iron plates provide additional protection.";
		this.m.Icon = "armor_upgrades/icon_pauldrons_strong_01.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_pauldrons_strong_01.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_pauldrons_strong_01.png";
		this.m.SpriteBack = "upgrade_pauldrons_strong";
		this.m.SpriteDamagedBack = "upgrade_pauldrons_strong_damaged";
		this.m.SpriteCorpseBack = "upgrade_pauldrons_strong_dead";

		this.m.Value = 2500;
		this.m.Condition = 55;
		this.m.ConditionMax = 55;
		this.m.StaminaModifier = -6;
		this.m.DirectDamageModifier = -40.0;
	}
});

