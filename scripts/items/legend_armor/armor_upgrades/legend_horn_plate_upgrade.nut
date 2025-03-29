this.legend_horn_plate_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_horn_plate";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Horn Plate";
		this.m.Description = "These segments of horn plate are made from one of the hardest yet flexible materials nature has to offer. Worn over common armor, they can help to deflect incoming blows.";
		this.m.ArmorDescription = "Segments of horn plate provide additional protection.";
		this.m.Icon = "armor_upgrades/upgrade_22.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_22.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_22.png";
		this.m.SpriteBack = "upgrade_22_back";
		this.m.SpriteDamagedBack = "upgrade_22_back";
		this.m.SpriteCorpseBack = "upgrade_22_back_dead";

		this.m.Value = 4000;
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
		this.m.StaminaModifier = -6;
		this.m.DirectDamageModifier = -35.0;
	}
});

