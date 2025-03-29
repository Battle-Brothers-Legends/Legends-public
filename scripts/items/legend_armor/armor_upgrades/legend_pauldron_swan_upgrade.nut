this.legend_pauldron_swan_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_pauldron_swan";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Swan Pauldrons";
		this.m.Description = "These segments of worked iron are curved like swans and excellent for protecting shoulders and arms. Worn over common armor, they can help to deflect incoming blows.";
		this.m.ArmorDescription = "Segments of curved iron plates provide additional protection.";
		this.m.Icon = "armor_upgrades/icon_pauldrons_swan_01.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_pauldrons_swan_01.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_pauldrons_swan_01.png";
		this.m.SpriteBack = "upgrade_pauldrons_swan";
		this.m.SpriteDamagedBack = "upgrade_pauldrons_swan_damaged";
		this.m.SpriteCorpseBack = "upgrade_pauldrons_swan_dead";
		this.m.Value = 2700;
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
		this.m.StaminaModifier = -3;
		this.m.DirectDamageModifier = -30.0;
	}
});

