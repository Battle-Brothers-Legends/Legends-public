::mods_hookExactClass("ai/tactical/behaviors/ai_nightmare", function (o) {
	o.findBestTarget = function (_entity, _targets) {
		local myTile = _entity.getTile();
		local knownAllies = this.getAgent().getKnownAllies();
		local bestScore = 0.0;
		local bestTarget;
		local time = ::Time.getExactTime();

		foreach (opponent in _targets) {
			if (this.isAllottedTimeReached(time)) {
				yield null;
				time = ::Time.getExactTime();
			}

			local target = opponent.Actor;
			local opponentTile = opponent.Actor.getTile();

			if (!this.m.Skill.isUsableOn(opponentTile)) {
				continue;
			}

			local score = 30.0;
			local distanceToTarget = myTile.getDistanceTo(opponentTile);

			if (target.getMoraleState() == ::Const.MoraleState.Fleeing) {
				continue;
			}

			if (target.isArmedWithRangedWeapon() && distanceToTarget <= target.getIdealRange()) {
				score += ::Const.AI.Behavior.NightmareDangerOfRangedTarget;
			}

			score -= myTile.getDistanceTo(opponentTile) * ::Const.AI.Behavior.NightmareDistanceMult;
			local minDist = distanceToTarget;

			foreach (ally in knownAllies) {
				local d = ally.getTile().getDistanceTo(opponentTile);
				score += ::Math.max(0, 7 - d) * ::Const.AI.Behavior.NightmareAllyDistanceMult;

				if (d < minDist) {
					d = minDist;
				}
			}

			if (opponentTile.getZoneOfOccupationCount(opponent.Actor.getFaction()) == 0) {
				score += ::Const.AI.Behavior.NightmareIsolatedBonus;
			}

			foreach (target in _targets) {
				local helper = target.Actor;
				local dist = helper.getTile().getDistanceTo(opponentTile);

				if (dist >= 8 || ::Legends.S.isEntityMovementDisabled(helper) || helper.getTile().getZoneOfControlCountOtherThan(helper.getAlliedFactions()) > 1) {
					continue;
				}

				local turns = this.queryActorTurnsNearTarget(helper, opponentTile, _entity).Turns;

				if (turns <= 1.0) {
					score -= ::Const.AI.Behavior.NightmareHelperPenalty;
				}
			}

			if (opponentTile.hasZoneOfOccupationOtherThan(target.getAlliedFactions())) {
				score *= ::Const.AI.Behavior.NightmareEngagedMult;
			}

			local c = target.getCurrentProperties();
			score *= c.TargetAttractionMult * c.AggroMult;

			if (_entity.getAttackers().find(target.getID()) != null) {
				score *= ::Const.AI.Behavior.NightmareAttackingMeMult;
			}

			score *= this.queryTargetValue(_entity, target);

			if (score > bestScore) {
				bestScore = score;
				bestTarget = target;
			}
		}

		if (bestTarget != null) {
			this.m.TargetTile = bestTarget.getTile();
			this.m.ScoreBonus = bestScore * 0.1;
		}

		return true;
	}
});
