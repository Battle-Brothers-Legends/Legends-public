this.legend_metal_pauldrons_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_metal_pauldrons";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Metal Pauldrons";
		this.m.Description = "Sturdy metal pauldrons that can be added to any armor for increased protection of the shoulders and upper body. Of course, it will also make the armor a bit heavier.";
		this.m.ArmorDescription = "Sturdy metal pauldrons have been added to this armor for increased protection of the shoulders and upper body, but at the expense of additional weight.";
		this.m.Icon = "armor_upgrades/upgrade_11.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_11.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_11.png";
		this.m.SpriteBack = "upgrade_11_back";
		this.m.SpriteDamagedBack = "upgrade_11_back_damaged";
		this.m.SpriteCorpseBack = "upgrade_11_back_dead";

		this.m.Value = 800;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.m.StaminaModifier = -6;
	}
});

