::mods_hookExactClass("ai/tactical/behaviors/ai_attack_swing", function (o) {
	o.m.PossibleSkills.extend([
		::Legends.Actives.getID(::Legends.Active.LegendBearClaws),
		::Legends.Actives.getID(::Legends.Active.LegendDoubleSwing),
		::Legends.Actives.getID(::Legends.Active.LegendHarvest),
		::Legends.Actives.getID(::Legends.Active.LegendSkinGhoulClaws),
	]);

	o.getBestTarget = function (_entity, _skill, _targets) {
		local ourTile = _entity.getTile();
		local bestTarget;
		local bestScore = 0.0;
		local bestCombinedValue = 0.0;
		local tilesLeft = ("TilesLeft" in _skill.m) ? _skill.m.TilesLeft : 2;
		local tilesRight = ("TilesRight" in _skill.m) ? _skill.m.TilesRight : 0;

		foreach (target in _targets) {
			if (_skill.onVerifyTarget(ourTile, target.getTile())) {
				local score = 1.0;
				local combinedValue = this.queryTargetValue(_entity, target, _skill);
				local dir = ourTile.getDirectionTo(target.getTile());
				local directionsToCheck = [];
				for (local i = 1; i <= tilesLeft; i++) {
					directionsToCheck.push((dir - i + 6) % 6);
				}
				for (local i = 1; i <= tilesRight; i++) {
					directionsToCheck.push((dir + i) % 6);
				}

				foreach (d in directionsToCheck) {
					if (ourTile.hasNextTile(d)) {
						local tile = ourTile.getNextTile(d);

						if (this.Math.abs(tile.Level - ourTile.Level) <= 1 && tile.IsOccupiedByActor) {
							local targetEntity = tile.getEntity();
							if (targetEntity.isAlliedWith(_entity)) {
								combinedValue = combinedValue - (1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * targetEntity.getCurrentProperties().TargetAttractionMult;
							} else {
								combinedValue = combinedValue + this.queryTargetValue(_entity, targetEntity, _skill);
								score = score + 1.0;
							}
						}
					}
				}

				if (score < this.m.MinTargets) {
					continue;
				}

				if (score > bestScore || score == bestScore && combinedValue > bestCombinedValue) {
					bestTarget = target;
					bestCombinedValue = combinedValue;
					bestScore = score;
				}
			}
		}
		
		local score = this.Math.maxf(0.0, bestCombinedValue / 2.0);
		return {
			Target = bestTarget,
			Score = score
		};
	}
});
