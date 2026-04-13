::mods_hookExactClass("items/weapons/noble_sword", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/sword_03" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/sword_03" + v + ".png";
		this.m.ArmamentIcon = "icon_sword_03" + v;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Puncture, function (_skill) {
			_skill.m.IsHalfsword = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Hammer, function (_skill) {
			_skill.m.IsMordhau = true;
		}.bindenv(this));
	}

});
