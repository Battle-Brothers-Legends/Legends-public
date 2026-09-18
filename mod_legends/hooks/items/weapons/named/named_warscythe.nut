::mods_hookExactClass("items/weapons/named/named_warscythe", function (o) {

	local create = o.create;
	o.create = function () {
		create();
		this.m.Variants = [1, 2, 3];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.WeaponType = ::Const.Items.WeaponType.Cleaver | ::Const.Items.WeaponType.Polearm;
		this.setCategories("Cleaver/Polearm, Two-Handed");
	}

	o.addSkill <- function (_skill) {
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Strike)) {
			::Legends.Actives.grant(this, ::Legends.Active.Cleave, function (_skill) {
				_skill.m.IsScytheCleave = true;
			}.bindenv(this));
			return;
		}

		this.weapon.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate, function (_skill) {
			_skill.m.IsScytheDecapitate = true;
		}.bindenv(this));
	}
});
