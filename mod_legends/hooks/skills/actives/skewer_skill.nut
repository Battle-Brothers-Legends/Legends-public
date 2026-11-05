::mods_hookExactClass("skills/actives/skewer_skill", function (o) {
	o.onAfterUpdate = function (_properties) {
		if (::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem())) {
			this.m.ActionPointCost -= 1;
		}
		this.m.FatigueCostMult = ::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem()) ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}
});
