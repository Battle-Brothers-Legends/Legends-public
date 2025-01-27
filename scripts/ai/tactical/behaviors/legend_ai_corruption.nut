this.legend_ai_corruption <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		TargetScore = 0,
		PossibleSkills = [
			::Legends.Actives.getID(::Legends.Active.LegendShadows)
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.Corruption;
		this.m.Order = this.Const.AI.Behavior.Order.Corruption;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		this.m.Skill = null;
		this.m.TargetTile = null;
		this.m.TargetScore = 0;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasKnownOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.Tactical.State.isAutoRetreat())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.Skill);
		local opponents = this.getAgent().getKnownOpponents();
		local func = this.findBestTarget(_entity, opponents);

		while (resume func == null)
		{
			yield null;
		}

		if (this.m.TargetTile == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		return this.Const.AI.Behavior.Score.Corruption * score + this.m.TargetScore;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(this.m.TargetTile);
			this.m.IsFirstExecuted = false;

			if (this.m.TargetTile.IsVisibleForPlayer && _entity.isHiddenToPlayer())
			{
				_entity.setDiscovered(true);
				_entity.getTile().addVisibilityForFaction(this.Const.Faction.Player);
			}

			return false;
		}

		this.m.Skill.use(this.m.TargetTile);

		if (!_entity.isHiddenToPlayer())
		{
			this.getAgent().declareAction();
		}

		this.m.Skill = null;
		this.m.TargetTile = null;
		return true;
	}

	function findBestTarget( _entity, _targets )
	{
		// Function is a generator.
		local myTile = _entity.getTile();
		local bestScore = -9000.0;
		local bestTarget;
		local knownAllies = this.getAgent().getKnownAllies();
		local time = this.Time.getExactTime();
		local targetValues = [];
		local possibleTiles = [
			myTile
		];
		local nearestOpponentDist = 9000;
		local advancedAI = !this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 100;

		foreach( o in _targets )
		{
			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			local opponentTile = o.Actor.getTile();
			local d = myTile.getDistanceTo(opponentTile);

			if (d < nearestOpponentDist)
			{
				nearestOpponentDist = d;
			}

			if (d < this.m.Skill.getMaxRange() + 2)
			{
				local t = {
					ID = o.Actor.getID(),
					Value = this.queryTargetValue(_entity, o.Actor, null)
				};
				targetValues.push(t);
			}

			if (d > this.m.Skill.getMaxRange() + 1)
			{
				continue;
			}

			if (this.m.Skill.isUsableOn(opponentTile))
			{
				possibleTiles.push(opponentTile);
			}

			for( local i = 0; i < 6; i = ++i )
			{
				if (!opponentTile.hasNextTile(i))
				{
				}
				else
				{
					local adjacentTile = opponentTile.getNextTile(i);

					if (!this.m.Skill.isUsableOn(adjacentTile))
					{
					}
					else
					{
						local alreadyIn = false;

						foreach( t in possibleTiles )
						{
							if (t.ID == adjacentTile.ID)
							{
								alreadyIn = true;
								break;
							}
						}

						if (!alreadyIn)
						{
							possibleTiles.push(adjacentTile);
						}
					}
				}
			}
		}

		foreach( tile in possibleTiles )
		{
			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			local score = 0.0;
			local redundantTiles = 0.0;
			local affectedTiles = [];
			local affectedTargets = 0;

			if (tile.ID == myTile.ID && nearestOpponentDist > 6)
			{
				continue;
			}

			score = score + (this.m.Skill.getMaxRange() - this.Math.max(1, myTile.getDistanceTo(tile)));

			for( local i = 0; i < 6; i = ++i )
			{
				if (!tile.hasNextTile(i))
				{
				}
				else
				{
					local adjacentTile = tile.getNextTile(i);

					if (!adjacentTile.IsEmpty)
					{
					}
					else
					{
						affectedTiles.push(adjacentTile);
					}
				}
			}

			if (tile.IsEmpty)
			{
				affectedTiles.push(tile);
			}
			else if (tile.IsOccupiedByActor && this.isKindOf(tile.getEntity(), "legend_alp_shadow") && tile.Properties.Effect.Timeout - this.Time.getRound() == 1)
			{
				affectedTiles.push(tile);
			}

			if (affectedTiles.len() == 0)
			{
				continue;
			}

			foreach( affectedTile in affectedTiles )
			{
				if (affectedTile.Properties.Effect != null)
				{
					if (affectedTile.Properties.Effect.Timeout - this.Time.getRound() >= 2)
					{
						redundantTiles = redundantTiles + 1.0;
						continue;
					}
					else if (affectedTile.Properties.Effect.Timeout - this.Time.getRound() == 1)
					{
						if (advancedAI && tile.IsOccupiedByActor && this.isKindOf(tile.getEntity(), "legend_alp_shadow"))
						{
							redundantTiles = redundantTiles + 0.25;
						}
						else
						{
							redundantTiles = redundantTiles + 0.5;
						}
					}
				}

				local targets = [];
				local helpScore = 0.0;

				for( local i = 0; i < 6; i = ++i )
				{
					if (!affectedTile.hasNextTile(i))
					{
					}
					else
					{
						local adjacentTile = affectedTile.getNextTile(i);

						if (!adjacentTile.IsOccupiedByActor)
						{
						}
						else if (this.Math.abs(affectedTile.Level - adjacentTile.Level) > 1)
						{
						}
						else
						{
							local entity = adjacentTile.getEntity();

							if (entity.isAlliedWith(_entity))
							{
								helpScore = helpScore + this.Const.AI.Behavior.CorruptionNearAllyBonus;
							}
							else
							{
								targets.push(entity);
							}
						}
					}
				}

				if (targets.len() > 0)
				{
					score = score + helpScore;
				}

				affectedTargets = affectedTargets + targets.len();

				foreach( target in targets )
				{
					local targetTile = target.getTile();
					local target_score = 5.0;
					target_score = target_score + (this.m.Skill.getMaxRange() - myTile.getDistanceTo(targetTile));

					if (myTile.getDistanceTo(targetTile) <= target.getIdealRange())
					{
						target_score = target_score + this.Const.AI.Behavior.CorruptionAttackingMeBonus;
					}

					target_score = target_score * (this.getTargetValue(target.getID(), targetValues) * this.Const.AI.Behavior.CorruptionTargetValueMult);

					if (target.isTurnDone())
					{
						target_score = target_score * this.Const.AI.Behavior.CorruptionTurnDoneMult;
					}

					score = score + target_score;
				}
			}

			if (redundantTiles >= 7.0)
			{
				continue;
			}

			if (redundantTiles >= 1.0)
			{
				score = score * this.Math.pow(this.Const.AI.Behavior.CorruptionRedundantPOW, redundantTiles);
			}

			if (affectedTargets > 1)
			{
				score = score * this.Math.pow(this.Const.AI.Behavior.CorruptionNumAffectedPOW, affectedTargets - 1);
			}

			if (score > bestScore)
			{
				bestScore = score;
				bestTarget = tile;
			}
		}

		if (bestTarget != null)
		{
			this.m.TargetTile = bestTarget;
			this.m.TargetScore = bestScore;
		}

		return true;
	}

	function getTargetValue( _id, _from )
	{
		foreach( t in _from )
		{
			if (_id == t.ID)
			{
				return t.Value;
			}
		}

		return 0.0;
	}

});

