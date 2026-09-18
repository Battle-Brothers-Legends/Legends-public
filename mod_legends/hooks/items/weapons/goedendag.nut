::mods_hookExactClass("items/weapons/goedendag", function (o) {

	local create = o.create;
	o.create = function () {
		create();
		this.setCategories("Spear/Mace, Two-Handed");
		this.m.Value = 750;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.DirectDamageMult = 0.4;
	}

	o.updateVariant <- function () {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/goedendag_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/goedendag_01" + v + ".png";
		this.m.ArmamentIcon = "icon_goedendag_01" + v;
	}

	o.addSkill <- function (_skill) {
		this.weapon.addSkill(_skill);
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Thrust)) {
			_skill.m.IsGoedendagThrust = true;
		}		
	}
});
