::mods_hookExactClass("items/weapons/greataxe", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 2725;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/axe_two_handed_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/axe_two_handed_01" + v + ".png";
		this.m.ArmamentIcon = "icon_axe_two_handed_01" + v;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHaftstrike);
	}

});
