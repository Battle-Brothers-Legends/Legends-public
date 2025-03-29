::mods_hookExactClass("ai/tactical/behaviors/ai_mortar", function(o) 
{
	o.selectBestTarget = function ( _entity, _targets )
	{
		local myTile = _entity.getTile();
		local bestTile;
		local bestTargets = 0;
		local tiles = [];

		foreach( target in _targets )
		{
			if (target.Actor.getTile().IsHidingEntity)
			{
				continue;
			}

			tiles.push(target.Actor.getTile());

			for( local i = 0; i < 6; i = ++i )
			{
				if (!target.Actor.getTile().hasNextTile(i))
				{
				}
				else
				{
					tiles.push(target.Actor.getTile().getNextTile(i));
				}
			}
		}

		foreach( tile in tiles )
		{
			if (!this.m.Skill.isUsableOn(tile))
			{
				continue;
			}

			local numTargets = 0;

			if (tile.IsOccupiedByActor)
			{
				local e = tile.getEntity();

				if (!_entity.isAlliedWith(e))
				{
					numTargets = numTargets + 10;

					if (e.getCurrentProperties().IsStunned || e.getCurrentProperties().IsRooted || tile.hasZoneOfControlOtherThan(e.getAlliedFactions()))
					{
						numTargets = numTargets + 5;
					}
				}
				else if (e.getType() == this.Const.EntityType.Slave)
				{
					numTargets = numTargets - 10;
				}
				else
				{
					numTargets = numTargets - 20;
				}
			}

			for( local i = 0; i < 6; i = ++i )
			{
				if (!tile.hasNextTile(i))
				{
				}
				else
				{
					local nextTile = tile.getNextTile(i);

					if (!nextTile.IsOccupiedByActor)
					{
					}
					else
					{
						local e = nextTile.getEntity();

						if (!_entity.isAlliedWith(e))
						{
							numTargets = numTargets + 10;

							if (e.getCurrentProperties().IsStunned || e.getCurrentProperties().IsRooted || tile.hasZoneOfControlOtherThan(e.getAlliedFactions()))
							{
								numTargets = numTargets + 5;
							}
						}
						else if (e.getType() == this.Const.EntityType.Slave)
						{
							numTargets = numTargets - 10;
						}
						else
						{
							numTargets = numTargets - 20;
						}
					}
				}
			}

			if (numTargets <= 0)
			{
				continue;
			}

			if (numTargets > bestTargets)
			{
				bestTile = tile;
				bestTargets = numTargets;
			}
		}

		return bestTile;
	}
});