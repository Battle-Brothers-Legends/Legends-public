::mods_hookExactClass("skills/actives/censer_castigate_skill", function (o) {
	o.getTooltip = function () {
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can hit up to 3 targets"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=%positive%]2" + "[/color] tiles"
		});

		if (!::Legends.S.isCharacterWeaponSpecialized(this.getContainer().getActor().getCurrentProperties(), this.getItem())) {
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%negative%]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}

		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Leaves a cloud of miasma on target tiles"
		});
		return ret;
	}

	o.onAfterUpdate = function (_properties) {
		if (::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem())) {
			this.m.ActionPointCost -= 1;
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
		}
	}

	o.onUse = function (_user, _targetTile) {
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectSwing);
		local ret = false;
		local myTile = _user.getTile();
		local d = myTile.getDistanceTo(_targetTile);
		local result = {
			Tiles = [],
			MyTile = myTile,
			TargetTile = _targetTile,
			Num = 0
		};
		::Tactical.queryTilesInRange(myTile, d, d, false, [], this.onQueryTilesHit, result);
		local tiles = [];

		for (local i = 0; i < result.Tiles.len(); i++) {
			if (result.Tiles[i].ID == _targetTile.ID) {
				tiles.push(result.Tiles[i]);
				local idx = i - 1;

				if (idx < 0) {
					idx = idx + result.Tiles.len();
				}

				tiles.push(result.Tiles[idx]);
				idx = i - 2;

				if (idx < 0) {
					idx = idx + result.Tiles.len();
				}

				tiles.push(result.Tiles[idx]);
				break;
			}
		}

		foreach (tile in tiles) {
			if (!tile.IsVisibleForEntity) {
				continue;
			}

			if (::Math.abs(tile.Level - myTile.Level) > 1 || ::Math.abs(tile.Level - _targetTile.Level) > 1) {
				continue;
			}

			if (!tile.IsEmpty && tile.getEntity().isAttackable()) {
				ret = this.attackEntity(_user, tile.getEntity()) || ret;
			}

			::Tactical.State.spawnMiasmaOnTile(tile, _user);

			if (::Legends.S.isEntityNullOrDead(_user)) {
				break;
			}
		}

		return ret;
	}

	o.onAnySkillUsed = function (_skill, _targetEntity, _properties) {
		if (_skill == this) {
			if (_targetEntity != null && !::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1) {
				_properties.MeleeSkill -= 15;
				this.m.HitChanceBonus -= 15;
			}
		}
	}
});
