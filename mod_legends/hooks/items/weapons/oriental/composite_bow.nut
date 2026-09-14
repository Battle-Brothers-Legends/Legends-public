::mods_hookExactClass("items/weapons/oriental/composite_bow", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Shortbow;
		this.m.Variants = [1, 2, 3];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		this.m.Icon = "weapons/ranged/composite_bow_0" + this.getVariant() + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/composite_bow_0" + this.getVariant() + ".png";
		this.m.ArmamentIcon = "icon_composite_bow_0" + this.getVariant();
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendVolley);
	}
});
