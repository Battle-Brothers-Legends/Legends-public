::mods_hookExactClass("skills/actives/split_axe", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.IsTargetingActor = false;
	}

	o.onUse = function (_user, _targetTile) {
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectSplit);

		local ret = false;
		if (::Legends.S.isEntityNullOrDead(_user)) {
			return ret;
		}

		local ownTile = _user.getTile();
		if (_targetTile.IsOccupiedByActor && _targetTile.getEntity().isAttackable() && this.Math.abs(_targetTile.Level - ownTile.Level) <= 1) {
			ret = this.attackEntity(_user, _targetTile.getEntity());
		}

		local dir = ownTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir)) {
			local forwardTile = _targetTile.getNextTile(dir);

			if (forwardTile.IsOccupiedByActor && forwardTile.getEntity().isAttackable() && this.Math.abs(forwardTile.Level - ownTile.Level) <= 1) {
				ret = this.attackEntity(_user, forwardTile.getEntity()) || ret;
			}
		}

		return ret;
	}
});
