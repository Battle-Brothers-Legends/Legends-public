this.legend_armor_cloak_emperors <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {
		BraveryMult = 1.05,
		Potential = {
			Condition = { min = 30, max = 40 },
			StaminaModifier = { min = 3, max = 3 },
			BraveryMult = { min = 105, max = 110 }
		}
	},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.ID = "legend_armor.body.cloak_emperor";
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak;
		this.m.Name = "The Emperor\'s Cloak";
		this.m.Description = "A cloak of the finest material that was rumored to have been worn by the last emperor.";
		this.m.ArmorDescription = "Has a flowing embroidered cloak of the finest material.";
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Variants = [1, 2, 3, 4];
		this.m.Variant = 1;
		this.updateVariant();
		this.m.Value = 15000;
		this.randomizeValues();
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "cloak_emperors_named_" + variant + "";
		this.m.SpriteDamagedBack = "cloak_emperors_named_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "cloak_emperors_named_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_cloak_emperors_named_" + variant + ".png";
		this.m.IconLarge = "legend_armor/inventory_cloak_emperors_named_" + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_cloak_emperors_named_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cloak_emperors_named_" + variant + ".png";
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

