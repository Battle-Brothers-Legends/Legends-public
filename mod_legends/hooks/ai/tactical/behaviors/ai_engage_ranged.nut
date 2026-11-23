::mods_hookExactClass("ai/tactical/behaviors/ai_engage_ranged", function (o) {
	o.m.PossibleSkills.extend([
		::Legends.Actives.getID(::Legends.Active.LegendMagicMissile),
		::Legends.Actives.getID(::Legends.Active.LegendChainLightning),
		::Legends.Actives.getID(::Legends.Active.LegendCatapultBoulder),
		::Legends.Actives.getID(::Legends.Active.LegendSlingHeavyStone),
		::Legends.Actives.getID(::Legends.Active.LegendShootDart),
		::Legends.Actives.getID(::Legends.Active.LegendShootStone),
		::Legends.Actives.getID(::Legends.Active.LegendShootPreciseStone),
		::Legends.Actives.getID(::Legends.Active.LegendPiercingShot),
		::Legends.Actives.getID(::Legends.Active.LegendPiercingBolt),
		::Legends.Actives.getID(::Legends.Active.ThrowJavelin),
		::Legends.Actives.getID(::Legends.Active.ThrowAxe),
		::Legends.Actives.getID(::Legends.Active.ThrowSpear),
		::Legends.Actives.getID(::Legends.Active.LegendThrowKnife),
	]);

	o.compileTargets = function (_entity, _targets, _maxRange) {
		// Function is a generator.
		this.m.ValidTargets = [];
		this.m.PotentialDanger = [];
		this.m.CurrentDanger = 0.0;
		local myTile = _entity.getTile();
		local time = this.Time.getExactTime();

		foreach (target in _targets) {
			if (::Legends.S.isEntityNullOrDead(target.Actor) || !target.Actor.isPlacedOnMap()) {
				continue;
			}

			if (this.isAllottedTimeReached(time)) {
				yield null;
				time = this.Time.getExactTime();
			}

			local targetTile = target.Actor.getTile();
			local realDist = myTile.getDistanceTo(targetTile);

			if (realDist <= this.Const.AI.Behavior.RangedEngageMaxDangerDist
				&& target.Actor.getMoraleState() != this.Const.MoraleState.Fleeing
				&& !this.isRangedUnit(target.Actor)
				&& !target.Actor.isNonCombatant()
				&& target.Actor.getHitpoints() / target.Actor.getHitpointsMax() >= this.Const.AI.Behavior.RangedEngageMinDangerHitpointsPct
				&& targetTile.getZoneOfControlCountOtherThan(target.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones)
			{
				this.m.PotentialDanger.push(target.Actor);
				local danger = this.getDangerFromActor(target.Actor, myTile, _entity);
				this.m.CurrentDanger += danger;
			}

			local alliesAdjacent = 0;
			local opponentsAdjacent = 0;
			local score = this.queryTargetValue(_entity, target.Actor, null);

			for (local i = 0; i < this.Const.Direction.COUNT; i = ++i) {
				if (!targetTile.hasNextTile(i)) {
				} else {
					local tile = targetTile.getNextTile(i);

					if (tile.IsEmpty) {
					} else if (tile.IsOccupiedByActor) {
						if (tile.getEntity().isAlliedWith(_entity)) {
							if (this.getProperties().TargetPriorityHittingAlliesMult < 1.0) {
								score = score - 1.0 / 6.0 * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * tile.getEntity().getCurrentProperties().TargetAttractionMult;
							}

							alliesAdjacent = ++alliesAdjacent;
						} else {
							score = score + 1.0 / 6.0 * this.queryTargetValue(_entity, tile.getEntity(), null) * this.Const.AI.Behavior.AttackRangedHitBystandersMult;
							opponentsAdjacent = ++opponentsAdjacent;
						}
					}
				}
			}

			if (targetTile.getZoneOfControlCount(_entity.getFaction()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) {
				score = score * (1.0 + (1.0 - this.Math.minf(1.0, this.queryActorTurnsNearTarget(target.Actor, myTile, _entity).Turns)) * this.Const.AI.Behavior.AttackDangerMult);
			}

			this.m.ValidTargets.push({
				Actor = target.Actor,
				Tile = targetTile,
				Distance = realDist,
				IsRangedUnit = this.isRangedUnit(target.Actor),
				Score = this.Math.maxf(0.01, score),
				OpponentsAdjacent = opponentsAdjacent,
				AlliesAdjacent = alliesAdjacent
			});
		}

		return true;
	}
});
