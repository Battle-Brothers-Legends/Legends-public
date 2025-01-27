::mods_hookExactClass("ai/tactical/behaviors/ai_engage_melee", function(o)
{
	// todo, renamed because it doesn't work properly, hangs battle... - chopeks
	o.onEvaluate2 <- function ( _entity )
	{
		// Function is a generator.
		local score = 1.0;
		this.m.OriginTile = null;
		this.m.TargetTile = null;
		this.m.TargetActor = null;
		this.m.TargetDistance = 0;
		this.m.IsIgnoringZOC = _entity.getCurrentProperties().IsImmuneToZoneOfControl;
		this.m.IsWaitingBeforeMove = false;
		local time = this.Time.getExactTime();

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.m.IsDoneThisTurn && _entity.getActionPoints() < _entity.getActionPointsMax())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getCurrentProperties().IsRooted)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.getAgent().getIntentions().IsDefendingPosition || this.getAgent().getIntentions().IsRecuperating)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getFaction() != this.Const.Faction.PlayerAnimals && this.getStrategy().isDefending())
		{
			if (this.getStrategy().isEscortedByPlayer() || !_entity.isArmedWithRangedWeapon() || this.getStrategy().isDefendingCamp() && this.getStrategy().getStats().ShortestDistanceToEnemy >= 5)
			{
				return this.Const.AI.Behavior.Score.Zero;
			}
		}

		if (!this.getAgent().hasKnownOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getStrategy().getStats().IsEngaged && _entity.getIdealRange() == 2 && !this.getProperties().IgnoreTargetValueOnEngage && _entity.isAbleToWait() && this.Tactical.TurnSequenceBar.isAllyStillToAct(_entity) && _entity.isArmedWithMeleeWeapon())
		{
			local allies = this.getAgent().getKnownAllies();
			local someoneStillToMove = false;

			foreach( ally in allies )
			{
				if (!ally.isTurnDone() && ally.isArmedWithMeleeWeapon() && ally.getIdealRange() == 1 && ally.getActionPoints() >= 4)
				{
					someoneStillToMove = true;
					break;
				}
			}

			if (someoneStillToMove)
			{
				this.m.IsWaitingBeforeMove = true;
				return this.Const.AI.Behavior.Score.Engage * score;
			}
		}

		if (!this.getStrategy().getStats().IsEngaged && this.getStrategy().isDelayedAttack() && _entity.isAbleToWait() && this.Tactical.TurnSequenceBar.isOpponentStillToAct(_entity))
		{
			this.m.IsWaitingBeforeMove = true;
			return this.Const.AI.Behavior.Score.Engage * score;
		}

		local myTile = _entity.getTile();
		local targetsInMelee = this.queryTargetsInMeleeRange(this.getProperties().EngageRangeMin, this.Math.max(_entity.getIdealRange(), this.getProperties().EngageRangeMax));
		local AlreadyEngagedWithNum = targetsInMelee.len();
		local inZonesOfControl = myTile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions());
		local knownAllies = this.getAgent().getKnownAllies();
		local attackSkill = _entity.getSkills().getAttackOfOpportunity();
		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null && _entity.getActionPointCostsRaw() == this.Const.ImmobileMovementAPCost)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (inZonesOfControl > 2 && (this.m.Skill == null || !this.m.Skill.isDisengagement()))
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (inZonesOfControl != 0 && _entity.isArmedWithRangedWeapon())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (targetsInMelee.len() > 0 && this.getProperties().EngageWhenAlreadyEngagedMult == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (inZonesOfControl != 0 && targetsInMelee.len() > 0)
		{
			if (this.m.Skill != null && this.m.Skill.isDisengagement())
			{
				score = score * this.Math.pow(this.Const.AI.Behavior.EngageWithSkillToDisengagePOW, inZonesOfControl);
			}
			else
			{
				local accumulatedAOO = 0;

				for( local i = 0; i < 6; i = ++i )
				{
					if (!myTile.hasNextTile(i))
					{
					}
					else
					{
						local nextTile = myTile.getNextTile(i);

						if (!nextTile.IsOccupiedByActor)
						{
						}
						else
						{
							local e = nextTile.getEntity();

							if (e.isExertingZoneOfControl() && this.Math.abs(nextTile.Level - myTile.Level) <= 1 && !e.isAlliedWith(_entity))
							{
								local aooSkill = e.getSkills().getAttackOfOpportunity();

								if (aooSkill != null)
								{
									accumulatedAOO = accumulatedAOO + aooSkill.getHitchance(_entity);
								}
							}
						}
					}
				}

				local hasKnockBack = _entity.getSkills().hasActive(::Legends.Active.KnockBack);
				local hasFootwork = _entity.getSkills().hasActive(::Legends.Active.Footwork);
				score = score * this.Math.maxf(0.0, 1.0 - accumulatedAOO * 0.01 * (1.0 / this.getProperties().EngageWhenAlreadyEngagedMult) * (hasKnockBack ? 2.0 : 1.0) * (hasFootwork ? 2.0 : 1.0));
			}

			if (score <= 0)
			{
				return this.Const.AI.Behavior.Score.Zero;
			}
		}
		else if (AlreadyEngagedWithNum != 0)
		{
			score = score * this.Math.pow(this.Const.AI.Behavior.EngageWhenAlreadyInRangeMult, targetsInMelee.len());
		}

		local targets = this.getAgent().getKnownOpponents();
		local potentialDestinations = [];
		local bestValue = 0;
		local bestTarget;

		foreach( target in targetsInMelee )
		{
			local v = this.queryTargetValue(_entity, target);

			if (v > bestValue)
			{
				bestValue = v;
				bestTarget = target;
			}
		}

		if (_entity.getIdealRange() == 2 && _entity.isArmedWithMeleeWeapon() && this.getProperties().PreferCarefulEngage && !this.getProperties().IgnoreTargetValueOnEngage && !this.getStrategy().getStats().IsEngaged && bestTarget == null)
		{
			foreach( a in knownAllies )
			{
				if (this.isRangedUnit(a) || a.getIdealRange() == 2 || a.getID() == _entity.getID())
				{
					continue;
				}

				if (this.isAllottedTimeReached(time))
				{
					yield null;
					time = this.Time.getExactTime();
				}

				local allyTile = a.getTile();
				local potentialTiles = [];

				for( local i = 0; i < 6; i = ++i )
				{
					if (!allyTile.hasNextTile(i))
					{
					}
					else
					{
						local tile = allyTile.getNextTile(i);

						if (!tile.IsEmpty || this.Math.abs(allyTile.Level - tile.Level) > 1)
						{
						}
						else
						{
							potentialTiles.push(tile);
						}
					}
				}

				foreach( tile in potentialTiles )
				{
					local distance = tile.getDistanceTo(myTile);
					local scoreBonus = 0;
					local tileScore = -distance * this.Const.AI.Behavior.EngageDistancePenaltyMult * (1.0 + this.Math.maxf(0.0, 1.0 - _entity.getActionPointsMax() / 9.0)) * (1.0 / this.getProperties().EngageFlankingMult);
					local scoreMult = 1.0;
					local dirs = [
						0,
						0,
						0,
						0,
						0,
						0
					];
					local numOpponentsInRange = 0;

					foreach( opponent in targets )
					{
						if (opponent.Actor.getMoraleState() == this.Const.MoraleState.Fleeing || opponent.Tile.hasZoneOfControlOtherThan(opponent.Actor.getAlliedFactions()) || opponent.Tile.getDistanceTo(tile) > 8)
						{
							continue;
						}

						numOpponentsInRange = ++numOpponentsInRange;
						local dir = tile.getDirection8To(opponent.Tile);
						local mult = 2.0 / tile.getDistanceTo(opponent.Tile);

						switch(dir)
						{
						case this.Const.Direction8.W:
							dirs[this.Const.Direction.NW] += 4 * mult;
							dirs[this.Const.Direction.SW] += 4 * mult;
							break;

						case this.Const.Direction8.E:
							dirs[this.Const.Direction.NE] += 4 * mult;
							dirs[this.Const.Direction.SE] += 4 * mult;
							break;

						default:
							local dir = tile.getDirectionTo(opponent.Tile);
							local dir_left = dir - 1 >= 0 ? dir - 1 : 6 - 1;
							local dir_right = dir + 1 < 6 ? dir + 1 : 0;
							dirs[dir] += 4 * mult;
							dirs[dir_left] += 3 * mult;
							dirs[dir_right] += 3 * mult;
							break;
						}
					}

					if (numOpponentsInRange != 0)
					{
						for( local i = 0; i < 6; i = ++i )
						{
							if (!tile.hasNextTile(i))
							{
							}
							else
							{
								local adjacentTile = tile.getNextTile(i);

								if (adjacentTile.IsEmpty)
								{
								}
								else
								{
									local ally = adjacentTile.getEntity();
									local mult = 1.0;

									if (ally.isActor() && ally.getIdealRange() > 1)
									{
										mult = mult * 0.5;
									}

									if (dirs[i] >= 8 && ally.getID() != _entity.getID() && (!adjacentTile.IsOccupiedByActor || ally.getIdealRange() == 1))
									{
										tileScore = tileScore + dirs[i] / numOpponentsInRange * this.Const.AI.Behavior.EngageCoverWithReachWeaponMult * mult;
										scoreBonus = scoreBonus + dirs[i] / numOpponentsInRange * this.Const.AI.Behavior.EngageCoverWithReachWeaponMult * mult;
									}
								}
							}
						}
					}

					if (tile.IsBadTerrain)
					{
						tileScore = tileScore - this.Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
						scoreBonus = scoreBonus - this.Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
					}

					if (this.hasNegativeTileEffect(tile, _entity) || tile.Properties.IsMarkedForImpact)
					{
						tileScore = tileScore - this.Const.AI.Behavior.EngageBadTerrainEffectPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
						scoreBonus = scoreBonus - this.Const.AI.Behavior.EngageBadTerrainEffectPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
					}

					local zocs = tile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions());

					if (zocs > 0)
					{
						tileScore = tileScore - zocs * this.Const.AI.Behavior.EngageMultipleOpponentsPenalty * this.getProperties().EngageTargetMultipleOpponentsMult;
						scoreBonus = scoreBonus - zocs * this.Const.AI.Behavior.EngageMultipleOpponentsPenalty * this.getProperties().EngageTargetMultipleOpponentsMult;

						if (zocs > 1 && this.getProperties().EngageTargetMultipleOpponentsMult != 0.0)
						{
							scoreMult = scoreMult * this.Math.pow(1.0 / (this.Const.AI.Behavior.EngageTargetMultipleOpponentsMult * this.getProperties().EngageTargetMultipleOpponentsMult), zocs);
						}

						tileScore = tileScore - zocs * this.Const.AI.Behavior.EngageIntoZocWithReachWeaponPenalty;
						scoreBonus = scoreBonus - zocs * this.Const.AI.Behavior.EngageIntoZocWithReachWeaponPenalty;
					}

					potentialDestinations.push({
						Tile = tile,
						IsSkillUsable = false,
						Actor = null,
						LevelDifference = 0,
						IsTargetLocked = false,
						IsTargetLockable = false,
						TargetValue = 1.0,
						LockDownMult = 1.0,
						ScoreBonus = scoreBonus,
						TileScore = tileScore,
						ScoreMult = scoreMult,
						Distance = distance,
						DistanceFromTarget = 0
					});
				}
			}
		}

		if (potentialDestinations.len() == 0)
		{
			foreach( t in targets )
			{
				if (t.Actor.isNull())
				{
					continue;
				}

				if (this.m.Skill != null && _entity.getActionPointCostsRaw() == this.Const.ImmobileMovementAPCost && t.Actor.getTile().getDistanceTo(myTile) > this.m.Skill.getMaxRange() + 1)
				{
					continue;
				}

				local targetTile = t.Actor.getTile();
				local isTargetInEnemyZoneOfControl = targetTile.hasZoneOfControlOtherThan(t.Actor.getAlliedFactions());
				local isTargetArmedWithRangedWeapon = !isTargetInEnemyZoneOfControl && this.isRangedUnit(t.Actor);
				local isTargetFleeing = t.Actor.getMoraleState() == this.Const.MoraleState.Fleeing;
				local engagementsDeclared = (t.Actor.getAIAgent().getEngagementsDeclared(_entity) + t.Actor.getTile().getZoneOfControlCount(_entity.getFaction()) * 2) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult * this.getProperties().EngageTargetAlreadyBeingEngagedMult;
				local letOthersGoScore = 0.0;
				local targetValue = this.getProperties().IgnoreTargetValueOnEngage ? 0.5 : this.queryTargetValue(_entity, t.Actor);
				local lockDownValue = 1.0;

				if (targetTile.getZoneOfControlCount(_entity.getFaction()) == 0 && !isTargetArmedWithRangedWeapon && !isTargetFleeing && engagementsDeclared == 0)
				{
					foreach( ally in knownAllies )
					{
						if (ally.getCurrentProperties().TargetAttractionMult <= 1.0 && !this.isRangedUnit(ally))
						{
							continue;
						}

						local d = this.queryActorTurnsNearTarget(t.Actor, ally.getTile(), t.Actor);

						if (d.Turns <= 1.0)
						{
							lockDownValue = lockDownValue * (this.Const.AI.Behavior.EngageMeleeProtectPriorityTargetMult * this.getProperties().EngageLockDownTargetMult);
						}
					}
				}

				if (this.getProperties().IgnoreTargetValueOnEngage)
				{
					letOthersGoScore = letOthersGoScore + this.Math.abs(myTile.SquareCoords.Y - targetTile.SquareCoords.Y) * 20.0;
					local myDistanceToTarget = myTile.getDistanceTo(targetTile);
					local targets = this.getAgent().getKnownAllies();

					foreach( ally in targets )
					{
						if (ally.getMoraleState() == this.Const.MoraleState.Fleeing || ally.getCurrentProperties().RangedSkill > ally.getCurrentProperties().MeleeSkill || ally.getTile().hasZoneOfControlOtherThan(ally.getAlliedFactions()))
						{
							continue;
						}

						if (ally.getTile().getDistanceTo(targetTile) < myDistanceToTarget)
						{
							letOthersGoScore = letOthersGoScore + 2.0;
						}
					}
				}
				else
				{
					local myDistanceToTarget = myTile.getDistanceTo(targetTile);
					local targets = this.getAgent().getKnownAllies();

					foreach( ally in targets )
					{
						if (ally.getMoraleState() == this.Const.MoraleState.Fleeing || ally.getCurrentProperties().RangedSkill > ally.getCurrentProperties().MeleeSkill || ally.getTile().hasZoneOfControlOtherThan(ally.getAlliedFactions()))
						{
							continue;
						}

						if (ally.getTile().getDistanceTo(targetTile) < myDistanceToTarget)
						{
							letOthersGoScore = letOthersGoScore + 0.5;
						}
					}
				}

				local potentialTiles = this.queryDestinationsInRange(targetTile, this.getProperties().EngageRangeMin, this.Math.max(this.getProperties().EngageRangeMax, this.getProperties().EngageRangeIdeal));

				foreach( tile in potentialTiles )
				{
					if (this.isAllottedTimeReached(time))
					{
						yield null;
						time = this.Time.getExactTime();
					}

					if (tile.isSameTileAs(myTile) || tile.Type == this.Const.Tactical.TerrainType.Impassable)
					{
						continue;
					}

					if (attackSkill != null && !attackSkill.onVerifyTarget(tile, targetTile))
					{
						continue;
					}

					if (this.getStrategy().isDefending() && this.getStrategy().isDefendingCamp() && this.getStrategy().getStats().ShortestDistanceToEnemy >= 5)
					{
						local d = t.Tile.getDistanceTo(this.centerTile);

						if (d > this.Const.Tactical.Settings.CampRadius + this.Tactical.State.getStrategicProperties().LocationTemplate.AdditionalRadius + 1 || !_entity.isArmedWithShield() && d > this.Const.Tactical.Settings.CampRadius + this.Tactical.State.getStrategicProperties().LocationTemplate.AdditionalRadius)
						{
							continue;
						}
					}

					local levelDifference = tile.Level - targetTile.Level;
					local distance = tile.getDistanceTo(myTile);
					local distanceFromTarget = tile.getDistanceTo(targetTile);
					local zocs = tile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions());
					local tileScore = -distance * this.Const.AI.Behavior.EngageDistancePenaltyMult * (1.0 + this.Math.maxf(0.0, 1.0 - _entity.getActionPointsMax() / 9.0)) * (1.0 / this.getProperties().EngageFlankingMult) - letOthersGoScore;
					local scoreBonus = 0 - letOthersGoScore;
					local scoreMult = 1.0;
					local isSkillUsable = false;

					if (this.m.Skill == null && AlreadyEngagedWithNum != 0 || this.m.Skill != null && inZonesOfControl != 0)
					{
						if (tile.Level < myTile.Level || tile.IsBadTerrain && !myTile.IsBadTerrain)
						{
							continue;
						}

						for( ; tile.getDistanceTo(myTile) > 4;  )
						{
						}

						for( ; zocs > inZonesOfControl;  )
						{
						}

						if (t.Actor.getID() == bestTarget.getID() && tile.Level <= myTile.Level && tile.IsBadTerrain == myTile.IsBadTerrain && this.hasNegativeTileEffect(tile, _entity) == this.hasNegativeTileEffect(myTile, _entity) && (this.m.Skill == null || !this.m.Skill.isDisengagement()))
						{
							continue;
						}

						if (bestTarget != null && tile.Level <= myTile.Level && tile.IsBadTerrain == myTile.IsBadTerrain && this.hasNegativeTileEffect(tile, _entity) == this.hasNegativeTileEffect(myTile, _entity) && t.Actor.getID() != bestTarget.getID() && targetValue < bestValue * this.Const.AI.Behavior.EngageBestValueMult)
						{
							continue;
						}
					}

					tileScore = tileScore + targetValue * this.Const.AI.Behavior.EngageTargetValueMult;
					scoreBonus = scoreBonus + targetValue * this.Const.AI.Behavior.EngageTargetValueMult;

					if (this.m.Skill != null && distanceFromTarget == 1 && this.m.Skill.isUsableOn(tile))
					{
						isSkillUsable = true;
						tileScore = tileScore + this.Const.AI.Behavior.EngageWithSkillBonus;
					}
					else if (this.m.Skill != null && _entity.getActionPointCostsRaw() == this.Const.ImmobileMovementAPCost)
					{
						continue;
					}
					else if (inZonesOfControl > 0 && this.m.Skill != null && this.m.Skill.isDisengagement())
					{
						isSkillUsable = true;
						tileScore = tileScore + this.Const.AI.Behavior.EngageWithSkillBonus;
					}
					else if (this.m.Skill != null && distanceFromTarget > 1)
					{
						local canEngage = false;

						for( local i = 0; i != 6; i = ++i )
						{
							if (!tile.hasNextTile(i))
							{
							}
							else if (this.m.Skill.isUsableOn(tile.getNextTile(i), tile))
							{
								canEngage = true;
								tileScore = tileScore + this.Const.AI.Behavior.EngageWithSkillNextTimeBonus;
								break;
							}
						}

						if (!canEngage)
						{
							tileScore = tileScore - this.Const.AI.Behavior.EngageWithSkillBonus;
						}
					}

					if (!isSkillUsable && distanceFromTarget != this.getProperties().EngageRangeIdeal)
					{
						tileScore = tileScore - this.Math.abs(distanceFromTarget - this.getProperties().EngageRangeIdeal) * this.Const.AI.Behavior.EngageNotIdealRangePenalty;
						scoreBonus = scoreBonus - this.Math.abs(distanceFromTarget - this.getProperties().EngageRangeIdeal) * this.Const.AI.Behavior.EngageNotIdealRangePenalty;
					}

					if (engagementsDeclared != 0)
					{
						tileScore = tileScore - engagementsDeclared;
						scoreBonus = scoreBonus - engagementsDeclared;
					}

					if ((this.m.Skill != null || distanceFromTarget == 1) && !isTargetInEnemyZoneOfControl)
					{
						scoreMult = scoreMult * (this.Const.AI.Behavior.EngageLockdownMult * lockDownValue);
						scoreBonus = scoreBonus + this.Const.AI.Behavior.EngageLockOpponentBonus * lockDownValue;
					}

					tileScore = tileScore + levelDifference * this.Const.AI.Behavior.EngageTerrainLevelBonus * this.getProperties().EngageOnGoodTerrainBonusMult;
					tileScore = tileScore + tile.TVTotal * this.Const.AI.Behavior.EngageTVValueMult * this.getProperties().EngageOnGoodTerrainBonusMult;
					scoreBonus = scoreBonus + (levelDifference * this.Const.AI.Behavior.EngageTerrainLevelBonus + tile.TVTotal * this.Const.AI.Behavior.EngageTVValueMult) * this.getProperties().EngageOnGoodTerrainBonusMult;

					if (zocs > 0)
					{
						tileScore = tileScore - zocs * this.Const.AI.Behavior.EngageMultipleOpponentsPenalty * this.getProperties().EngageTargetMultipleOpponentsMult;
						scoreBonus = scoreBonus - zocs * this.Const.AI.Behavior.EngageMultipleOpponentsPenalty * this.getProperties().EngageTargetMultipleOpponentsMult;

						if (zocs > 1 && this.getProperties().EngageTargetMultipleOpponentsMult != 0.0)
						{
							scoreMult = scoreMult * this.Math.pow(1.0 / (this.Const.AI.Behavior.EngageTargetMultipleOpponentsMult * this.getProperties().EngageTargetMultipleOpponentsMult), zocs);
						}

						if (_entity.getIdealRange() > 1)
						{
							tileScore = tileScore - zocs * this.Const.AI.Behavior.EngageIntoZocWithReachWeaponPenalty;
							scoreBonus = scoreBonus - zocs * this.Const.AI.Behavior.EngageIntoZocWithReachWeaponPenalty;
						}
					}

					local spearwallMult = this.querySpearwallValueForTile(_entity, tile);

					if (this.m.Skill == null || this.m.Skill.isSpearwallRelevant())
					{
						tileScore = tileScore - this.Const.AI.Behavior.EngageSpearwallTargetPenalty * spearwallMult;
						scoreBonus = scoreBonus - this.Const.AI.Behavior.EngageSpearwallTargetPenalty * spearwallMult;
					}

					if (this.getProperties().EngageEnemiesInLinePreference > 1)
					{
						for( local d = 0; d < 6; d = ++d )
						{
							if (!tile.hasNextTile(d))
							{
							}
							else
							{
								local nextTile = tile.getNextTile(d);

								for( local k = 0; k < this.getProperties().EngageEnemiesInLinePreference - 1; k = ++k )
								{
									if (!nextTile.hasNextTile(d))
									{
										break;
									}

									nextTile = nextTile.getNextTile(d);

									if (nextTile.IsOccupiedByActor && nextTile.getEntity().isAttackable() && !nextTile.getEntity().isAlliedWith(_entity))
									{
										local v = this.queryTargetValue(_entity, nextTile.getEntity());
										tileScore = tileScore + v * this.Const.AI.Behavior.EngageLineTargetValueMult * this.getProperties().TargetPriorityAoEMult;
										scoreBonus = scoreBonus + v * this.Const.AI.Behavior.EngageLineTargetValueMult * this.getProperties().TargetPriorityAoEMult;
									}
								}
							}
						}
					}

					if (tile.IsBadTerrain)
					{
						local mult = isTargetArmedWithRangedWeapon ? 0.5 : 1.0;
						tileScore = tileScore - this.Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult * mult;
						scoreBonus = scoreBonus - this.Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult * mult;
					}

					if (this.hasNegativeTileEffect(tile, _entity) || tile.Properties.IsMarkedForImpact)
					{
						tileScore = tileScore - this.Const.AI.Behavior.EngageBadTerrainEffectPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
						scoreBonus = scoreBonus - this.Const.AI.Behavior.EngageBadTerrainEffectPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
					}

					if (this.getProperties().OverallFormationMult != 0)
					{
						local allies = this.queryAllyMagnitude(tile, this.Const.AI.Behavior.EngageAllyFormationMaxDistance);
						local formationValue = 0.0;

						if (allies.Allies != 0)
						{
							formationValue = this.Math.pow(allies.Allies * allies.AverageDistanceScore * (allies.Magnetism / allies.Allies) * this.getProperties().OverallFormationMult * 0.5, this.getProperties().OverallFormationMult * 0.5) * this.Const.AI.Behavior.EngageFormationBonus;
						}

						tileScore = tileScore + formationValue;
						scoreBonus = scoreBonus + formationValue;
					}

					if (_entity.getIdealRange() > 1 && _entity.isArmedWithMeleeWeapon())
					{
						local dirs = [
							0,
							0,
							0,
							0,
							0,
							0
						];
						local numOpponentsInRange = 0;

						foreach( opponent in targets )
						{
							if (opponent.Actor.getMoraleState() == this.Const.MoraleState.Fleeing || opponent.Tile.hasZoneOfControlOtherThan(opponent.Actor.getAlliedFactions()) || opponent.Tile.getDistanceTo(tile) > 8)
							{
								continue;
							}

							numOpponentsInRange = ++numOpponentsInRange;
							local dir = tile.getDirection8To(opponent.Tile);
							local mult = 2.0 / tile.getDistanceTo(opponent.Tile);

							switch(dir)
							{
							case this.Const.Direction8.W:
								dirs[this.Const.Direction.NW] += 4 * mult;
								dirs[this.Const.Direction.SW] += 4 * mult;
								break;

							case this.Const.Direction8.E:
								dirs[this.Const.Direction.NE] += 4 * mult;
								dirs[this.Const.Direction.SE] += 4 * mult;
								break;

							default:
								local dir = tile.getDirectionTo(opponent.Tile);
								local dir_left = dir - 1 >= 0 ? dir - 1 : 6 - 1;
								local dir_right = dir + 1 < 6 ? dir + 1 : 0;
								dirs[dir] += 4 * mult;
								dirs[dir_left] += 3 * mult;
								dirs[dir_right] += 3 * mult;
								break;
							}
						}

						if (numOpponentsInRange != 0)
						{
							for( local i = 0; i < 6; i = ++i )
							{
								if (!tile.hasNextTile(i))
								{
								}
								else
								{
									local adjacentTile = tile.getNextTile(i);

									if (adjacentTile.IsEmpty)
									{
									}
									else
									{
										local ally = adjacentTile.getEntity();

										if (dirs[i] >= 8 && ally.getID() != _entity.getID() && (!adjacentTile.IsOccupiedByActor || ally.getIdealRange() == 1))
										{
											tileScore = tileScore + dirs[i] / numOpponentsInRange * this.Const.AI.Behavior.EngageCoverWithReachWeaponMult;
											scoreBonus = scoreBonus + dirs[i] / numOpponentsInRange * this.Const.AI.Behavior.EngageCoverWithReachWeaponMult;
										}
									}
								}
							}
						}
					}

					potentialDestinations.push({
						Tile = tile,
						IsSkillUsable = isSkillUsable,
						Actor = t.Actor,
						LevelDifference = levelDifference,
						IsTargetLocked = isTargetInEnemyZoneOfControl,
						IsTargetLockable = distanceFromTarget == 1,
						TargetValue = targetValue,
						LockDownMult = distanceFromTarget == 1 ? lockDownValue : 1.0,
						ScoreBonus = scoreBonus,
						TileScore = tileScore,
						ScoreMult = scoreMult,
						Distance = distance,
						DistanceFromTarget = distanceFromTarget
					});
				}
			}
		}

		if (potentialDestinations.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		potentialDestinations.sort(this.onSortByScore);

		if (this.isAllottedTimeReached(time))
		{
			yield null;
			time = this.Time.getExactTime();
		}

		local hasShieldWall = _entity.getSkills().hasEffect(::Legends.Effect.Shieldwall);
		local canUseShieldWall = !hasShieldWall && _entity.getSkills().hasActive(::Legends.Active.Shieldwall);
		local hasAdrenaline = _entity.getSkills().hasActive(::Legends.Active.Adrenaline);
		local bestTarget;
		local bestIntermediateTile;
		local bestTargetDistance = 0;
		local actorTargeted;
		local bestCost = -9999;
		local bestTiles = 0;
		local bestScoreMult = 1.0;
		local bestAP = 0;
		local bestLocked = false;
		local bestLockable = false;
		local bestWaitAfterMove = false;
		local bestWithSkill = false;
		local bestComplete = false;
		local bestWaitBeforeMove = false;
		local bestAttackAfterMove = false;
		local n = 0;
		local attackSkill = _entity.getSkills().getAttackOfOpportunity();
		local apRequiredForAttack = attackSkill != null ? attackSkill.getActionPointCost() : 4;
		local navigator = this.Tactical.getNavigator();

		if (potentialDestinations[0].IsSkillUsable && (!this.m.Skill.isDisengagement() || potentialDestinations[0].Distance == 1))
		{
			bestWithSkill = true;
			bestTarget = potentialDestinations[0].Tile;
			bestTargetDistance = 0;
			bestTiles = 1;
			bestAP = this.m.Skill.getActionPointCost();
			bestWaitAfterMove = false;
			bestIntermediateTile = null;
			bestLocked = potentialDestinations[0].IsTargetLocked;
			bestLockable = potentialDestinations[0].IsTargetLockable;
			bestScoreMult = potentialDestinations[0].ScoreMult;
			bestComplete = true;
			actorTargeted = potentialDestinations[0].Actor;
		}
		else
		{
			local entityActionPointCosts = _entity.getActionPointCosts();
			local entityFatiguePointCosts = _entity.getFatigueCosts();
			local hasRangedWeapon = _entity.hasRangedWeapon();

			foreach( t in potentialDestinations )
			{
				n = ++n;

				if (n > this.Const.AI.Behavior.EngageMaxAttempts && bestTarget != null)
				{
					break;
				}

				if (this.isAllottedTimeReached(time))
				{
					yield null;
					time = this.Time.getExactTime();
				}

				local acceptableDistanceFromDest = 0;
				local destinationScore = t.ScoreBonus;
				local localScoreMult = 1.0;
				local tiles = 0;
				local intermediateTile = t.Tile;
				local waitAfterMove = false;
				local apCost = 0;
				local useSkill = false;
				local isComplete = false;
				local waitBeforeMove = false;
				local attackAfterMove = false;
				local settings = navigator.createSettings();
				settings.ActionPointCosts = entityActionPointCosts;
				settings.FatigueCosts = entityFatiguePointCosts;
				settings.FatigueCostFactor = 0.0;
				settings.ActionPointCostPerLevel = _entity.getLevelActionPointCost();
				settings.FatigueCostPerLevel = _entity.getLevelFatigueCost();
				settings.MaxLevelDifference = _entity.getMaxTraversibleLevels();
				settings.AllowZoneOfControlPassing = this.m.IsIgnoringZOC;
				settings.ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
				settings.AlliedFactions = _entity.getAlliedFactions();
				settings.Faction = _entity.getFaction();
				settings.HiddenCost = this.getProperties().OverallHideMult >= 1 ? -1 : 0;
				settings.HeatCost = this.getAgent().isUsingHeat() && t.Distance >= this.Const.AI.Behavior.EngageMinHeatDistance && this.getProperties().EngageFlankingMult > 1.0 ? this.Const.AI.Behavior.EngageHeatCost * this.getProperties().EngageHeatCostMult : 0;

				if (navigator.findPath(myTile, t.Tile, settings, acceptableDistanceFromDest))
				{
					local movementCosts = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());

					if (movementCosts.Tiles == 0 || movementCosts.End.ID == myTile.ID)
					{
						continue;
					}

					destinationScore = destinationScore - movementCosts.ActionPointsRequired * (1.0 + this.Math.maxf(0.0, 1.0 - _entity.getActionPointsMax() / 9.0)) * (1.0 / this.getProperties().EngageFlankingMult);

					if (this.getProperties().EngageTileLimit != 0 && navigator.NumPathWaypoints > this.getProperties().EngageTileLimit && !this.getStrategy().getStats().IsEngaged)
					{
						local intoFormation = false;
						intoFormation = movementCosts.End.hasNextTile(this.Const.Direction.S) && movementCosts.End.getNextTile(this.Const.Direction.S).IsOccupiedByActor && movementCosts.End.getNextTile(this.Const.Direction.S).getEntity().getFaction() == _entity.getFaction() && movementCosts.End.getNextTile(this.Const.Direction.S).hasNextTile(this.Const.Direction.S) && movementCosts.End.getNextTile(this.Const.Direction.S).getNextTile(this.Const.Direction.S).IsOccupiedByActor && movementCosts.End.getNextTile(this.Const.Direction.S).getNextTile(this.Const.Direction.S).getEntity().getFaction() == _entity.getFaction();
						intoFormation = intoFormation || movementCosts.End.hasNextTile(this.Const.Direction.N) && movementCosts.End.getNextTile(this.Const.Direction.N).IsOccupiedByActor && movementCosts.End.getNextTile(this.Const.Direction.N).getEntity().getFaction() == _entity.getFaction() && movementCosts.End.getNextTile(this.Const.Direction.N).hasNextTile(this.Const.Direction.N) && movementCosts.End.getNextTile(this.Const.Direction.N).getNextTile(this.Const.Direction.N).IsOccupiedByActor && movementCosts.End.getNextTile(this.Const.Direction.N).getNextTile(this.Const.Direction.N).getEntity().getFaction() == _entity.getFaction();

						if (!intoFormation)
						{
							navigator.clipPathToDistance(myTile, this.getProperties().EngageTileLimit);
							waitAfterMove = true;
							movementCosts = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
							movementCosts.IsComplete = false;
							intermediateTile = movementCosts.End;
						}
					}
					else if (this.getProperties().EngageTileLimit != 0 && movementCosts.IsComplete && this.getProperties().DontEngage)
					{
						navigator.clipPathToDistance(myTile, this.getProperties().EngageTileLimit - 1);
						waitAfterMove = true;
						movementCosts = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
						movementCosts.IsComplete = false;
						intermediateTile = movementCosts.End;
					}

					if (AlreadyEngagedWithNum != 0 && !movementCosts.IsComplete)
					{
						continue;
					}

					if (this.getProperties().PreferCarefulEngage && !this.Tactical.State.isAutoRetreat() && (hasAdrenaline || _entity.getTurnOrderInitiative() >= 125) && _entity.isAbleToWait() && !this.getStrategy().getStats().IsEngaged && !movementCosts.IsComplete && movementCosts.End.getDistanceTo(t.Tile) == 1 && movementCosts.Tiles > 1 && movementCosts.LastBeforeEnd.IsEmpty)
					{
						navigator.clipPathToDistance(myTile, myTile.getDistanceTo(movementCosts.End) - 1);
						waitAfterMove = true;
						movementCosts = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
						movementCosts.IsComplete = false;
						intermediateTile = movementCosts.End;
					}

					apCost = movementCosts.ActionPointsRequired;

					if (movementCosts.IsComplete && acceptableDistanceFromDest == 0 && !t.IsTargetLocked && t.IsTargetLockable && !t.Actor.getCurrentProperties().IsImmuneToZoneOfControl && t.LevelDifference >= 0 && (!t.Tile.IsBadTerrain || t.Actor.getTile().IsBadTerrain))
					{
						destinationScore = destinationScore + this.Const.AI.Behavior.EngageLockOpponentBonus * this.getProperties().EngageLockDownTargetMult * t.LockDownMult;
					}

					if (_entity.getActionPoints() - movementCosts.ActionPointsRequired >= apRequiredForAttack)
					{
						destinationScore = destinationScore + this.Const.AI.Behavior.EngageReachAndAttackBonus;
						attackAfterMove = true;
					}

					local willRunIntoSpearwall = this.querySpearwallValueForTile(_entity, movementCosts.End) != 0;
					local willRunIntoNegativeTileEffect = this.hasNegativeTileEffect(movementCosts.End, _entity);
					local currentlyAtNegativeTileEffect = this.hasNegativeTileEffect(myTile, _entity);

					if (inZonesOfControl > 0 && t.IsSkillUsable && this.m.Skill != null && this.m.Skill.isDisengagement())
					{
						if (this.m.Skill.isUsableOn(movementCosts.First))
						{
							useSkill = true;
							intermediateTile = movementCosts.First;
						}
						else
						{
							for( ; inZonesOfControl > 1;  )
							{
							}
						}
					}
					else if ((this.m.Skill == null || this.m.Skill.isSpearwallRelevant()) && (canUseShieldWall || hasRangedWeapon) && _entity.getActionPoints() < movementCosts.ActionPointsRequired + 4 && willRunIntoSpearwall && this.getProperties().EngageAgainstSpearwallMult != 0.0)
					{
						if (movementCosts.LastBeforeEnd.IsEmpty)
						{
							intermediateTile = movementCosts.LastBeforeEnd;
							waitAfterMove = true;
						}
						else if (_entity.isAbleToWait())
						{
							intermediateTile = myTile;
							waitAfterMove = true;
						}
					}
					else if (movementCosts.IsComplete && this.getProperties().EngageRangeMax == 1 && (this.getProperties().PreferCarefulEngage && !this.Tactical.State.isAutoRetreat()) && !this.getStrategy().getStats().IsBeingKited && !this.getProperties().IgnoreTargetValueOnEngage && (!useSkill || !this.m.Skill.isAttack()) && _entity.getActionPointsMax() >= 8 && _entity.getActionPoints() - movementCosts.ActionPointsRequired < apRequiredForAttack && !t.Actor.isTurnDone() && t.Actor.getActionPoints() >= 6 && t.Actor.getIdealRange() < 2 && (hasAdrenaline || _entity.getTurnOrderInitiative() * t.Actor.getCurrentProperties().InitiativeAfterWaitMult > t.Actor.getTurnOrderInitiative()) && !t.IsTargetLocked && t.TargetValue <= 1.0 && t.LockDownMult < this.Const.AI.Behavior.EngageMeleeProtectPriorityTargetMult * this.getProperties().EngageLockDownTargetMult && _entity.isAbleToWait() && inZonesOfControl == 0)
					{
						waitBeforeMove = true;
					}
					else if (movementCosts.IsComplete && this.getProperties().EngageRangeMax == 1 && this.getStrategy().getStats().EnemyRangedReadyRatio <= this.getStrategy().getStats().AllyRangedReadyRatio + 0.5 && !this.getStrategy().getStats().IsBeingKited && (this.getProperties().PreferCarefulEngage && !this.Tactical.State.isAutoRetreat()) && !this.getProperties().IgnoreTargetValueOnEngage && (!useSkill || !this.m.Skill.isAttack()) && _entity.getActionPointsMax() >= 8 && _entity.getActionPoints() - movementCosts.ActionPointsRequired < apRequiredForAttack && (!willRunIntoSpearwall || useSkill && !this.m.Skill.isSpearwallRelevant()) && (!currentlyAtNegativeTileEffect || willRunIntoNegativeTileEffect) && !t.IsTargetLocked && t.TargetValue <= 1.0 && t.LockDownMult < this.Const.AI.Behavior.EngageMeleeProtectPriorityTargetMult * this.getProperties().EngageLockDownTargetMult && !this.isEngageRecommended(_entity, t.Tile))
					{
						local alternative;
						local nextToLastAlternative;

						for( local i = 0; i < 6; i = ++i )
						{
							if (!movementCosts.LastBeforeEnd.hasNextTile(i))
							{
							}
							else
							{
								local h = movementCosts.LastBeforeEnd.getNextTile(i);

								if (!h.IsEmpty)
								{
								}
								else if (h.getDistanceTo(movementCosts.End) > movementCosts.End.getDistanceTo(movementCosts.LastBeforeEnd))
								{
								}
								else if (entityActionPointCosts[h.Type] > entityActionPointCosts[movementCosts.End.Type])
								{
								}
								else if (h.hasZoneOfControlOtherThan(_entity.getAlliedFactions()))
								{
								}
								else if (h.IsEmpty && (nextToLastAlternative == null || h.TVLevelDisadvantage < nextToLastAlternative.TVLevelDisadvantage || nextToLastAlternative.IsBadTerrain && !h.IsBadTerrain || this.hasNegativeTileEffect(nextToLastAlternative, _entity) && !this.hasNegativeTileEffect(h, _entity)))
								{
									nextToLastAlternative = h;
								}
							}
						}

						if (movementCosts.Tiles == 1 && _entity.getActionPointsMax() - movementCosts.ActionPointsRequired >= apRequiredForAttack)
						{
							alternative = myTile;
						}
						else if (movementCosts.LastBeforeEnd.IsEmpty && movementCosts.Tiles > 1 && movementCosts.LastBeforeEnd.ID != movementCosts.End.ID)
						{
							alternative = movementCosts.LastBeforeEnd;
						}
						else if (nextToLastAlternative != null)
						{
							alternative = nextToLastAlternative;
						}
						else if (movementCosts.Tiles == 2 && !movementCosts.LastBeforeEnd.IsEmpty && _entity.getActionPointsMax() - movementCosts.ActionPointsRequired >= apRequiredForAttack)
						{
							alternative = myTile;
						}
						else if (movementCosts.SecondLastBeforeEnd.IsEmpty && !movementCosts.LastBeforeEnd.IsEmpty && movementCosts.Tiles > 2 && _entity.getActionPointsMax() - (entityActionPointCosts[movementCosts.End.Type] + entityActionPointCosts[movementCosts.LastBeforeEnd.Type]) >= apRequiredForAttack)
						{
							alternative = movementCosts.SecondLastBeforeEnd;
						}

						if (alternative != null && alternative.ID == myTile.ID)
						{
							intermediateTile = myTile;
						}
						else if (alternative != null && alternative.ID != myTile.ID && (!alternative.IsBadTerrain || t.Tile.IsBadTerrain) && alternative.Level >= t.Tile.Level && (!this.hasNegativeTileEffect(alternative, _entity) || this.hasNegativeTileEffect(t.Tile, _entity)))
						{
							if (navigator.findPath(myTile, alternative, settings, 0))
							{
								intermediateTile = alternative;
								waitAfterMove = true;
							}
						}
					}
					else if (this.getProperties().EngageRangeIdeal > 1 && t.DistanceFromTarget < this.getProperties().EngageRangeIdeal && movementCosts.IsComplete && this.getProperties().PreferCarefulEngage && _entity.getActionPointsMax() >= 8 && !willRunIntoSpearwall)
					{
						local alternative;

						if (movementCosts.SecondLastBeforeEnd.IsEmpty && movementCosts.LastBeforeEnd.IsOccupiedByActor && movementCosts.Tiles > 2 && !movementCosts.LastBeforeEnd.hasZoneOfControlOtherThan(movementCosts.LastBeforeEnd.getEntity().getAlliedFactions()) && !movementCosts.LastBeforeEnd.getEntity().getCurrentProperties().IsRooted)
						{
							alternative = movementCosts.SecondLastBeforeEnd;
						}

						if (alternative != null && t.TargetValue <= 0.9 && (!alternative.IsBadTerrain || t.Tile.IsBadTerrain) && (!this.hasNegativeTileEffect(alternative, _entity) || this.hasNegativeTileEffect(t.Tile, _entity)))
						{
							intermediateTile = alternative;
							waitAfterMove = true;
						}
					}
					else if (!movementCosts.IsComplete && !this.getProperties().IgnoreTargetValueOnEngage && movementCosts.End.IsEmpty)
					{
						intermediateTile = movementCosts.End;

						if (this.getProperties().EngageOnBadTerrainPenaltyMult != 0.0 && !movementCosts.End.isSameTileAs(movementCosts.LastBeforeEnd) && !movementCosts.LastBeforeEnd.isSameTileAs(myTile))
						{
							local actualDanger = this.hasNegativeTileEffect(movementCosts.End, _entity);

							if (!actualDanger)
							{
								for( local i = 0; i < 6; i = ++i )
								{
									if (!movementCosts.End.hasNextTile(i))
									{
									}
									else
									{
										local h = movementCosts.End.getNextTile(i);

										if (h.IsEmpty && (h.Level > movementCosts.End.Level || movementCosts.End.IsBadTerrain && !h.IsBadTerrain))
										{
											actualDanger = true;
											break;
										}
									}
								}
							}

							if (actualDanger)
							{
								local alternateDest = movementCosts.End;
								local fallBackToLastBeforeEnd = false;

								if (movementCosts.LastBeforeEnd.IsEmpty && (movementCosts.End.TVLevelDisadvantage > movementCosts.LastBeforeEnd.TVLevelDisadvantage || movementCosts.End.IsBadTerrain && !movementCosts.LastBeforeEnd.IsBadTerrain || this.hasNegativeTileEffect(movementCosts.End, _entity) && !this.hasNegativeTileEffect(movementCosts.LastBeforeEnd, _entity)))
								{
									alternateDest = movementCosts.LastBeforeEnd;
									fallBackToLastBeforeEnd = true;
								}

								for( local i = 0; i < 6; i = ++i )
								{
									if (!movementCosts.LastBeforeEnd.hasNextTile(i))
									{
									}
									else
									{
										local h = movementCosts.LastBeforeEnd.getNextTile(i);

										if (!h.IsEmpty)
										{
										}
										else if (h.getDistanceTo(movementCosts.End) > movementCosts.End.getDistanceTo(movementCosts.LastBeforeEnd))
										{
										}
										else if (h.hasZoneOfControlOtherThan(_entity.getAlliedFactions()))
										{
										}
										else if (h.IsEmpty && h.TVLevelDisadvantage < alternateDest.TVLevelDisadvantage || alternateDest.IsBadTerrain && !h.IsBadTerrain || this.hasNegativeTileEffect(alternateDest, _entity) && !this.hasNegativeTileEffect(h, _entity))
										{
											alternateDest = h;
										}
									}
								}

								if (navigator.findPath(myTile, alternateDest, settings, 0))
								{
									intermediateTile = alternateDest;
									destinationScore = destinationScore + this.Const.AI.Behavior.EngageAvoidDisadvantageBonus;
									waitAfterMove = true;
								}
								else if (fallBackToLastBeforeEnd)
								{
									intermediateTile = movementCosts.LastBeforeEnd;
									destinationScore = destinationScore + this.Const.AI.Behavior.EngageAvoidDisadvantageBonus;
									waitAfterMove = true;
								}
							}
						}

						if (this.getProperties().EngageOnBadTerrainPenaltyMult != 0.0)
						{
							destinationScore = destinationScore - this.Const.AI.Behavior.EngageLevelDisadvantagePenalty * intermediateTile.TVLevelDisadvantage;

							if (movementCosts.LastBeforeEnd.TVLevelDisadvantage > 0)
							{
								localScoreMult = localScoreMult * this.Math.pow(this.Const.AI.Behavior.EngageLevelDisadvantageMult, intermediateTile.TVLevelDisadvantage);
							}

							if (intermediateTile.IsBadTerrain)
							{
								destinationScore = destinationScore - this.Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
							}

							if (this.hasNegativeTileEffect(intermediateTile, _entity))
							{
								destinationScore = destinationScore - this.Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
							}
						}
					}

					tiles = movementCosts.Tiles;
					isComplete = intermediateTile.ID == t.Tile.ID;
				}
				else
				{
					continue;
				}

				if (intermediateTile.IsHidingEntity)
				{
					destinationScore = destinationScore + this.Const.AI.Behavior.EngageEndTurnHiddenBonus * this.getProperties().OverallHideMult;
				}

				if (destinationScore > bestCost)
				{
					bestCost = destinationScore;
					bestTarget = intermediateTile;
					bestTargetDistance = 0;
					bestWaitAfterMove = waitAfterMove || t.Actor == null;
					bestTiles = tiles;
					bestIntermediateTile = useSkill || t.Tile.isSameTileAs(intermediateTile) ? null : intermediateTile;
					bestLocked = t.IsTargetLocked;
					bestLockable = t.IsTargetLockable;
					bestScoreMult = t.ScoreMult * localScoreMult;
					bestAP = apCost;
					bestWithSkill = useSkill;
					bestComplete = isComplete;
					bestWaitBeforeMove = waitBeforeMove;
					bestAttackAfterMove = attackAfterMove;
					actorTargeted = t.Actor;
				}
			}
		}

		if (this.isAllottedTimeReached(time))
		{
			yield null;
			time = this.Time.getExactTime();
		}

		if (bestTarget != null && bestTiles != 0 && bestTarget.ID != myTile.ID)
		{
			if (this.m.IsEngagedThisTurn && !bestComplete)
			{
				return this.Const.AI.Behavior.Score.Zero;
			}

			if ((this.m.Skill == null || this.m.Skill.isSpearwallRelevant()) && this.getProperties().PreferCarefulEngage && this.getProperties().EngageAgainstSpearwallMult != 0.0 && !hasShieldWall && !canUseShieldWall && _entity.isAbleToWait() && this.querySpearwallValueForTile(_entity, bestTarget) != 0.0)
			{
				local allies = this.getAgent().getKnownAllies();

				foreach( ally in allies )
				{
					if (ally.isTurnDone())
					{
						continue;
					}

					if (ally.getMoraleState() == this.Const.MoraleState.Fleeing || ally.getCurrentProperties().IsRooted || ally.getCurrentProperties().IsStunned)
					{
						continue;
					}

					if (ally.getTile().hasZoneOfControlOtherThan(ally.getAlliedFactions()))
					{
						continue;
					}

					if (ally.getTile().getDistanceTo(bestTarget) > 5)
					{
						continue;
					}

					if (ally.isArmedWithShield())
					{
						return this.Const.AI.Behavior.Score.Zero;
					}
				}
			}

			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			this.m.TargetTile = bestTarget;
			this.m.TargetActor = actorTargeted;
			this.m.TargetDistance = bestTargetDistance;
			this.m.IsWaitingAfterMove = bestWaitAfterMove;
			this.m.IsWaitingBeforeMove = bestWaitBeforeMove;

			if (!this.getProperties().IgnoreTargetValueOnEngage && bestComplete && actorTargeted != null)
			{
				score = score * (1.0 + this.queryTargetValue(_entity, actorTargeted));
			}

			if (bestWaitBeforeMove)
			{
				this.logInfo("Waiting before move!");
			}

			score = score * bestScoreMult;
			this.getAgent().getIntentions().Target = actorTargeted;
			this.getAgent().getIntentions().TargetTile = bestTarget;
			this.getAgent().getIntentions().IntermediateTargetTile = bestIntermediateTile;
			this.getAgent().getIntentions().APToReachTarget = bestAP;

			if (actorTargeted != null)
			{
				local actorTile = actorTargeted.getTile();

				if (bestWithSkill)
				{
					score = score * this.Const.AI.Behavior.EngageWithSkillMult;
				}
				else
				{
					this.m.Skill = null;
				}

				if (bestAttackAfterMove)
				{
					score = score * this.Const.AI.Behavior.EngageAndAttackMult;
				}

				if (this.getProperties().EngageOnGoodTerrainBonusMult != 0.0)
				{
					if (bestTarget.Level - actorTile.Level > 0)
					{
						score = score * this.Const.AI.Behavior.EngageOnLevelDifferenceMult;
					}
					else if (bestTarget.Level - actorTile.Level < 0)
					{
						score = score * (1.0 / this.Const.AI.Behavior.EngageOnLevelDifferenceMult);
					}

					if (!bestLocked && bestLockable && bestTarget.Level - myTile.Level < 0)
					{
						score = score * (1.0 / this.Const.AI.Behavior.EngageOnLevelDifferenceMult);
					}
					else if (!bestLocked && bestLockable && bestTarget.Level - myTile.Level > 0)
					{
						score = score * this.Const.AI.Behavior.EngageOnLevelDifferenceMult;
					}

					if (bestIntermediateTile != null)
					{
						if (bestIntermediateTile.Level - actorTargeted.getTile().Level > 0)
						{
							score = score * this.Const.AI.Behavior.EngageOnLevelDifferenceMult;
						}
						else if (bestIntermediateTile.Level - actorTargeted.getTile().Level < 0)
						{
							score = score * (1.0 / this.Const.AI.Behavior.EngageOnLevelDifferenceMult);
						}
					}
				}

				if (this.getProperties().EngageOnBadTerrainPenaltyMult != 0.0)
				{
					if (bestTarget.IsBadTerrain)
					{
						score = score * this.Const.AI.Behavior.EngageOnBadTerrainMult;
					}

					if (bestIntermediateTile != null && bestTarget.IsBadTerrain)
					{
						score = score * this.Const.AI.Behavior.EngageOnBadTerrainMult;
					}

					if (!myTile.IsBadTerrain && (bestTarget.IsBadTerrain || bestIntermediateTile != null && bestIntermediateTile.IsBadTerrain))
					{
						score = score * this.Const.AI.Behavior.EngageOnBadTerrainMult;
					}
				}

				if (this.getProperties().EngageOnGoodTerrainBonusMult != 0.0)
				{
					if (!this.m.TargetTile.IsBadTerrain && this.m.TargetActor.getTile().IsBadTerrain && bestIntermediateTile == null)
					{
						score = score * this.Const.AI.Behavior.EngageOnTerrainAdvantage;
					}

					if (myTile.IsBadTerrain && (!bestTarget.IsBadTerrain || bestIntermediateTile != null && !bestIntermediateTile.IsBadTerrain))
					{
						score = score * this.Const.AI.Behavior.EngageOnTerrainAdvantage;
					}
				}

				if (this.getProperties().EngageOnGoodTerrainBonusMult != 0.0)
				{
					if (this.hasNegativeTileEffect(myTile, _entity) && !this.hasNegativeTileEffect(this.m.TargetTile, _entity) || myTile.Properties.IsMarkedForImpact && !this.m.TargetTile.Properties.IsMarkedForImpact)
					{
						score = score * this.Const.AI.Behavior.EngageOnTerrainAdvantage;
					}
				}

				if (this.isAllottedTimeReached(time))
				{
					yield null;
					time = this.Time.getExactTime();
				}

				if (this.m.Skill == null || this.m.Skill.isSpearwallRelevant())
				{
					local spearwallMult = this.querySpearwallValueForTile(_entity, this.m.TargetTile);

					if (spearwallMult == 0.0 && bestIntermediateTile != null)
					{
						spearwallMult = this.querySpearwallValueForTile(_entity, bestIntermediateTile);
					}

					score = score * this.Math.maxf(0.1, 1.0 - spearwallMult * 0.5);
				}
			}

			if (AlreadyEngagedWithNum == 0)
			{
				local allyMag = this.queryAllyMagnitude(bestTarget, this.Const.AI.Behavior.EngageAllyOpponentToAllyDistance);
				local opponentMag = this.queryOpponentMagnitude(bestTarget, this.Const.AI.Behavior.EngageAllyOpponentToAllyDistance);
				local allyVSopponent = this.Math.maxf(1.0, allyMag.Allies * allyMag.AverageDistanceScore) / this.Math.maxf(1.0, opponentMag.Opponents * opponentMag.AverageDistanceScore);
				score = score * (1.0 - this.Const.AI.Behavior.EngageAllyVsOpponentMult + allyVSopponent * this.Const.AI.Behavior.EngageAllyVsOpponentMult);

				if (allyMag.Allies != 0)
				{
					score = this.Math.maxf(score, this.interpolate(score, allyMag.AverageEngaged, 0.5));
				}

				score = score * this.Math.maxf(1.0, this.Math.minf(this.Const.AI.Behavior.EngageInertiaMaxMult, this.m.Inertia * this.Const.AI.Behavior.EngageInertiaMult));
			}

			return this.Const.AI.Behavior.Score.Engage * score * this.getProperties().BehaviorMult[this.m.ID] * this.Math.minf(2.0, 1.0 / this.getProperties().OverallDefensivenessMult);
		}
		else if (AlreadyEngagedWithNum == 0 && bestTarget != null && bestTarget.ID == myTile.ID && bestWaitAfterMove && _entity.isAbleToWait() && (_entity.getActionPoints() >= 4 || _entity.getActionPoints() >= 2 && this.Tactical.TurnSequenceBar.isAllyStillToAct(_entity)))
		{
			this.m.IsWaitingBeforeMove = true;
			return this.Const.AI.Behavior.Score.Engage * score * this.getProperties().BehaviorMult[this.m.ID] * this.Math.minf(2.0, 1.0 / this.getProperties().OverallDefensivenessMult);
		}

		return this.Const.AI.Behavior.Score.Zero;
	}
});
