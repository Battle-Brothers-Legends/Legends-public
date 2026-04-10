::mods_hookExactClass("items/weapons/war_bow", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/ranged/bow_05" + v + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/bow_05" + v + ".png";
		this.m.ArmamentIcon = "icon_war_bow" + v;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		// ::Legends.Actives.grant(this, ::Legends.Active.LegendCascade);
	}
});
