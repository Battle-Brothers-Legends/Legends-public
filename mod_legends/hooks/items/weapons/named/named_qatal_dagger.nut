::mods_hookExactClass("items/weapons/named/named_qatal_dagger", function (o) {

	local create = o.create;
	o.create = function () {
		create();
		this.m.Variants = [1, 2];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendGut);
	}

	o.addSkill <- function (_skill) {
		this.weapon.addSkill(_skill);
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Deathblow)) {

			_skill.m.DeathblowBonus = true;

		}

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Stab)) {
			_skill.m.IsQatalStab = true;
		}
	}
});
