::mods_hookExactClass("skills/actives/perforate_skill", function (o) {
	o.onAfterUpdate = function (_properties) {
		if (::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem())) {
			this.m.ActionPointCost -= 1;
		}
		this.m.FatigueCostMult = ::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}
});
