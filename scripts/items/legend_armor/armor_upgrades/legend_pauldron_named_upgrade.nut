this.legend_pauldron_named_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_pauldron_named";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Gilded Pauldrons";
		this.m.Description = "These segments of worked iron are beautifully decorated and excellent for protecting shoulders and arms. Worn over common armor, they can help to deflect incoming blows.";
		this.m.ArmorDescription = "Segments of decorated iron plates provide additional protection.";
		this.m.Icon = "armor_upgrades/icon_pauldrons_named_01.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_pauldrons_named_01.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_pauldrons_named_01.png";
		this.m.SpriteBack = "upgrade_pauldrons_named";
		this.m.SpriteDamagedBack = "upgrade_pauldrons_named_damaged";
		this.m.SpriteCorpseBack = "upgrade_pauldrons_named_dead";
		this.m.Value = 3000;
		this.m.Condition = 50;
		this.m.ConditionMax = 45;
		this.m.StaminaModifier = -4;
		this.m.DirectDamageModifier = -30.0;
	}
});

