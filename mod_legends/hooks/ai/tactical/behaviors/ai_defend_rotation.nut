::mods_hookExactClass("ai/tactical/behaviors/ai_defend_rotation", function(o)
{
	o.onEvaluate = function( _entity )
	{
		// Function is a generator.
		this.m.TargetTile = null;
		this.m.Skill = null;
		local scoreMult = this.getProperties().BehaviorMult[this.m.ID];
		local time = this.Time.getExactTime();

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

		if (this.getAgent().getIntentions().IsChangingWeapons && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax() > 2)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (::Legends.Mod.ModSettings.getSetting("AiRotation").getValue() == "Disabled" || this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		scoreMult = scoreMult * this.getFatigueScoreMult(this.m.Skill);
		local allies = this.queryAlliesInMeleeRange();

		if (allies.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local myTile = _entity.getTile();
		local zoc = _entity.getTile().getZoneOfOccupationCountOtherThan(_entity.getAlliedFactions());
		local isOffensive = this.m.Skill.getID() == ::Legends.Actives.getID(::Legends.Active.BarbarianFury);
		local hitpointRatio = (_entity.getHitpoints() + _entity.getArmor(this.Const.BodyPart.Body) + _entity.getArmor(this.Const.BodyPart.Head)) / (_entity.getHitpointsMax() + _entity.getArmorMax(this.Const.BodyPart.Body) + _entity.getArmorMax(this.Const.BodyPart.Head));
		local isEntityWounded = false;

		if (hitpointRatio <= 0.5)
		{
			isEntityWounded = true;
		}

		local isEntityArmedWithShield = _entity.isArmedWithShield();
		local isEntityExpendable = _entity.getCurrentProperties().TargetAttractionMult <= 0.5;
		local isEntityRangedUnit = this.isRangedUnit(_entity);
		local isEntityArmedWithMeleeWeapon = true;

		if (isEntityRangedUnit)
		{
			isEntityArmedWithMeleeWeapon = false;
		}
		else if (_entity.isArmedWithMeleeWeapon() && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax() > 1)
		{
			isEntityArmedWithMeleeWeapon = false;
		}

		local isEntitySupport = _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.Misc);
		local attackSkill = _entity.getSkills().getAttackOfOpportunity();
		local apRequiredForAttack = attackSkill != null ? attackSkill.getActionPointCost() : 4;
		local isEntityAOE = isEntityArmedWithMeleeWeapon && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.Weapon) && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE();
		local isEntityTwoHanded = isEntityArmedWithMeleeWeapon && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.Weapon) && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.TwoHanded);
		local currentPotentialTargets = this.queryTargetsInMeleeRange(this.getProperties().EngageRangeMin, this.Math.max(_entity.getIdealRange(), this.getProperties().EngageRangeMax), 1, myTile);
		local currentBestTarget = this.queryBestMeleeTarget(_entity, null, currentPotentialTargets);
		local targets = this.getAgent().getKnownOpponents();
		local dirs = [
			0,
			0,
			0,
			0,
			0,
			0
		];

		foreach( opponent in targets )
		{
			local dir = myTile.getDirection8To(opponent.Actor.getTile());
			local mult = this.isRangedUnit(opponent.Actor) ? 2 : 1;
			mult = mult * (7.0 / myTile.getDistanceTo(opponent.Actor.getTile()));

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
				local dir = myTile.getDirectionTo(opponent.Actor.getTile());
				local dir_left = dir - 1 >= 0 ? dir - 1 : 6 - 1;
				local dir_right = dir + 1 < 6 ? dir + 1 : 0;
				dirs[dir] += 4 * mult;
				dirs[dir_left] += 3 * mult;
				dirs[dir_right] += 3 * mult;
				break;
			}
		}

		local entityCover = 0.0;

		for( local i = 0; i < 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				local adjacentTile = myTile.getNextTile(i);

				if (dirs[i] >= 8 && !adjacentTile.IsEmpty)
				{
					entityCover = entityCover + dirs[i] / targets.len() * this.Const.AI.Behavior.DefendSeekCoverMult;
				}
			}
		}

		local isEntityAtIdealWeaponRange = true;

		if (zoc != 0 && !isEntityArmedWithMeleeWeapon)
		{
			isEntityAtIdealWeaponRange = false;
		}

		local bestTile;
		local bestScore = 1.0;

		foreach( ally in allies )
		{
			if (!this.m.Skill.onVerifyTarget(myTile, ally.getTile()))
			{
				continue;
			}

			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			local score = 1.0;
			local reverseScore = 1.0;
			local allyTile = ally.getTile();
			local allyZOC = allyTile.getZoneOfOccupationCountOtherThan(ally.getAlliedFactions());
			local isAllyExpendable = ally.getCurrentProperties().TargetAttractionMult <= 0.5;
			local isAllyValuable = ally.getCurrentProperties().TargetAttractionMult > _entity.getCurrentProperties().TargetAttractionMult;
			local isEntityValuable = _entity.getCurrentProperties().TargetAttractionMult > ally.getCurrentProperties().TargetAttractionMult;
			local isAllyArmedWithMeleeWeapon = true;
			local isAllyRangedUnit = this.isRangedUnit(ally);

			if (isAllyRangedUnit)
			{
				isAllyArmedWithMeleeWeapon = false;
			}
			else if (ally.isArmedWithMeleeWeapon() && ally.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax() > 1)
			{
				isAllyArmedWithMeleeWeapon = false;
			}

			local isAllySupport = ally.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && ally.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.Misc);
			local isAllyAOE = isAllyArmedWithMeleeWeapon && ally.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && ally.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.Weapon) && ally.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE();
			local isAllyAtIdealWeaponRange = true;

			if (allyZOC != 0 && !isAllyArmedWithMeleeWeapon)
			{
				isAllyAtIdealWeaponRange = false;
			}

			local isAllyFleeing = ally.getMoraleState() == this.Const.MoraleState.Fleeing;
			local isAllyDone = isAllyFleeing || ally.isTurnDone() || ally.getFatiguePct() >= 0.8 && _entity.getFatiguePct() <= 0.5 || ally.getCurrentProperties().IsStunned || !ally.getCurrentProperties().IsAbleToUseWeaponSkills;
			local isAllyTurnDone = isAllyFleeing || ally.isTurnDone() || ally.getCurrentProperties().IsStunned || !ally.getCurrentProperties().IsAbleToUseWeaponSkills;
			local isAllyArmedWithShield = ally.isArmedWithShield();
			local allyHitpointRatio = (ally.getHitpoints() + ally.getArmor(this.Const.BodyPart.Body) + ally.getArmor(this.Const.BodyPart.Head)) / (ally.getHitpointsMax() + ally.getArmorMax(this.Const.BodyPart.Body) + ally.getArmorMax(this.Const.BodyPart.Head));
			local dirs = [
				0,
				0,
				0,
				0,
				0,
				0
			];

			foreach( opponent in targets )
			{
				local dir = allyTile.getDirection8To(opponent.Actor.getTile());
				local mult = this.isRangedUnit(opponent.Actor) ? 2 : 1;
				mult = mult * (7.0 / allyTile.getDistanceTo(opponent.Actor.getTile()));

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
					local dir = allyTile.getDirectionTo(opponent.Actor.getTile());
					local dir_left = dir - 1 >= 0 ? dir - 1 : 6 - 1;
					local dir_right = dir + 1 < 6 ? dir + 1 : 0;
					dirs[dir] += 4 * mult;
					dirs[dir_left] += 3 * mult;
					dirs[dir_right] += 3 * mult;
					break;
				}
			}

			local allyCover = 0.0;

			for( local i = 0; i < 6; i = ++i )
			{
				if (!allyTile.hasNextTile(i))
				{
				}
				else
				{
					local adjacentTile = allyTile.getNextTile(i);

					if (dirs[i] >= 8 && !adjacentTile.IsEmpty)
					{
						allyCover = allyCover + dirs[i] / targets.len() * this.Const.AI.Behavior.DefendSeekCoverMult;
					}
				}
			}

			if (!isAllyFleeing && isEntityArmedWithMeleeWeapon && !isAllyArmedWithMeleeWeapon && allyZOC != 0 && zoc == 0)
			{
				score = score * this.Const.AI.Behavior.RotationWrongWeaponMult;
			}
			else if (!isAllyValuable && !isAllyFleeing && !isEntityArmedWithMeleeWeapon && isAllyArmedWithMeleeWeapon && allyZOC == 0 && zoc != 0)
			{
				score = score * this.Const.AI.Behavior.RotationWrongWeaponMult;

				if (isEntityRangedUnit)
				{
					score = score * (this.Const.AI.Behavior.RotationWrongWeaponMult * 3.0);
				}
			}

			if (!isAllyExpendable && !isAllyFleeing && isEntityArmedWithMeleeWeapon && isAllyArmedWithMeleeWeapon && isEntityArmedWithShield && !isAllyArmedWithShield && !isAllyAOE && allyZOC > zoc + 2)
			{
				score = score * this.Const.AI.Behavior.RotationShieldInFrontMult;
			}
			else if (!isAllyValuable && !isAllyFleeing && isEntityArmedWithMeleeWeapon && isAllyArmedWithMeleeWeapon && !isEntityArmedWithShield && isAllyArmedWithShield && !isEntityAOE && zoc > allyZOC + 2)
			{
				score = score * this.Const.AI.Behavior.RotationShieldInFrontMult;
			}

			if (!isOffensive && !isAllyExpendable && isEntityArmedWithMeleeWeapon && allyHitpointRatio < 0.5 && allyHitpointRatio < hitpointRatio - 0.2 && allyZOC > zoc + 1)
			{
				score = score * (this.Const.AI.Behavior.RotationSaveWoundedMult * (1.0 + (hitpointRatio - allyHitpointRatio)));
			}
			else if (!isOffensive && !isAllyValuable && !isAllyFleeing && isAllyArmedWithMeleeWeapon && hitpointRatio < 0.5 && allyHitpointRatio > hitpointRatio + 0.2 && zoc > allyZOC + 1)
			{
				score = score * (this.Const.AI.Behavior.RotationSaveWoundedMult * (1.0 + (allyHitpointRatio - hitpointRatio)));
			}

			if (!isAllyExpendable && isAllyFleeing && allyZOC > 0 && zoc == 0 && isEntityArmedWithMeleeWeapon)
			{
				score = score * this.Const.AI.Behavior.RotationSaveFleeingAlly;
			}

			if (ally.getCurrentProperties().TargetAttractionMult > _entity.getCurrentProperties().TargetAttractionMult * this.Const.AI.Behavior.RotationPriorityTargetMinPct && zoc < allyZOC)
			{
				score = score * this.Const.AI.Behavior.RotationPriorityTargetMult;
			}
			else if (_entity.getCurrentProperties().TargetAttractionMult > ally.getCurrentProperties().TargetAttractionMult * this.Const.AI.Behavior.RotationPriorityTargetMinPct && zoc > allyZOC && isAllyArmedWithMeleeWeapon)
			{
				score = score * this.Const.AI.Behavior.RotationPriorityTargetMult;
			}

			if (zoc == 0 && allyZOC >= 3 && isEntityAOE && !isAllyAOE && _entity.getActionPoints() >= 9 && isAllyTurnDone)
			{
				score = score * this.Const.AI.Behavior.RotationAOEMult;
			}
			else if (zoc >= 3 && allyZOC == 0 && !isEntityAOE && isAllyAOE && !isAllyTurnDone && !isAllyFleeing)
			{
				score = score * this.Const.AI.Behavior.RotationAOEMult;
			}

			if (isOffensive && _entity.getActionPoints() >= 9 && !isEntitySupport && !(allyZOC > zoc && !isEntityArmedWithMeleeWeapon) && !(zoc > allyZOC && !isAllyArmedWithMeleeWeapon) && !(isAllyFleeing && zoc != 0) && _entity.getCurrentProperties().IsAbleToUseWeaponSkills)
			{
				local potentialTargets = this.queryTargetsInMeleeRange(this.getProperties().EngageRangeMin, this.Math.max(_entity.getIdealRange(), this.getProperties().EngageRangeMax), 1, ally.getTile());
				local bestTarget = this.queryBestMeleeTarget(_entity, null, potentialTargets);

				if (!(zoc == 0 && bestTarget.Target != null && this.getAgent().getBehavior(this.Const.AI.Behavior.ID.EngageMelee) != null && this.getAgent().getBehavior(this.Const.AI.Behavior.ID.EngageMelee).m.TargetActor != null && this.getAgent().getBehavior(this.Const.AI.Behavior.ID.EngageMelee).m.TargetActor.getID() == bestTarget.Target.getID()))
				{
					if (isAllyDone && !isEntityTwoHanded && bestTarget.Score > currentBestTarget.Score * 2.0 || isAllyDone && isEntityTwoHanded && bestTarget.Score > currentBestTarget.Score * 1.5 || bestTarget.Score > currentBestTarget.Score * 3.0)
					{
						score = score * (this.Const.AI.Behavior.RotationOffensiveMult + bestTarget.Score);
					}
				}
			}
			else if ((isOffensive || _entity.getXPValue() >= ally.getXPValue() * this.Const.AI.Behavior.RotationEliteAllyXPMult) && _entity.getActionPoints() <= 3 && ally.getActionPoints() >= 9 && !isAllyFleeing && !isAllySupport && ally.getCurrentProperties().IsAbleToUseWeaponSkills && (isAllyArmedWithMeleeWeapon || zoc == 0))
			{
				local potentialTargets = this.queryTargetsInMeleeRange(ally.getAIAgent().getProperties().EngageRangeMin, this.Math.max(ally.getIdealRange(), ally.getAIAgent().getProperties().EngageRangeMax), 1, myTile);
				local bestTarget = this.queryBestMeleeTarget(ally, null, potentialTargets);
				local allyPotentialTargets = this.queryTargetsInMeleeRange(ally.getAIAgent().getProperties().EngageRangeMin, this.Math.max(ally.getIdealRange(), ally.getAIAgent().getProperties().EngageRangeMax), 1, ally.getTile());
				local allyBestTarget = this.queryBestMeleeTarget(ally, null, allyPotentialTargets);

				if (bestTarget.Score > allyBestTarget.Score * 2.0)
				{
					score = score * (this.Const.AI.Behavior.RotationOffensiveMult + bestTarget.Score);
				}
			}

			if (this.getStrategy().isDefending() && isEntityArmedWithShield && !isAllyArmedWithShield && isEntityArmedWithMeleeWeapon && isAllyArmedWithMeleeWeapon && !isAllyRangedUnit && !isEntityRangedUnit && entityCover > allyCover * 2.0)
			{
				score = score * this.Const.AI.Behavior.RotationCoverMult;
			}
			else if (this.getStrategy().isDefending() && !isEntityArmedWithShield && isAllyArmedWithShield && isEntityArmedWithMeleeWeapon && isAllyArmedWithMeleeWeapon && !isAllyRangedUnit && !isEntityRangedUnit && allyCover > entityCover * 2.0)
			{
				score = score * this.Const.AI.Behavior.RotationCoverMult;
			}

			if (!isAllyFleeing && isEntityArmedWithMeleeWeapon && !isAllyArmedWithMeleeWeapon && allyZOC == 0 && zoc != 0)
			{
				reverseScore = reverseScore * this.Const.AI.Behavior.RotationWrongWeaponMult;
			}
			else if (!isAllyValuable && !isAllyFleeing && !isEntityArmedWithMeleeWeapon && isAllyArmedWithMeleeWeapon && allyZOC != 0 && zoc == 0)
			{
				reverseScore = reverseScore * this.Const.AI.Behavior.RotationWrongWeaponMult;

				if (isEntityRangedUnit)
				{
					reverseScore = reverseScore * (this.Const.AI.Behavior.RotationWrongWeaponMult * 3.0);
				}
			}

			if (!isAllyExpendable && !isAllyFleeing && isEntityArmedWithMeleeWeapon && isAllyArmedWithMeleeWeapon && isEntityArmedWithShield && !isAllyArmedWithShield && !isAllyAOE && allyZOC <= zoc + 2)
			{
				reverseScore = reverseScore * this.Const.AI.Behavior.RotationShieldInFrontMult;
			}
			else if (!isAllyValuable && !isAllyFleeing && isEntityArmedWithMeleeWeapon && isAllyArmedWithMeleeWeapon && !isEntityArmedWithShield && isAllyArmedWithShield && !isEntityAOE && zoc <= allyZOC + 2)
			{
				reverseScore = reverseScore * this.Const.AI.Behavior.RotationShieldInFrontMult;
			}

			if (!isOffensive && !isAllyExpendable && isEntityArmedWithMeleeWeapon && allyHitpointRatio < 0.5 && allyHitpointRatio < hitpointRatio - 0.2 && allyZOC <= zoc + 1)
			{
				reverseScore = reverseScore * (this.Const.AI.Behavior.RotationSaveWoundedMult * (1.0 + (hitpointRatio - allyHitpointRatio)));
			}
			else if (!isOffensive && !isAllyValuable && !isAllyFleeing && isAllyArmedWithMeleeWeapon && hitpointRatio < 0.5 && allyHitpointRatio > hitpointRatio + 0.2 && zoc <= allyZOC + 1)
			{
				reverseScore = reverseScore * (this.Const.AI.Behavior.RotationSaveWoundedMult * (1.0 + (allyHitpointRatio - hitpointRatio)));
			}

			if (ally.getCurrentProperties().TargetAttractionMult > _entity.getCurrentProperties().TargetAttractionMult * this.Const.AI.Behavior.RotationPriorityTargetMinPct && zoc >= allyZOC)
			{
				reverseScore = reverseScore * this.Const.AI.Behavior.RotationPriorityTargetMult;
			}
			else if (_entity.getCurrentProperties().TargetAttractionMult > ally.getCurrentProperties().TargetAttractionMult * this.Const.AI.Behavior.RotationPriorityTargetMinPct && zoc <= allyZOC && isEntityArmedWithMeleeWeapon)
			{
				reverseScore = reverseScore * this.Const.AI.Behavior.RotationPriorityTargetMult;
			}

			if (allyZOC == 0 && zoc >= 3 && isEntityAOE && !isAllyAOE && !isAllyFleeing && _entity.getActionPoints() >= 9)
			{
				reverseScore = reverseScore * this.Const.AI.Behavior.RotationAOEMult;
			}
			else if (allyZOC >= 3 && zoc == 0 && !isEntityAOE && isAllyAOE && !isAllyFleeing)
			{
				reverseScore = reverseScore * this.Const.AI.Behavior.RotationAOEMult;
			}

			if (score > reverseScore && score > bestScore)
			{
				bestTile = ally.getTile();
				bestScore = score;
			}
		}

		if (bestTile == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = bestTile;
		scoreMult = scoreMult * bestScore;

		if (this.getAgent().getBehavior(this.Const.AI.Behavior.ID.EngageMelee) != null && this.getAgent().getBehavior(this.Const.AI.Behavior.ID.EngageMelee).getScore() * 1.5 >= this.Const.AI.Behavior.Score.Rotation * scoreMult)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		return this.Const.AI.Behavior.Score.Rotation * scoreMult;
	}

	o.onExecute = function( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(this.m.TargetTile);
			this.m.IsFirstExecuted = false;
			return false;
		}

		if (this.Const.AI.VerboseMode)
		{
			this.logInfo("* " + _entity.getName() + ": Using Rotation!");
		}
		
		if (this.m.TargetTile == null || this.m.Skill == null)
		{
			return true;
		}

		this.m.Skill.use(this.m.TargetTile);

		if (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer)
		{
			this.getAgent().declareEvaluationDelay(2000);
			this.getAgent().declareAction();
		}

		this.m.TargetTile = null;
		this.m.Skill = null;
		return true;
	}

});