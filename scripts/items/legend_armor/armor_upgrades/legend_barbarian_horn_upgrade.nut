this.legend_barbarian_horn_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_barbarian_horn";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Horn and Bone";
		this.m.Description = "The ceremonial adornment of a self-proclaimed barbarian king. The rare and durable horns act as an suprisingly effective armor.";
		this.m.ArmorDescription = "This armor has been adorned with ceremonial horns by barbarian craftsmen.";
		this.m.Icon = "armor_upgrades/upgrade_23.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_23.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_23.png";
		this.m.SpriteFront = "upgrade_23_front";
		this.m.SpriteBack = "upgrade_23_back";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "upgrade_23_back_damaged";
		this.m.SpriteCorpseFront = "upgrade_23_front_dead";
		this.m.SpriteCorpseBack = "upgrade_23_back_dead";
		this.m.Value = 250;
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
		this.m.ConditionModifier = 40;
		this.m.StaminaModifier = -3;
	}


	function onArmorTooltip( _result )
	{
	}

});

