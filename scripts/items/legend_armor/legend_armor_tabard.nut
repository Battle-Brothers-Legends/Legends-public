this.legend_armor_tabard <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {
		Bravery = 1 // [Legacy] This should not be used anymore in the future. Instead use this.m.ResolveModifier
	},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Tabbard;
		this.m.ID = "legend_armor.company_tabard";
		this.m.Name = "Tabard";
		this.m.Description = "A flowing cloth covering for armor, to show your allegiance. Offers minimal protection and small boost to morale.";
		this.m.ArmorDescription = "Has a flowing cloth tabard";
		this.m.Variants = [
			101,
			102,
			103,
			104,
			105,
			106,
			107,
			108,
			109,
			110,
			111,
			112,
			113
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Value = 200;
		this.m.Condition = 5;
		this.m.ConditionMax = 5;
		this.m.StaminaModifier = 0;
	}

	function updateVariant()
	{
		local variant = this.m.Variant < 10 ? "0" + this.m.Variant : this.m.Variant;
		this.m.SpriteBack = "legend_tabard_" + variant;
		this.m.SpriteDamagedBack = "legend_tabard_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "legend_tabard_" + variant + "_dead";
		this.m.Icon = "legend_armor/tabard/tabard_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/tabard/icon_tabard_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/tabard/inventory_tabard_" + variant + ".png";
	}

	function getResolveModifier()	// Temporary solution to grant backwards compatibility
	{
		return this.m.Bravery;
	}

	function onPaintSpecificColor( _color )
	{
		this.m.Variant =  _color;

		local app = this.m.Armor.getContainer().getAppearance();
		this.updateAppearance(app);
	}

	function onSerialize( _out )
	{
		_out.writeString(this.m.Name);
		this.legend_armor_upgrade.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.m.Name = _in.readString();
		this.legend_armor_upgrade.onDeserialize(_in);
	}

});

