::mods_hookExactClass("items/weapons/hunting_bow", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		if (this.getVariant() == 0) {
			this.m.Icon = "weapons/ranged/bow_01_70x70.png";
			this.m.IconLarge = "weapons/ranged/bow_01.png";
			this.m.ArmamentIcon = "icon_hunting_bow";
		} else {
			this.m.Icon = "weapons/ranged/hunting_bow_01_" + this.getVariant() + "_70x70.png";
			this.m.IconLarge = "weapons/ranged/hunting_bow_01_" + this.getVariant() + ".png";
			this.m.ArmamentIcon = "icon_hunting_bow_01_" + this.getVariant();
		}
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		// ::Legends.Actives.grant(this, ::Legends.Active.LegendCascade);
	}
});
