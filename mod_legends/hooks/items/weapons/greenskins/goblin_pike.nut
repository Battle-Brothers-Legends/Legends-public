::mods_hookExactClass("items/weapons/greenskins/goblin_pike", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.IsAoE = true;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/goblin_weapon_04" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/goblin_weapon_04" + v + ".png";
		this.m.ArmamentIcon = "icon_goblin_weapon_04" + v;
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendSkewer, function (_skill) {
			_skill.m.Icon = "skills/skewer_general.png";
			_skill.m.IconDisabled = "skills/skewer_general_bw.png";
			_skill.m.Overlay = "skewer_general";
		}.bindenv(this));	
	}

});
