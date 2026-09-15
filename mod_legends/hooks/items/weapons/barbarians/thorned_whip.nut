::mods_hookExactClass("items/weapons/barbarians/thorned_whip", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Categories = "Cleaver/Whip, One-Handed";
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.OneHanded | ::Const.Items.ItemType.Cultist;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/wildmen_11" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/wildmen_11" + v + ".png";
		this.m.ArmamentIcon = "icon_wildmen_11" + v;
	}
});
