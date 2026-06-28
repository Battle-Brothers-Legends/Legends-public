::mods_hookExactClass("skills/racial/schrat_racial", function(o) {
	o.m.SpawnSchratling <- true;
	o.onBeforeDamageReceived = function(_attacker, _skill, _hitInfo, _properties) {
		if (_skill == null)
			return;

		switch (_hitInfo.DamageType) {
			case this.Const.Damage.DamageType.Piercing:
				if (_skill == null) {
					_properties.DamageReceivedRegularMult *= 0.25;
				} else {
					if (_skill.isRanged()) {
						local weapon = _skill.getItem();
						if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.Weapon)) {
							if (weapon.isWeaponType(this.Const.Items.WeaponType.Bow) || weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow)) {
								_properties.DamageReceivedRegularMult *= 0.25;
							} else if (weapon.isWeaponType(this.Const.Items.WeaponType.Throwing)) {
								_properties.DamageReceivedRegularMult *= 0.5;
							} else {
								_properties.DamageReceivedRegularMult *= 0.5;
							}
						} else {
							_properties.DamageReceivedRegularMult *= 0.2;
						}
					}
				}
				break;

			case this.Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 1.33;
				break;
		}
	}

	o.onDamageReceived = function(_attacker, _damageHitpoints, _damageArmor) {
		if (!this.m.SpawnSchratling)
			return;

		local actor = this.getContainer().getActor();
		if (_damageHitpoints < actor.getHitpointsMax() * 0.1)
			return;

		local candidates = [];
		local myTile = actor.getTile();

		for (local i = 0; i < 6; i = ++i) {
			if (!myTile.hasNextTile(i))
				continue;
			local nextTile = myTile.getNextTile(i);
			if (nextTile.IsEmpty && ::Math.abs(myTile.Level - nextTile.Level) <= 1) {
				candidates.push(nextTile);
			}
		}

		if (candidates.len() != 0) {
			local spawnTile = candidates[::Math.rand(0, candidates.len() - 1)];
			local sapling = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/schrat_small", spawnTile.Coords);
			sapling.setFaction((actor.getFaction() == this.Const.Faction.Player ? this.Const.Faction.PlayerAnimals : actor.getFaction()));
			sapling.riseFromGround();
		}
	}
});
