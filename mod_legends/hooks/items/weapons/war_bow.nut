::mods_hookExactClass("items/weapons/war_bow", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.RangedWeapon | ::Const.Items.ItemType.Defensive | ::Const.Items.ItemType.TwoHanded;
		this.m.Variants = [1, 2, 3];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		this.m.Icon = "weapons/ranged/war_bow_0" + this.getVariant() + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/war_bow_0" + this.getVariant() + ".png";
		this.m.ArmamentIcon = "icon_war_bow_0" + this.getVariant();
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendFullDraw);
		::Legends.Actives.grant(this, ::Legends.Active.LegendMarkTarget);
	}
});
