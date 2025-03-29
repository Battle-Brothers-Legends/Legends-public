this.legend_vala_warden_ai_ranged_attack <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		PossibleSkills = [
			::Legends.Actives.getID(::Legends.Active.LegendValaWardenWail)
		],
		SelectedSkill = null
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.AttackBow;
		this.m.Order = this.Const.AI.Behavior.Order.AttackBow;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.TargetTile = null;
		this.m.SelectedSkill = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasVisibleOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local skills = [];

		foreach( skillID in this.m.PossibleSkills )
		{
			local skill = _entity.getSkills().getSkillByID(skillID);

			if (skill != null && skill.isUsable() && skill.isAffordable())
			{
				skills.push(skill);
			}
		}

		if (skills.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local targets = this.getAgent().getKnownOpponents();
		score = score * this.selectBestTargetAndSkill(_entity, targets, skills);

		if (this.m.TargetTile == null || this.m.SelectedSkill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.SelectedSkill);

		return this.Const.AI.Behavior.Score.Attack * score;
	}

	function onBeforeExecute( _entity )
	{
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			if (this.m.TargetTile.getEntity().isPlayerControlled() && _entity.isHiddenToPlayer())
			{
				_entity.setDiscovered(true);
				_entity.getTile().addVisibilityForFaction(this.Const.Faction.Player);
			}

			this.getAgent().adjustCameraToTarget(this.m.TargetTile, this.m.SelectedSkill.getDelay());
			this.m.IsFirstExecuted = false;
			return false;
		}

		if (this.m.TargetTile != null && this.m.TargetTile.IsOccupiedByActor)
		{
			if (this.Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Using " + this.m.SelectedSkill.getName() + " against " + this.m.TargetTile.getEntity().getName() + "!");
			}

			this.m.SelectedSkill.use(this.m.TargetTile);

			if (_entity.isAlive() && (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer))
			{
				this.getAgent().declareAction();
				this.getAgent().declareEvaluationDelay(this.m.SelectedSkill.getDelay() + 750);
			}

			this.m.TargetTile = null;
			this.m.SelectedSkill = null;
		}

		return true;
	}

	function selectBestTargetAndSkill( _entity, _targets, _skills )
	{
		local bestSkills;
		local bestTarget;
		local bestScore = -9000.0;
		local bestOpponentsAdjacent = 0;
		local myTile = _entity.getTile();

		foreach( target in _targets )
		{
			if (target.Actor.isNull())
			{
				continue;
			}

			local targetTile = target.Actor.getTile();

			if (!targetTile.IsVisibleForEntity)
			{
				continue;
			}

			local skills = [];

			foreach( s in _skills )
			{
				if (s.isInRange(targetTile) && s.onVerifyTarget(_entity.getTile(), targetTile))
				{
					skills.push({
						Skill = s,
						Score = 0.0
					});
				}
			}

			if (skills.len() == 0)
			{
				continue;
			}

			local alliesAdjacent = 0;
			local opponentsAdjacent = 0;
			local score = 0.0;

			foreach( s in skills )
			{
				s.Score = this.queryTargetValue(_entity, target.Actor, s.Skill);
				score = score + s.Score;
			}

			if (myTile.getDistanceTo(targetTile) > 1)
			{
				for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
				{
					if (!targetTile.hasNextTile(i))
					{
					}
					else
					{
						local tile = targetTile.getNextTile(i);

						if (tile.IsEmpty)
						{
						}
						else if (tile.IsOccupiedByActor)
						{
							if (tile.getEntity().isAlliedWith(_entity))
							{
								score = score + 1.0 / 2.0 * this.queryTargetValue(_entity, tile.getEntity(), null);
								alliesAdjacent = ++alliesAdjacent;
							}
							else
							{
								score = score + 1.0 / 1.0 * this.queryTargetValue(_entity, tile.getEntity(), null);
								opponentsAdjacent = ++opponentsAdjacent;
							}
						}
					}
				}
			}

			if (targetTile.getZoneOfControlCount(_entity.getFaction()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones)
			{
				score = score * (1.0 + (1.0 - this.Math.minf(1.0, this.queryActorTurnsNearTarget(target.Actor, myTile, _entity).Turns)) * this.Const.AI.Behavior.AttackDangerMult);
			}

			if (score > bestScore && (this.getProperties().TargetPriorityHittingAlliesMult >= 1.0 || alliesAdjacent <= this.Const.AI.Behavior.AttackRangedMaxAlliesAdjacent))
			{
				bestTarget = target;
				bestScore = score;
				bestSkills = skills;
				bestOpponentsAdjacent = opponentsAdjacent;
			}
		}

		if (bestTarget != null)
		{
			this.m.TargetTile = bestTarget.Actor.getTile();
			local chance = 0;
			local highestScore = 0;

			for( local i = 0; i < bestSkills.len(); i = ++i )
			{
				if (bestSkills[i].Score > highestScore)
				{
					highestScore = this.Math.floor(this.Math.pow(bestSkills[i].Score * 100, this.Const.AI.Behavior.AttackRangedChancePOW));
				}
			}

			for( local i = 0; i < bestSkills.len(); i = ++i )
			{
				local score = this.Math.floor(this.Math.pow(bestSkills[i].Score * 100, this.Const.AI.Behavior.AttackRangedChancePOW));

				if (score < highestScore * this.Const.AI.Behavior.AttackRangedScoreCutoff)
				{
				}
				else
				{
					chance = chance + score;
				}
			}

			if (chance != 0)
			{
				local pick = this.Math.rand(1, chance);

				for( local i = 0; i < bestSkills.len(); i = ++i )
				{
					local score = this.Math.floor(this.Math.pow(bestSkills[i].Score * 100, this.Const.AI.Behavior.AttackRangedChancePOW));

					if (score < highestScore * this.Const.AI.Behavior.AttackRangedScoreCutoff)
					{
					}
					else
					{
						if (pick <= score)
						{
							this.m.SelectedSkill = bestSkills[i].Skill;
							return this.Math.maxf(0.1, bestSkills[i].Score + this.Math.maxf(0.0, bestScore));
						}

						pick = pick - score;
					}
				}
			}
		}

		return 0.0;
	}

});
