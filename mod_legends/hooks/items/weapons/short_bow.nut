::mods_hookExactClass("items/weapons/short_bow", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.RangedWeapon | ::Const.Items.ItemType.Defensive | ::Const.Items.ItemType.TwoHanded | ::Const.Items.ItemType.Shortbow;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.RangeIdeal = 6;
		this.m.RangeMax = 6;
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/ranged/bow_02" + v + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/bow_02" + v + ".png";
		this.m.ArmamentIcon = "icon_short_bow" + v;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendVolley);
	}

});
