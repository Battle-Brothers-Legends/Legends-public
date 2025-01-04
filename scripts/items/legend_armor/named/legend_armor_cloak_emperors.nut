this.legend_armor_cloak_emperors <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {
		BraveryMult = 1.05
	},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak;
		this.m.ID = "legend_armor.cloak_emperor";
		this.m.Name = "The Emperor\'s Cloak";
		this.m.Description = "A cloak of the finest material that was rumored to have been worn by the last emperor";
		this.m.ArmorDescription = "Has a flowing embroidered cloak";
		this.m.Variants = [
			1,
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Value = 15000;
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
		this.m.StaminaModifier = -3;
		this.randomizeValues();
	}

	function randomizeValues()
	{
		this.m.Condition = this.Math.rand(30, 40);
		this.m.ConditionMax = this.m.Condition;
		this.m.BraveryMult = this.Math.rand(105, 110) * 0.01;
	}

	function updateVariant()
	{
		local variant = this.m.Variant < 10 ? "0" + this.m.Variant : this.m.Variant;
		this.m.SpriteBack = "bust_named_emperors_cloak_" + variant + "";
		this.m.SpriteDamagedBack = "bust_named_emperors_cloak_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "bust_named_emperors_cloak_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_named_emporers_cloak_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_named_emporers_cloak_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_named_emporers_cloak_" + variant + ".png";
	}

	function getTooltip()
	{
		local result = this.legend_named_armor_upgrade.getTooltip();
		local val = this.Math.floor(this.m.BraveryMult * 100.0 - 100);
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increase the Resolve of the wearer by [color=" + this.Const.UI.Color.PositiveValue + "]+" + val + "%[/color]"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		local val = this.Math.floor(this.m.BraveryMult * 100.0 - 100);
		_result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increase the Resolve of the wearer by [color=" + this.Const.UI.Color.PositiveValue + "]+" + val + "%[/color]"
		});
	}

	function onUpdateProperties( _properties )
	{
		_properties.BraveryMult *= this.m.BraveryMult;
	}

	function onSerialize( _out )
	{
		_out.writeF32(this.m.BraveryMult);
		this.legend_named_armor_upgrade.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.m.BraveryMult = _in.readF32();
		this.legend_named_armor_upgrade.onDeserialize(_in);
	}

});

