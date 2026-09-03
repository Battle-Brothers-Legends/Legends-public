this.legend_basilisk_sentry_fowleye_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	// - Fowleye: AoE stun based on resolve, has targeting like a warscythe
	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendBasiliskSentryFowleye);
		this.m.Description = "no look at birb";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/horror_spell", 3);
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false; //logic needed for below
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 4;
	}

	function isViableTarget(_user, _target) {
		if (_target.isAlliedWith(_user)) {
			return false;
		}

		if (_target.getMoraleState() == ::Const.MoraleState.Ignore || _target.getMoraleState() == ::Const.MoraleState.Fleeing || _target.getCurrentProperties().IsStunned) {
			return false;
		}

		return true;
	}

	function onUse(_user, _targetTile) {
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectSwing);
		local ret = false;
		local myTile = _user.getTile();
		local myTile = this.m.Container.getActor().getTile();
		local d = myTile.getDistanceTo(_targetTile);
		local result = {
			Tiles = [],
			MyTile = myTile,
			TargetTile = _targetTile,
			Num = 0
		};
		::Tactical.queryTilesInRange(myTile, d, d, false, [], this.onQueryTilesHit, result);
		local tiles = [];

		for (local i = 0; i != result.Tiles.len(); i = ++i) {
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

		foreach (t in tiles) {
			if (!t.IsVisibleForEntity) {
				continue;
			}

			if (::Math.abs(t.Level - myTile.Level) > 1 || ::Math.abs(t.Level - _targetTile.Level) > 1) {
				continue;
			}

			if (!t.IsEmpty && t.getEntity().isAttackable()) {
				ret = this.attackEntity(_user, t.getEntity()) || ret;
			}

			if (::Legends.S.isEntityNullOrDead(_user)) {
				break;
			}
		}

		return ret;
	}

	function onQueryTilesHit(_tile, _result) {
		_result.Tiles.push(_tile);
	}

	function onTargetSelected(_targetTile) {
		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local d = myTile.getDistanceTo(_targetTile);
		local result = {
			Tiles = [],
			MyTile = myTile,
			TargetTile = _targetTile,
			Num = 0
		};
		this.Tactical.queryTilesInRange(myTile, d, d, false, [], this.onQueryTilesHit, result);
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

		foreach (t in tiles) {
			if (!t.IsVisibleForEntity) {
				continue;
			}

			if (::Math.abs(t.Level - myTile.Level) > 1 || ::Math.abs(t.Level - _targetTile.Level) > 1) {
				continue;
			}

			::Tactical.getHighlighter().addOverlayIcon(::Const.Tactical.Settings.AreaOfEffectIcon, t, t.Pos.X, t.Pos.Y);
		}

		foreach (tile in tiles) {
			local target = tile.getEntity();
			local effect = ::Tactical.spawnSpriteEffect("effect_skull_03", this.createColor("#ffffff"), tile, 0, 40, 1.0, 0.25, 0, 400, 300);

			if (target.getCurrentProperties().MoraleCheckBraveryMult[::Const.MoraleCheckType.MentalAttack] >= 1000.0) {
				continue;
			}

			target.checkMorale(-1, -15, ::Const.MoraleCheckType.MentalAttack);

			if (!target.checkMorale(0, -5, ::Const.MoraleCheckType.MentalAttack)) {
				::Legends.Effects.grant(target, ::Legends.Effect.Horrified);

				if (!actor.isHiddenToPlayer() && !target.isHiddenToPlayer()) {
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(target) + " is horrified");
				}
			}
		}

		return true;
	}
});
