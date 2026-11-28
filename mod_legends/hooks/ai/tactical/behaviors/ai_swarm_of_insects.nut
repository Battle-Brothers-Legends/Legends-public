::mods_hookExactClass("ai/tactical/behaviors/ai_swarm_of_insects", function (o) {
	o.findBestTarget = function (_entity, _targets) {
		local myTile = _entity.getTile();
		local knownAllies = this.getAgent().getKnownAllies();
		local bestScore = 30.0;
		local bestTarget;

		foreach (opponent in _targets) {
			local target = opponent.Actor;
			local opponentTile = opponent.Actor.getTile();

			if (!this.m.Skill.isUsableOn(opponentTile)) {
				continue;
			}

			local distanceToTarget = myTile.getDistanceTo(opponentTile);

			local c = target.getCurrentProperties();
			if (!c.IsRooted && !target.isArmedWithRangedWeapon() && this.queryActorTurnsNearTarget(target, myTile, _entity).Turns <= 1.0 || target.getMoraleState() == ::Const.MoraleState.Fleeing) {
				continue;
			}

			local score = 1.0 + c.getMeleeDefense() + c.getRangedDefense() + c.getMeleeSkill() + c.getRangedSkill();

			if (target.isArmedWithRangedWeapon() && distanceToTarget <= target.getIdealRange()) {
				score += ::Const.AI.Behavior.InsectSwarmDangerOfRangedTarget;
			}

			score -= myTile.getDistanceTo(opponentTile) * ::Const.AI.Behavior.InsectSwarmDistanceMult;
			local minDist = distanceToTarget;

			foreach (ally in knownAllies) {
				local d = ally.getTile().getDistanceTo(opponentTile);
				score += ::Math.max(0, 7 - d) * ::Const.AI.Behavior.InsectSwarmAllyDistanceMult;

				if (d < minDist) {
					d = minDist;
				}
			}

			if (this.getStrategy().getStats().RangedAlliedVSEnemies <= 1.0 && !target.isArmedWithRangedWeapon() && minDist > 4) {
				continue;
			}

			if (::Legends.Effects.has(target, ::Legends.Effect.InsectSwarm)) {
				if (c.NegativeStatusEffectDuration >= 0) {
					score *= ::Const.AI.Behavior.InsectSwarmAlreadyAppliedMult;
				}
			}

			if (opponentTile.hasZoneOfOccupationOtherThan(target.getAlliedFactions())) {
				score *= ::Const.AI.Behavior.InsectSwarmEngagedMult;
			}

			score *= c.TargetAttractionMult * c.AggroMult;

			if (_entity.getAttackers().find(target.getID()) != null) {
				score *= ::Const.AI.Behavior.InsectSwarmAttackingMeMult;
			}

			if (score > bestScore) {
				bestScore = score;
				bestTarget = target;
			}
		}

		return {
			Target = bestTarget,
			Score = bestScore * 0.1
		};
	}
});
