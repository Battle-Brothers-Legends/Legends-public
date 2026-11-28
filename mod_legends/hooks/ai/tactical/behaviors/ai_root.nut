::mods_hookExactClass("ai/tactical/behaviors/ai_root", function (o) {
	o.findBestTarget = function (_entity, _targets) {
		local myTile = _entity.getTile();
		local bestScore = 0.0;
		local bestTarget;
		local knownAllies = this.getAgent().getKnownAllies();
		local time = ::Time.getExactTime();

		foreach (opponent in _targets) {
			local opponentTile = opponent.Actor.getTile();

			if (myTile.getDistanceTo(opponentTile) > this.m.Skill.getMaxRange() || !this.m.Skill.isUsableOn(opponentTile)) {
				continue;
			}

			if (this.isAllottedTimeReached(time)) {
				yield null;
				time = ::Time.getExactTime();
			}

			local score = 0.0;
			local targets = [opponent.Actor];

			local adjacentTargets = [0, 1, 2, 3, 4, 5];
			adjacentTargets.filter(@(_, _direction)(opponentTile.hasNextTile(_direction))).map(@(_direction) opponentTile.getNextTile(_direction)).filter(@(_, _tile) (_tile.IsOccupiedByActor)).map(@(_tile) _tile.getEntity()).filter(@(_, _target)((!_target.getCurrentProperties().IsRooted && !_target.isAlliedWith(_entity))));
			targets.extend(adjacentTargets);

			local numAffected = 0;

			foreach (target in targets) {
				local c = target.getCurrentProperties();
				if (c.IsRooted || c.IsImmuneToRoot) {
					continue;
				}

				local target_score = this.m.Skill.getMaxRange() - myTile.getDistanceTo(opponentTile);

				if (target.getMoraleState() == ::Const.MoraleState.Fleeing) {
					target_score += ::Const.AI.Behavior.RootFleeingBonus;
				}

				if (!target.hasRangedWeapon()) {
					target_score += ::Const.AI.Behavior.RootNoRangedWeaponBonus;
				}

				if (!target.getTile().hasZoneOfControlOtherThan(target.getAlliedFactions())) {
					target_score += ::Const.AI.Behavior.RootNotEngagedBonus;

					if (this.queryActorTurnsNearTarget(target, myTile, _entity).Turns <= 1.0) {
						target_score += ::Const.AI.Behavior.RootDangerBonus;
					}

					local canHit = false;

					foreach (ally in knownAllies) {
						if (target.getTile().getDistanceTo(ally.getTile()) <= target.getIdealRange()) {
							canHit = true;
							break;
						}
					}

					if (!canHit) {
						target_score += ::Const.AI.Behavior.RootCantAttackAnyoneBonus;
					}

					if (!canHit && target.isTurnDone() && ::Legends.Effects.has(target, ::Legends.Effect.Adrenaline)) {
						target_score += ::Const.AI.Behavior.RootAdrenalineBonus;
					}
				}

				local targetTile = target.getTile();
				if (targetTile.IsBadTerrain) {
					target_score += ::Const.AI.Behavior.RootBadTerrain;
				}

				local targetTileEffect = targetTile.Properties.Effect;
				if (targetTileEffect != null && !targetTileEffect.IsPositive && targetTileEffect.Applicable(target)) {
					target_score += ::Const.AI.Behavior.RootBadTerrain;
				}

				target_score *= c.TargetAttractionMult * c.AggroMult;
				score += target_score;
				numAffected = ++numAffected;
			}

			if (numAffected > 1) {
				score *= ::Math.pow(::Const.AI.Behavior.RootNumAffectedPOW, numAffected - 1);
			}

			if (score > bestScore) {
				bestScore = score;
				bestTarget = opponent.Actor;
			}
		}

		if (bestTarget != null) {
			this.m.TargetTile = bestTarget.getTile();
			this.m.TargetScore = bestScore;
		}

		return true;
	}
});
