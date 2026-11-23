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
		this.m.Description = "A lightweight, flowing cloak of spider silk. It offers excellent protection against poison and ranged attacks.";
		this.m.ArmorDescription = "Includes a lightweight cloak of spider silk.";
		this.m.Variants = [1, 2, 3, 4];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 6000;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = -1;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "cloak_redback_" + variant + "";
		this.m.SpriteDamagedBack = "cloak_redback_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "cloak_redback_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_cloak_redback_" + variant + ".png";
		this.m.IconLarge = "legend_armor/inventory_cloak_redback_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_cloak_redback_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cloak_redback_"  + variant + ".png";
	}

	function getTooltip()
	{
		local result = this.legend_armor_cloak.getTooltip();
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces any ranged damage to the body by [color=%negative%]" + this.m.RangedDamageModifier + "%[/color]"
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
			text = "Reduces any ranged damage to the body by [color=%negative%]" + this.m.RangedDamageModifier + "%[/color]"
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
});
