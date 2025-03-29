this.legend_armor_hexe_leader_cloak_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_hexe_leader_cloak";
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak;
		this.m.Name = "Hexen Redback Silk Cloak";
		this.m.Description = "This flowing cloak is made from spider web, and offers excellent protection against ranged attacks.";
		this.m.ArmorDescription = "A cloak of spider silk offers extra protection";
		this.m.SpriteBack = "bust_cloak_hexe";
		this.m.SpriteDamagedBack = "bust_cloak_hexe_damaged";
		this.m.SpriteCorpseBack = "bust_cloak_hexe_dead";
		this.m.Icon = "legend_armor/icon_cloak_hexe.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_cloak_hexe.png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cloak_hexe.png";
		this.m.Value = 12000;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.StaminaModifier = 0;
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces any ranged damage to the body by [color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] and increases resolve by [color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color]"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces any ranged damage to the body by [color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] and increases resolve by [color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color]"
		});
	}

	function onUpdateProperties( _properties )
	{
		_properties.BraveryMult *= 1.15;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo.BodyPart == this.Const.BodyPart.Body)
		{
			_properties.DamageReceivedRangedMult *= 0.9;
		}
	}

});

