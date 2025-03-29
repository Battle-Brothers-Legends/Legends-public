::mods_hookExactClass("ai/tactical/behaviors/ai_move_tentacle", function(o) 
{
	o.onEvaluate = function ( _entity )
	{
		// Function is a generator.
		local score = this.getProperties().BehaviorMult[this.m.ID];
		this.m.TargetTile = null;
		this.m.SelectedSkill = null;
		local time = this.Time.getExactTime();

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
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

		if (this.getAgent().getIntentions().IsDefendingPosition)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local skills = [];

		foreach( skillID in this.m.PossibleSkills )
		{
			local skill = _entity.getSkills().getSkillByID(skillID);

			if (skill != null && skill.isUsable() && skill.isAffordable())
			{
				this.m.SelectedSkill = skill;
				break;
			}
		}

		if (this.m.SelectedSkill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasKnownOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local masterTile;
		local instances = this.Tactical.Entities.getAllInstances();

		for( local f = this.Const.Faction.PlayerAnimals + 1; f != instances.len(); f = ++f )
		{
			for( local p = 0; p != instances[f].len(); p = ++p )
			{
				if (instances[f][p].getType() == this.Const.EntityType.Kraken)
				{
					masterTile = instances[f][p].getTile();
					break;
				}
			}
		}

		local targets = this.getAgent().getKnownOpponents();
		local potentialDestinations = [];
		local myTile = _entity.getTile();
		local myTileScore;

		foreach( t in targets )
		{
			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			if (t.Actor.isNull())
				continue;

			local target = t.Actor;
			local targetTile = t.Actor.getTile();

			if (_entity.getMode() == 0 && target.getCurrentProperties().IsRooted)
			{
				continue;
			}

			local zocByAllies = targetTile.getZoneOfControlCountOtherThan(target.getAlliedFactions());
			local potentialTiles = this.queryDestinationsInRange(targetTile, this.getProperties().EngageRangeMin, this.Math.max(_entity.getIdealRange(), this.getProperties().EngageRangeMax));
			potentialTiles.push(myTile);

			foreach( tile in potentialTiles )
			{
				local next = false;

				foreach( pt in potentialDestinations )
				{
					if (pt.ID == tile.ID)
					{
						next = true;
						break;
					}
				}

				if (next)
				{
					continue;
				}

				local dist = myTile.getDistanceTo(tile);
				local tileScore = 30.0;
				tileScore = this.Math.maxf(1.0, score - myTile.getDistanceTo(tile));

				if (masterTile != null)
				{
					tileScore = this.Math.maxf(1.0, score - masterTile.getDistanceTo(tile));
				}

				if (target.getCurrentProperties().IsRooted)
				{
					tileScore = tileScore * this.Const.AI.Behavior.MoveTentacleTargetAlreadyRooted;
				}

				local zoc = tile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions());
				tileScore = tileScore * this.Math.pow(this.Const.AI.Behavior.MoveTentacleZOCMult, zoc - 1);
				tileScore = tileScore * this.Math.pow(this.Const.AI.Behavior.MoveTentacleAlliesPresentMult, zocByAllies - 1);
				local targetValues = 0.0;
				local targetsInRange = this.queryTargetsInMeleeRange(this.getProperties().EngageRangeMin, this.Math.max(_entity.getIdealRange(), this.getProperties().EngageRangeMax), 4, tile);

				foreach( pr in targetsInRange )
				{
					targetValues = targetValues + this.queryTargetValue(_entity, pr);

					if (pr.getTile().getDistanceTo(tile) <= pr.getIdealRange())
					{
						targetValues = targetValues - 0.1;
					}
				}

				tileScore = tileScore * targetValues;

				if (myTile.ID == tile.ID)
				{
					tileScore = tileScore * this.Const.AI.Behavior.MoveTentacleMyTileMult;
				}

				if (masterTile != null && masterTile.getDistanceTo(tile) == 1)
				{
					tileScore = tileScore * this.Const.AI.Behavior.MoveTentacleBlockHeadMult;
				}

				potentialDestinations.push({
					Tile = tile,
					Score = tileScore,
					ID = tile.ID
				});
			}
		}

		if (potentialDestinations.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		potentialDestinations.sort(this.onSortByScore);
		local i = 0;

		while (i < potentialDestinations.len())
		{
			if (potentialDestinations[i].Tile.ID == myTile.ID)
			{
				this.m.TargetTile = null;
				return this.Const.AI.Behavior.Score.Zero;
			}
			else if (!this.m.SelectedSkill.isUsableOn(potentialDestinations[i].Tile))
			{
				local betweenTile = myTile.getTileBetweenThisAnd(potentialDestinations[i].Tile);

				if (!this.m.SelectedSkill.isUsableOn(betweenTile))
				{
					i = ++i;
					continue;
				}
				else
				{
					this.m.TargetTile = betweenTile;
					break;
				}
			}
			else
			{
				this.m.TargetTile = potentialDestinations[i].Tile;
				break;
			}
		}

		if (this.m.TargetTile == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.getAgent().getIntentions().TargetTile = this.m.TargetTile;
		return this.Const.AI.Behavior.Score.MoveTentacle * score;
	}
	o.onExecute = function( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.m.IsFirstExecuted = false;

			if (this.Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Moving to engage.");
			}

			this.m.Agent.adjustCameraToTarget(this.m.TargetTile);
			this.m.SelectedSkill.use(this.m.TargetTile);

			if (_entity.isAlive())
			{
				local delay = 0;

				if (!_entity.isHiddenToPlayer())
				{
					delay = delay + 2000; //Was 800, increased to 2000 in line with ai_move_tail as this lack of delay may be contributing to the game being frozen when these tentacles move - Luft 7/3/23
				}

				if (this.m.TargetTile.IsVisibleForPlayer)
				{
					delay = delay + 2000;
				}

				this.getAgent().declareEvaluationDelay(delay);
			}
		}
		else if (!_entity.isStoringColor())
		{
			return true;
		}

		return false;
	}
});