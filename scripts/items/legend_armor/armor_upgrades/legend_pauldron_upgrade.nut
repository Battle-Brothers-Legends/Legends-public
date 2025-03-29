this.legend_pauldron_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_pauldron";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Iron Pauldrons";
		this.m.Description = "These segments of iron plate are heavy but excellent for protecting shoulders. Worn over common armor, they can help to deflect incoming blows.";
		this.m.ArmorDescription = "Segments of iron plates provide additional protection.";
		this.m.Icon = "armor_upgrades/icon_pauldrons_01.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_pauldrons_01.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_pauldrons_01.png";
		this.m.SpriteBack = "upgrade_pauldrons";
		this.m.SpriteDamagedBack = "upgrade_pauldrons_damaged";
		this.m.SpriteCorpseBack = "upgrade_pauldrons_dead";

		this.m.Value = 2000;
		this.m.Condition = 50;
		this.m.ConditionMax = 50;
		this.m.StaminaModifier = -8;
		this.m.DirectDamageModifier = -40.0;
	}
});

