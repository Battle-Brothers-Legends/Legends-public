this.legend_sprint_skill_5 <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendStrafingRun);
		this.m.Description = "Quickly sprint over a short distance in a straight line. Can not be used on difficult terrain, across different height levels or through enemy Zones of Control.";
		this.m.Icon = "ui/perks/perk_sprint.png";
		this.m.IconDisabled = "ui/perks/perk_sprint_sw.png";
		this.m.Overlay = "perk_37_active";
		this.m.SoundOnUse = [];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OtherTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingActorPitch = true;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 25;
		this.m.MinRange = 3;
		this.m.MaxRange = 4;
		this.m.MaxLevelDifference = 1;
	}

	function getTooltip()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		if (this.Tactical.isActive() && this.Const.DefaultMovementAPCost[this.getContainer().getActor().getTile().Type] != 2)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used on difficult terrain[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return !this.Tactical.isActive() || this.skill.isUsable() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()) && this.Const.DefaultMovementAPCost[this.getContainer().getActor().getTile().Type] <= 2;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (_originTile.getEntity().getCurrentProperties().IsRooted)
		{
			return false;
		}

		if (!_targetTile.IsEmpty)
		{
			return false;
		}

		if (this.Math.abs(_targetTile.Level - _originTile.Level) > this.m.MaxLevelDifference)
		{
			return false;
		}

		local distance = _originTile.getDistanceTo(_targetTile);
		local myPos = _originTile.Pos;
		local targetPos = _targetTile.Pos;
		local Dx = (targetPos.X - myPos.X) / distance;
		local Dy = (targetPos.Y - myPos.Y) / distance;

		for( local i = 0; i < distance; i = ++i )
		{
			local x = myPos.X + Dx * i;
			local y = myPos.Y + Dy * i;
			local tileCoords = this.Tactical.worldToTile(this.createVec(x, y));
			local tile = this.Tactical.getTile(tileCoords);

			if (!tile.IsOccupiedByActor && !tile.IsEmpty)
			{
				return false;
			}

			if (tile.hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
			{
				return false;
			}

			if (this.Math.abs(tile.Level - _originTile.Level) > 0)
			{
				return false;
			}
		}

		return true;
	}

	function onUse( _user, _targetTile )
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

			for( local i = 0; i < distance; i = ++i )
			{
				local x = myPos.X + Dx * i;
				local y = myPos.Y + Dy * i;
				local tile = this.Tactical.worldToTile(this.createVec(x, y));

				if (this.Tactical.isValidTile(tile.X, tile.Y) && this.Const.Tactical.DustParticles.len() != 0)
				{
					for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = ++i )
					{
						this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, this.Tactical.getTile(tile), this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.5, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages);
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

		for( local i = 0; i != 6; i = ++i )
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
								this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " sprints and is repelled");
							}

							return;
						}
					}

					for( local i = 0; i != 6; i = ++i )
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
									this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " sprints and is repelled");
								}

								return;
							}
						}
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
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " sprints");
		}
	}

});

