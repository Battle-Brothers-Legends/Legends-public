::mods_hookExactClass("ai/tactical/behaviors/ai_protect", function(o) 
{
	o.selectBestTargetTile = function ( _entity )
	{
		// Function is a generator.
		local time = this.Time.getExactTime();
		local myTile = _entity.getTile();
		local allAllies = this.getAgent().getKnownAllies();
		local allOpponents = this.getAgent().getKnownOpponents();
		local potential_tiles = [];

		foreach( a in allAllies )
		{
			if (a.getMoraleState() == this.Const.MoraleState.Fleeing)
			{
				continue;
			}

			if (a.getCurrentProperties().TargetAttractionMult <= 1.0 || a.getCurrentProperties().TargetAttractionMult <= _entity.getCurrentProperties().TargetAttractionMult)
			{
				continue;
			}

			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			local importantAlly = a;
			local importantAllyTile = a.getTile();
			local dirs = [
				0,
				0,
				0,
				0,
				0,
				0
			];
			local relevant = 0;

			foreach( o in allOpponents )
			{
				local opponent = o.Actor;
				local dist = o.Actor.getTile().getDistanceTo(importantAllyTile);
				local score = 1.0;

				if (dist <= 11 && this.isRangedUnit(o.Actor))
				{
					score = 1.0;
				}
				else if (dist <= 6)
				{
					score = this.Math.maxf(0.0, 1.0 - dist / 6.0);
				}
				else
				{
					continue;
				}

				relevant = ++relevant;
				local dir = importantAllyTile.getDirection8To(opponent.getTile());

				switch(dir)
				{
				case this.Const.Direction8.W:
					dirs[this.Const.Direction.NW] += 4 * score;
					dirs[this.Const.Direction.SW] += 4 * score;
					break;

				case this.Const.Direction8.E:
					dirs[this.Const.Direction.NE] += 4 * score;
					dirs[this.Const.Direction.SE] += 4 * score;
					break;

				default:
					local dir = importantAllyTile.getDirectionTo(opponent.getTile());
					local dir_left = dir - 1 >= 0 ? dir - 1 : 6 - 1;
					local dir_right = dir + 1 < 6 ? dir + 1 : 0;
					dirs[dir] += 4 * score;
					dirs[dir_left] += 3 * score;
					dirs[dir_right] += 3 * score;
					break;
				}
			}

			relevant = this.Math.maxf(1.0, relevant);

			for( local i = 0; i != 6; i = ++i )
			{
				dirs[i] /= relevant;

				if (!importantAllyTile.hasNextTile(i))
				{
				}
				else
				{
					local tile = importantAllyTile.getNextTile(i);

					if (!tile.IsEmpty && tile.ID != myTile.ID)
					{
					}
					else
					{
						local score = 1;
						local immediateBonus = 0;
						score = score + dirs[i] / this.Math.max(1, allOpponents.len()) * this.Const.AI.Behavior.ProtectAllyDirectionMult;
						score = score - myTile.getDistanceTo(tile);
						local importantAlliesAtTile = 0;

						for( local j = 0; j != 6; j = ++j )
						{
							if (!tile.hasNextTile(j))
							{
							}
							else
							{
								local adjacentTile = tile.getNextTile(j);

								if (!adjacentTile.IsOccupiedByActor)
								{
								}
								else if (this.Math.abs(tile.Level - adjacentTile.Level) > 1)
								{
								}
								else
								{
									local other = adjacentTile.getEntity();

									if (!_entity.isAlliedWith(other))
									{
										immediateBonus = immediateBonus + this.Const.AI.Behavior.ProtectAllyEngagedBonus;
									}
									else if (other.getCurrentProperties().TargetAttractionMult > 1.0 && other.getCurrentProperties().TargetAttractionMult > _entity.getCurrentProperties().TargetAttractionMult)
									{
										score = score * a.getCurrentProperties().TargetAttractionMult;
									}
								}
							}
						}

						if (tile.Properties.Effect != null && !tile.Properties.Effect.IsPositive && tile.Properties.Effect.Applicable(_entity))
						{
							immediateBonus = immediateBonus - this.Const.AI.Behavior.ProtectAllyTileEffectPenalty;
						}

						score = score + immediateBonus;
						local already_in = false;

						foreach( t in potential_tiles )
						{
							if (t.Tile.ID == tile.ID)
							{
								t.AllyDefendBonus += a.getCurrentProperties().TargetAttractionMult * this.Const.AI.Behavior.ProtectAllyAttractionBonus;
								t.TileBonus += dirs[i] + immediateBonus;
								t.Score += score;
								already_in = true;
								break;
							}
						}

						if (!already_in)
						{
							potential_tiles.push({
								Tile = tile,
								Score = score,
								TileBonus = dirs[i] + immediateBonus,
								AllyDefendBonus = a.getCurrentProperties().TargetAttractionMult * this.Const.AI.Behavior.ProtectAllyAttractionBonus
							});
						}
					}
				}
			}
		}

		if (potential_tiles.len() == 0)
		{
			return false;
		}

		local navigator = this.Tactical.getNavigator();
		local settings = navigator.createSettings();
		local myTile = _entity.getTile();
		local myFaction = _entity.getFaction();
		potential_tiles.sort(this.onSortByScore);
		local attempts = 0;
		local time = this.Time.getExactTime();
		local bestDestination;
		local bestScore = -9000;
		local bestIsForNextTurn = false;
		local bestWaitAfterMove = false;
		settings.ActionPointCosts = _entity.getActionPointCosts();
		settings.FatigueCosts = _entity.getFatigueCosts();
		settings.FatigueCostFactor = 0.0;
		settings.ActionPointCostPerLevel = _entity.getLevelActionPointCost();
		settings.FatigueCostPerLevel = _entity.getLevelFatigueCost();
		settings.AllowZoneOfControlPassing = false;
		settings.ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
		settings.AlliedFactions = _entity.getAlliedFactions();
		settings.Faction = _entity.getFaction();

		foreach( t in potential_tiles )
		{
			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			local apCost = 0;
			local waitAfterMove = false;
			local isForNextTurn = false;
			attempts = ++attempts;

			if (attempts > this.Const.AI.Behavior.DefendMaxAttempts)
			{
				break;
			}

			if (!t.Tile.isSameTileAs(myTile))
			{
				if (navigator.findPath(myTile, t.Tile, settings, 0))
				{
					local movementCosts = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
					apCost = apCost + movementCosts.ActionPointsRequired;
					isForNextTurn = false;
					waitAfterMove = false;

					if (!movementCosts.IsComplete)
					{
						if (movementCosts.Tiles == 0)
						{
							isForNextTurn = true;
						}
						else
						{
							waitAfterMove = true;
						}
					}
				}
				else
				{
					continue;
				}
			}

			local allyDefendBonus = t.AllyDefendBonus;
			local TileBonus = t.TileBonus * this.Const.AI.Behavior.ProtectAllyDirectionMult;
			local score = TileBonus + allyDefendBonus - apCost * this.Const.AI.Behavior.ProtectAllyAPCostMult;

			if (score > bestScore)
			{
				bestDestination = t.Tile;
				bestIsForNextTurn = isForNextTurn;
				bestWaitAfterMove = waitAfterMove;
				bestScore = score;
			}
		}

		if (bestDestination != null && bestIsForNextTurn == false)
		{
			if (this.Const.AI.VerboseMode && bestDestination.isSameTileAs(_entity.getTile()))
			{
				this.logInfo("* " + _entity.getName() + ": In fact, I would prefer to remain where I am");
			}

			this.m.TargetTile = bestDestination;
			this.m.IsWaitingAfterMove = bestWaitAfterMove;
			return true;
		}

		return false;
	}});