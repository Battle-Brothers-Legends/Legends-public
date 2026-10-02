::mods_hookExactClass("skills/actives/censer_strike", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 13;
		this.m.BlockBypass = 0.25;
	}

	o.onAfterUpdate = function (_properties) {
		if (::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem())) {
			this.m.ActionPointCost -= 1;
			this.m.FatigueCostMult = ::Const.Combat.WeaponSpecFatigueMult;
			this.m.BlockBypass += 0.25;
		}
	}

	o.onUse = function (_user, _targetTile) {
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, _targetTile.getEntity());
		::Tactical.State.spawnMiasmaOnTile(_targetTile, _user);
		return success;
	}
});
