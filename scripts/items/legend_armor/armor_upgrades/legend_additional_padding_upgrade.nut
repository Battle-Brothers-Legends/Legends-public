this.legend_additional_padding_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_additional_padding";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Additional Fur Padding";
		this.m.Description = "An additional set of padding crafted from thick furs. Worn atop armor to make the wearer more resilient against piercing attacks.";
		this.m.ArmorDescription = "Includes an additional set of fur padding.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 1200;
		this.m.Condition = 5;
		this.m.ConditionMax = 5;
		this.m.StaminaModifier = -1;
		this.m.DirectDamageModifier = -15.0;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_padding_fur_" + variant + "_back";
		this.m.SpriteDamagedBack = "pauldrons_padding_fur_" + variant + "_back_damaged";
		this.m.SpriteCorpseBack = "pauldrons_padding_fur_" + variant + "_back_dead";
		this.m.SpriteFront = "pauldrons_padding_fur_" + variant + "_front";
		this.m.SpriteDamagedFront = "pauldrons_padding_fur_" + variant + "_front_damaged";
		this.m.SpriteCorpseFront = "pauldrons_padding_fur_" + variant + "_front_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_padding_fur_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_padding_fur_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_padding_fur_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_padding_fur_"  + variant + ".png";
	}

	function updateTooltip( _tooltip )	{
		_tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces any ranged damage to the body by [color=%negative%]-10%[/color]"
		});
		return _tooltip;
	}

	function getTooltip()	{
		return updateTooltip(this.legend_armor_upgrade.getTooltip());
	}

	function onArmorTooltip( _result )	{
		this.legend_armor_upgrade.onArmorTooltip(updateTooltip(_result));
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo.BodyPart == this.Const.BodyPart.Body)
		{
			_properties.DamageReceivedRangedMult *= 0.9;
		}
	}
});

