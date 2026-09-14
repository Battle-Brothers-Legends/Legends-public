this.legend_unhold_fur_cloak <- this.inherit("scripts/items/legend_armor/legend_armor_cloak", {
	m = {},
	function create()
	{
		this.legend_armor_cloak.create();
		this.m.ID = "legend_armor.body.legend_unhold_fur_cloak";
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak;
		this.m.Name = "Unhold Fur Cloak";
		this.m.Description = "A thick cloak made out of a Frost Unhold\'s majestic white fur. Can be worn atop any armor to make the wearer more resilient against ranged weapons.";
		this.m.ArmorDescription = "Includes a cloak of thick white fur.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 1000;
		this.m.Condition = 25;
		this.m.ConditionMax = 25;
		this.m.StaminaModifier = -2;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "cloak_fur_unhold_" + variant + "_back";
		this.m.SpriteDamagedBack = "cloak_fur_unhold_" + variant + "_back_damaged";
		this.m.SpriteCorpseBack = "cloak_fur_unhold_" + variant + "_back_dead";
		this.m.SpriteFront = "cloak_fur_unhold_" + variant + "_front";
		this.m.SpriteDamagedFront = "cloak_fur_unhold_" + variant + "_front_damaged";
		this.m.SpriteCorpseFront = "cloak_fur_unhold_" + variant + "_front_dead";
		this.m.Icon = "legend_armor/icon_cloak_fur_unhold_" + variant + ".png";
		this.m.IconLarge = "legend_armor/inventory_cloak_fur_unhold_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_cloak_fur_unhold_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cloak_fur_unhold_"  + variant + ".png";
	}

	function getTooltip()
	{
		local result = this.legend_armor_cloak.getTooltip();
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces any ranged damage to the body by [color=%negative%]-20%[/color]"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces any ranged damage to the body by [color=%negative%]-20%[/color]"
		});
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo.BodyPart == this.Const.BodyPart.Body)
		{
			_properties.DamageReceivedRangedMult *= 0.8;
		}
	}
});
