this.legend_pauldron_heavy_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_pauldron_heavy";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Heavy Pauldrons";
		this.m.Description = "These segments of iron plate are extremely heavy but excellent for protecting shoulders and arms. Worn over common armor, they can help to deflect incoming blows.";
		this.m.ArmorDescription = "Segments of iron plates provide additional protection.";
		this.m.Icon = "armor_upgrades/icon_pauldrons_heavy_01.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_pauldrons_heavy_01.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_pauldrons_heavy_01.png";
		this.m.SpriteBack = "upgrade_pauldrons_heavy";
		this.m.SpriteDamagedBack = "upgrade_pauldrons_heavy_damaged";
		this.m.SpriteCorpseBack = "upgrade_pauldrons_heavy_dead";

		this.m.Value = 2200;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.m.StaminaModifier = -8;
		this.m.DirectDamageModifier = -40.0;
	}
});

