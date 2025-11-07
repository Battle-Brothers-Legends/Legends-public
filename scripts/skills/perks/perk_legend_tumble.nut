this.perk_legend_tumble <- this.inherit("scripts/skills/skill", {
	m = {
		CanTeleport = true
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendTumble);
		this.m.Order = this.Const.SkillOrder.Last;
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (this.findFreeTile() == null)
		{
			this.m.CanTeleport = false;
			return;
		}

		if (this.getContainer().getActor().getCurrentProperties().IsStunned)
			return;

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
			return;

		if (_skill.isRanged())
			_properties.RerollDefenseChance += _properties.MeleeDefense;
		else
			_properties.RerollDefenseChance += _properties.RangedDefense;
		this.m.CanTeleport = true;
	}

	function findFreeTile()
	{
		local actor = this.getContainer().getActor();
		local myTile = this.getContainer().getActor().getTile();
		local freeTiles = [];
		for( local i = 0; i < 6; i++ )
		{
			if (myTile.hasNextTile(i))
			{
				local nextTile = myTile.getNextTile(i);

				if (!nextTile.IsOccupiedByActor && this.Math.abs(nextTile.Level - myTile.Level) <= 1)
				{
					freeTiles.push(nextTile)
				}
			}
		}
		if (freeTiles.len() > 0)
			return freeTiles[this.Math.rand(0, freeTiles.len() - 1)];

		return null; // tile or null
	}

	function teleportMe( _user, _targetTile )
	{
		local tag = {
			Skill = this,
			User = _user,
			OldTile = _user.getTile(),
			TargetTile = _targetTile,
			OnRepelled = this.onRepelled
		};

		if (tag.OldTile.IsVisibleForPlayer || _targetTile.IsVisibleForPlayer)
		{
			local myPos = _user.getPos();
			local targetPos = _targetTile.Pos;
			local distance = tag.OldTile.getDistanceTo(_targetTile);
			local Dx = (targetPos.X - myPos.X) / distance;
			local Dy = (targetPos.Y - myPos.Y) / distance;

			// Add an incremental loop to find the tile
			for( local i = 0; i < distance; i++ )
			{
				local x = myPos.X + Dx * i;
				local y = myPos.Y + Dy * i;
				local tile = this.Tactical.worldToTile(this.createVec(x, y));

				if (this.Tactical.isValidTile(tile.X, tile.Y) && this.Const.Tactical.DustParticles.len() != 0)
				{
					for( local j = 0; j < this.Const.Tactical.DustParticles.len(); j++ )
					{
						this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[j].Brushes, this.Tactical.getTile(tile), this.Const.Tactical.DustParticles[j].Delay, this.Const.Tactical.DustParticles[j].Quantity * 0.5, this.Const.Tactical.DustParticles[j].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[j].SpawnRate, this.Const.Tactical.DustParticles[j].Stages);
					}
				}
			}
		}

		this.Tactical.getNavigator().teleport(_user, _targetTile, this.onTeleportDone, tag, false, 2.0);
		return true;
	}

	function onRepelled( _tag )
	{
		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, null, null, false);
	}

	function onTeleportDone( _entity, _tag )
	{
		local myTile = _entity.getTile();
		local potentialVictims = [];
		local betterThanNothing;
		local ZOC = [];
		local dirToTarget = _tag.OldTile.getDirectionTo(myTile);

		for( local i = 0; i != 6; i = i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = myTile.getNextTile(i);

				if (!tile.IsOccupiedByActor)
				{
				}
				else
				{
					local actor = tile.getEntity();

					if (actor.isAlliedWith(_entity) || actor.getCurrentProperties().IsStunned)
					{
					}
					else
					{
						ZOC.push(actor);

						if (i != dirToTarget && i + 1 != dirToTarget && i - 1 != dirToTarget)
						{
						}
						else
						{
							if (betterThanNothing == null)
							{
								betterThanNothing = actor;
							}

							if (actor.getCurrentProperties().IsImmuneToStun)
							{
							}
							else
							{
								potentialVictims.push(actor);
							}
						}
					}
				}
			}

			i = ++i;
		}

		local zoc_fail = false;

		foreach( actor in ZOC )
		{
			if (actor.onMovementInZoneOfControl(_entity, true))
			{
				if (actor.onAttackOfOpportunity(_entity, true))
				{
					zoc_fail = true;
					local dir = myTile.getDirectionTo(_tag.OldTile);

					if (myTile.hasNextTile(dir))
					{
						local tile = myTile.getNextTile(dir);

						if (tile.IsEmpty && this.Math.abs(tile.Level - myTile.Level) <= 1 && tile.getDistanceTo(actor.getTile()) > 1)
						{
							if (_entity.isAlive() && !_entity.isDying())
							{
								_tag.TargetTile = tile;
								this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
							}

							if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
							{
								this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " tumbles and is repelled");
							}

							return;
						}
					}

					for( local i = 0; i != 6; i = i )
					{
						if (!myTile.hasNextTile(i))
						{
						}
						else
						{
							local tile = myTile.getNextTile(i);

							if (tile.IsEmpty && this.Math.abs(tile.Level - myTile.Level) <= 1)
							{
								if (_entity.isAlive() && !_entity.isDying())
								{
									_tag.TargetTile = tile;
									this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
								}

								if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
								{
									this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " tumbles and is repelled");
								}

								return;
							}
						}

						i = ++i;
					}
				}
			}
		}

		if (potentialVictims.len() == 0 && betterThanNothing != null)
		{
			potentialVictims.push(betterThanNothing);
		}

		if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " tumbles away from danger");
		}
	}

	function onMissed( _attacker, _skill )
	{
		if (!this.m.CanTeleport)
			return;
		local actor = this.getContainer().getActor();

		if (this.findFreeTile() == null || actor == null || actor.getCurrentProperties().IsStunned || actor.getCurrentProperties().IsRooted)
			return;

		this.teleportMe(actor,this. findFreeTile());
	}
});

