::mods_hookExactClass("ai/tactical/behaviors/ai_miasma", function(o)
{
	o.selectBestTarget = function ( _myTile, _entity, _skill )
	{
		local bestScore = -9000.0;
		local bestTarget;
		local potentialTiles = [];
		local usedIDs = [];
		local opponents = this.getAgent().getKnownOpponents();

		foreach (o in opponents)
		{
			if (o.Actor.isNull())
				continue;

			local opponentTile = o.Actor.getTile();

			if (_myTile.getDistanceTo(opponentTile) > _skill.getMaxRange() + 1)
				continue;

			if (usedIDs.find(opponentTile.ID) == null)
			{
				potentialTiles.push(opponentTile);
				usedIDs.push(opponentTile.ID);
			}

			for( local i = 0; i < 6; i = ++i )
			{
				if (opponentTile.hasNextTile(i))
				{
					local adjacentTile = opponentTile.getNextTile(i);

					if (_myTile.getDistanceTo(opponentTile) > _skill.getMaxRange() + 1)
					{
						continue;
					}
					else if (usedIDs.find(opponentTile.ID) == null)
					{
						potentialTiles.push(adjacentTile);
						usedIDs.push(adjacentTile.ID);
					}
				}
			}
		}

		if (potentialTiles.len() == 0)
		{
			return 0.0;
		}

		foreach( tile in potentialTiles )
		{
			if (!_skill.isInRange(tile, _myTile) || !_skill.onVerifyTarget(_myTile, tile))
			{
				continue;
			}

			local targets = [];

			if (tile.IsOccupiedByActor)
			{
				targets.push(tile.getEntity());
			}

			local score = 0.0;
			local numAffected = 0;

			for( local i = 0; i < 6; i = ++i )
			{
				if (tile.hasNextTile(i))
				{
					local nextTile = tile.getNextTile(i);

					if (nextTile.Properties.Effect != null && nextTile.Properties.Effect.Timeout - this.Time.getRound() >= 2)
					{
						continue;
					}
					else if (nextTile.IsOccupiedByActor)
					{
						targets.push(tile.getNextTile(i).getEntity());
					}
				}
			}

			if (targets.len() == 0)
			{
				continue;
			}

			foreach( target in targets )
			{
				local targetTile = target.getTile();

				if (_entity.isAlliedWith(target) && !target.getFlags().get("undead"))
				{
					score = score - 1.0;
					continue;
				}

				local target_score = _skill.getMaxRange() - _myTile.getDistanceTo(target.getTile());
				target_score = target_score + this.Const.AI.Behavior.MiasmaZOCBonus * target.getTile().getZoneOfControlCountOtherThan(target.getAlliedFactions());

				if (target.getHitpoints() <= 10)
				{
					target_score = target_score + this.Const.AI.Behavior.MiasmaAlmostDeadBonus;
				}

				if (target.getCurrentProperties().IsStunned || target.getCurrentProperties().IsRooted)
				{
					target_score = target_score + this.Const.AI.Behavior.MiasmaStunnedBonus;
				}

				target_score = target_score * target.getCurrentProperties().TargetAttractionMult;

				if (targetTile.Properties.Effect != null && targetTile.Properties.Effect.Type == "miasma" && targetTile.Properties.Effect.Timeout - this.Time.getRound() == 1)
				{
					target_score = target_score * this.Const.AI.Behavior.MiasmaOneTurnLeftMult;
				}

				if (!target.getCurrentProperties().IsStunned && !target.getCurrentProperties().IsRooted && !target.getTile().hasZoneOfControlOtherThan(target.getAlliedFactions()) && !target.isAbleToWait())
				{
					target_score = target_score * this.Const.AI.Behavior.MiasmaVSWaitMult;
				}

				score = score + target_score;
				++numAffected;
			}

			if (numAffected > 1)
			{
				score = score * this.Math.pow(this.Const.AI.Behavior.RootNumAffectedPOW, numAffected - 1);
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
			return this.Math.maxf(0.1, bestScore * 0.1);
		}
		else
		{
			return 0.0;
		}
	}
});
