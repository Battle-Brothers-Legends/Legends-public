this.legend_light_padding_replacement_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_light_padding_replacement";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Light Padding Replacement";
		this.m.Description = "Crafted from exotic materials, this replacement padding can provide the same amount of protection as regular padding at less weight.";
		this.m.ArmorDescription = "This armor has its padding replaced by a lighter but no less durable one.";
		this.m.Icon = "armor_upgrades/upgrade_05.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_05.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_05.png";
		this.m.SpriteBack = "upgrade_05_back";
		this.m.SpriteDamagedBack = "upgrade_05_back_damaged";
		this.m.SpriteCorpseBack = "upgrade_05_back_dead";

		this.m.Value = 2000;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = 0;
		this.m.FatiguePenaltyMultiplier = -40.0;
	}
});

