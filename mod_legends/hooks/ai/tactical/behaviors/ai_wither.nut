::mods_hookExactClass("ai/tactical/behaviors/ai_wither", function (o) {

	o.findBestTarget = function (_entity, _targets) {
		local knownAllies = this.getAgent().getKnownAllies();
		local bestTarget;
		local bestScore = 0.0;
		local masterTile = this.getAgent().getActor().getTile();

		foreach (opponent in _targets) {
			local target = opponent.Actor;
			local opponentTile = opponent.Actor.getTile();

			if (!this.m.Skill.isUsableOn(opponentTile) || target.getMoraleState() == ::Const.MoraleState.Fleeing) {
				continue;
			}

			local c = target.getCurrentProperties();
			local score = 0.0 + c.getMeleeDefense() + c.getRangedDefense() + c.getMeleeSkill() + c.getRangedSkill();

			foreach (ally in knownAllies) {
				local d = ally.getTile().getDistanceTo(opponentTile);
				score += ::Math.max(0, 5 - d) * ::Const.AI.Behavior.WitherAllyDistanceMult;
			}

			local withered = ::Legends.Effects.get(target, ::Legends.Effect.Withered);
			if (withered != null) {
				if (withered.m.TurnsLeft >= 2) {
					continue;
				} else if (::Legends.Effects.new(::Legends.Effect.Withered).m.TurnsLeft + c.NegativeStatusEffectDuration >= 2) {
					score *= ::Const.AI.Behavior.WitherAlreadyAppliedMult;
				}
			}

			if (opponentTile.hasZoneOfOccupationOtherThan(target.getAlliedFactions())) {
				score *= ::Math.pow(::Const.AI.Behavior.WitherEngagedPOW, opponentTile.getZoneOfOccupationCountOtherThan(target.getAlliedFactions()));
			}

			if (masterTile != null && opponentTile.getDistanceTo(masterTile) <= 2) {
				score *= ::Const.AI.Behavior.WitherNearMasterMult;
			}

			score *= c.TargetAttractionMult * c.AggroMult;

			if (score > bestScore) {
				bestTarget = target;
				bestScore = score;
			}
		}

		return {
			Target = bestTarget,
			Score = bestScore * 0.01
		};
	}
});
