this.legend_redback_cloak <- this.inherit("scripts/items/legend_armor/legend_armor_cloak", {
	m = {
		RangedDamageModifier = -30
	},
	function create()
	{
		this.legend_armor_cloak.create();
		this.m.ID = "legend_armor.body.legend_redback_cloak";
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak;
		this.m.Name = "Redback Silk Cloak";
		this.m.Description = "This lightweight, flowing cloak is made from spider web. It offers excellent protection against poison and ranged attacks.";
		this.m.ArmorDescription = "A cloak of spider silk offers protection against ranged attacks and poisons";
		this.m.Icon = "armor_upgrades/upgrade_cloak_black.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_cloak_black.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_cloak_black.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "cloak_black";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "cloak_black_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "cloak_black_dead";

		this.m.Value = 6000;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = -1;
	}

	function getTooltip()
	{
		local result = this.legend_armor_cloak.getTooltip();
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces any ranged damage to the body by [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.RangedDamageModifier + "%[/color]"
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Hits to the body never inflict poisons"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces any ranged damage to the body by [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.RangedDamageModifier + "%[/color]"
		});
		_result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Hits to the body never inflict poisons"
		});
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo.BodyPart == this.Const.BodyPart.Body)
		{
			_properties.IsImmuneToPoison = true;
			_properties.DamageReceivedRangedMult *= 1.0 + (this.m.RangedDamageModifier / 100);
		}
	}

	function updateVariant()	// Needs to overwrite the base function which would otherwise overwrite Icon and Graphic of this Cloak
	{
	}
});
