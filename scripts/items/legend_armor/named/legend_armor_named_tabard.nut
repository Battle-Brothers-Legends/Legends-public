this.legend_armor_named_tabard <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {
		BraveryMult = 1.03,
		Potential = {
			Condition = { min = 10, max = 15 },
			StaminaModifier = { min = 0, max = 0 },
			BraveryMult = { min = 105, max = 110 }
		}
	},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.ID = "legend_armor.body.named_tabard";
		this.m.Type = this.Const.Items.ArmorUpgrades.Tabbard;
		this.m.Name = "";
		this.m.Description = "A luxurious striped tabard made of a sturdy material, reinforced at seams with pure gold.";
		this.m.ArmorDescription = "Includes a luxurious striped tabard.";
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Variants = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Value = 6000;
		this.randomizeValues();
		this.m.NameList = ["Majesty","Splendor","Pageantry","Swank","Nobility","Elegance","Opulence","Excess","Resplendence","Glory"];
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "tabard_named_" + variant;
		this.m.SpriteDamagedBack = "tabard_named_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "tabard_named_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_tabard_named_" + variant + ".png";
		this.m.IconLarge = "legend_armor/inventory_tabard_named_" + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_tabard_named_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_tabard_named_" + variant + ".png";
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
