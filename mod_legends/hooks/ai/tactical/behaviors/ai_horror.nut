::mods_hookExactClass("ai/tactical/behaviors/ai_horror", function (o) {
	o.selectBestTarget = function (_myTile, _entity, _skill) {
		local bestScore = -9000.0;
		local bestTarget;
		local potentialTiles = [];
		local usedIDs = [];
		local opponents = this.getAgent().getKnownOpponents();

		foreach (opponent in opponents) {
			local opponentTile = opponent.Actor.getTile();

			if (_myTile.getDistanceTo(opponentTile) > _skill.getMaxRange() + 1) {
				continue;
			}

			if (usedIDs.find(opponentTile.ID) == null) {
				potentialTiles.push(opponentTile);
				usedIDs.push(opponentTile.ID);
			}

			local adjacentTiles = [0, 1, 2, 3, 4, 5];
			adjacentTiles.filter(@(_, _direction) opponentTile.hasNextTile(_direction)).map(@(_direction) opponentTile.getNextTile(_direction)).filter(@(_, _tile)((_myTile.getDistanceTo(opponentTile) <= _skill.getMaxRange() + 1) && usedIDs.find(opponentTile.ID) == null));
			foreach (adjacentTile in adjacentTiles) {
				potentialTiles.push(adjacentTile);
				usedIDs.push(adjacentTile.ID);
			}
		}

		if (potentialTiles.len() == 0) {
			return 0.0;
		}

		foreach (tile in potentialTiles.filter(@(_, _tile)(_skill.isInRange(_tile, _myTile) && _skill.onVerifyTarget(_myTile, _tile)))) {
			local targets = [];

			if (tile.IsOccupiedByActor) {
				targets.push(tile.getEntity());
			}

			local adjacentTargets = [0, 1, 2, 3, 4, 5];
			adjacentTargets.filter(@(_, _direction)(tile.hasNextTile(_direction) && tile.Properties.Effect == null && tile.getNextTile(_direction).IsOccupiedByActor)).map(@(_direction) tile.getNextTile(_direction).getEntity());
			targets.extend(adjacentTargets);

			if (targets.len() == 0) {
				continue;
			}

			local score = 0.0;
			local numAffected = 0;

			foreach (target in targets.filter(@(_, _target)(!_entity.isAlliedWith(_target) && target.getMoraleState() != ::Const.MoraleState.Ignore && target.getMoraleState() != ::Const.MoraleState.Fleeing))) {
				local targetTile = target.getTile();
				local target_score = this.m.Skill.getMaxRange() - _myTile.getDistanceTo(target.getTile());

				if (_myTile.getDistanceTo(targetTile) <= target.getIdealRange()) {
					target_score += ::Const.AI.Behavior.HorrorAttackingMeBonus;
				}

				target_score += ::Const.AI.Behavior.HorrorZOCBonus * targetTile.getZoneOfControlCountOtherThan(target.getAlliedFactions());

				if (target.getMoraleState() == ::Const.MoraleState.Breaking) {
					target_score += ::Const.AI.Behavior.HorrorAlmostFleeingBonus;
				}

				if (targetTile.Properties.Effect != null && !targetTile.Properties.Effect.IsPositive && targetTile.Properties.Effect.Applicable(target)) {
					target_score += ::Const.AI.Behavior.HorrorNegativeTileEffectBonus;
				}

				local c = target.getCurrentProperties();
				target_score *= (1.0 - ::Math.minf(1.0, c.getBravery() * 0.01));
				target_score *= (1.0 / c.MoraleCheckBraveryMult[::Const.MoraleCheckType.MentalAttack]);

				if (target.isTurnDone() && ::Legends.Effects.has(target, ::Legends.Effect.Adrenaline)) {
					target_score += ::Const.AI.Behavior.HorrorAdrenalineBonus;
				}

				target_score *= c.TargetAttractionMult * c.AggroMult;

				if (!target.isTurnDone()) {
					target_score *= ::Const.AI.Behavior.HorrorStillToActMult;
				}

				score += target_score;
				numAffected = ++numAffected;
			}

			if (numAffected > 1) {
				score *= ::Math.pow(::Const.AI.Behavior.RootNumAffectedPOW, numAffected - 1);
			}

			if (score > bestScore) {
				bestScore = score;
				bestTarget = tile;
			}
		}

		if (bestTarget != null) {
			this.m.TargetTile = bestTarget;
			this.m.TargetScore = bestScore;
			return ::Math.maxf(0.1, bestScore * 0.1);
		} else {
			return 0.0;
		}
	}
});
