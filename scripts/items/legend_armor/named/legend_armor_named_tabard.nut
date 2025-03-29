this.legend_armor_named_tabard <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {
		BraveryMult = 1.03
	},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Tabbard;
		this.m.ID = "legend_armor.named_tabard";
		this.m.Name = "";
		this.m.NameList = [
			"Kingly",
			"Splendorous",
			"Pageantry",
			"Swanky",
			"Noble",
			"Elegance",
			"Opulence",
			"Excess",
			"Resplendence",
			"Glorious"
		];
		this.m.Variants = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Value = 6000;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = 0;
		this.randomizeValues();
	}

	function randomizeValues()
	{
		this.m.Condition = this.Math.floor(this.m.Condition * this.Math.rand(110, 150) * 0.01) * 1.0;
		this.m.ConditionMax = this.m.Condition;
		this.m.BraveryMult = this.Math.rand(105, 110) * 0.01;
	}

	function updateVariant()
	{
		local variant = this.m.Variant < 10 ? "0" + this.m.Variant : this.m.Variant;
		this.m.SpriteBack = "bust_tabard_named_" + variant;
		this.m.SpriteDamagedBack = "bust_tabard_named_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "bust_tabard_named_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_tabard_named_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_tabard_named_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_tabard_named_" + variant + ".png";
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