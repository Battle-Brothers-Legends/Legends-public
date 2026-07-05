this.perk_legend_tumble <- this.inherit("scripts/skills/skill", {
	m = {
		CanTeleport = true,
		IsTumbling = false,
		Frame = 0,
		HitSkillCounter = 0,
		EvadeSkillCounter = 0,
		SequenceHit = false
	},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendTumble);
		this.m.Order = ::Const.SkillOrder.Last;
	}

	function onBeingAttacked(_attacker, _skill, _properties) {
		if (::Time.getFrame() != this.m.Frame && ::Const.SkillCounter != this.m.HitSkillCounter) {
			this.m.Frame = ::Time.getFrame();
            this.m.HitSkillCounter = ::Const.SkillCounter;
            this.m.SequenceHit = false;
        }

		_properties.IsEvadingAllAttacks = false;
		if (::Const.SkillCounter == this.m.EvadeSkillCounter) {
            _properties.IsEvadingAllAttacks = true;
            this.m.CanTeleport = false;
            return;
        }

		local actor = this.getContainer().getActor();
		if (this.m.IsTumbling || this.m.SequenceHit || ::Legends.S.isEntityNullOrDead(actor) || ::Legends.S.isEntityMovementDisabled(actor) || this.findFreeTile() == null) {
			this.m.CanTeleport = false;
			return;
		}

		if (_skill.isRanged()) {
			_properties.RerollDefenseChance += _properties.MeleeDefense;
		} else {
			_properties.RerollDefenseChance += _properties.RangedDefense;
		}
		this.m.CanTeleport = true;
	}

	function onBeforeDamageReceived(_attacker, _skill, _hitInfo, _properties) {
        if (::Const.SkillCounter == this.m.HitSkillCounter) {
            this.m.SequenceHit = true;
        }
    }

	function findFreeTile() {
		local myTile = this.getContainer().getActor().getTile();
		local freeTiles = [];
		for (local i = 0; i < 6; i++) {
			if (myTile.hasNextTile(i)) {
				local nextTile = myTile.getNextTile(i);

				if (nextTile.IsEmpty && ::Math.abs(nextTile.Level - myTile.Level) <= 1) {
					freeTiles.push(nextTile);
				}
			}
		}
		if (freeTiles.len() > 0) {
			return freeTiles[::Math.rand(0, freeTiles.len() - 1)];
		}

		return null; // tile or null
	}

	function teleportMe(_user, _targetTile) {		
		if (::Legends.S.isEntityNullOrDead(_user)) {
			return;
		}
		
		this.m.IsTumbling = true;

		local tag = {
			Skill = this,
			User = _user,
			OldTile = _user.getTile(),
			TargetTile = _targetTile,
			OnRepelled = this.onRepelled
		};

		if (_user.m.CurrentMovementType == ::Const.Tactical.MovementType.Involuntary){
			::Time.scheduleEvent(::TimeUnit.Virtual, 50, function ( _tag ) {
                _tag.Skill.teleportMe(_tag.User, _tag.TargetTile);
            }.bindenv(this), tag);
			return;
		}

		if (tag.OldTile.IsVisibleForPlayer || _targetTile.IsVisibleForPlayer) {
			local myPos = _user.getPos();
			local targetPos = _targetTile.Pos;
			local distance = tag.OldTile.getDistanceTo(_targetTile);
			local Dx = (targetPos.X - myPos.X) / distance;
			local Dy = (targetPos.Y - myPos.Y) / distance;

			// Add an incremental loop to find the tile
			for (local i = 0; i < distance; i++) {
				local x = myPos.X + Dx * i;
				local y = myPos.Y + Dy * i;
				local tile = ::Tactical.worldToTile(this.createVec(x, y));

				if (::Tactical.isValidTile(tile.X, tile.Y) && ::Const.Tactical.DustParticles.len() != 0) {
					for (local j = 0; j < ::Const.Tactical.DustParticles.len(); j++) {
						::Tactical.spawnParticleEffect(false, ::Const.Tactical.DustParticles[j].Brushes, ::Tactical.getTile(tile), ::Const.Tactical.DustParticles[j].Delay, ::Const.Tactical.DustParticles[j].Quantity * 0.5, ::Const.Tactical.DustParticles[j].LifeTimeQuantity * 0.5, ::Const.Tactical.DustParticles[j].SpawnRate, ::Const.Tactical.DustParticles[j].Stages);
					}
				}
			}
		}

		if (!::Tactical.getNavigator().isTravelling(_user)) {
			::Tactical.getNavigator().teleport(_user, _targetTile, this.onTeleportDone, tag, false, 2.0);
		} else{
			this.m.IsTumbling = false;
		}
	}

	function onRepelled(_tag) {
		if (!::Legends.S.isEntityNullOrDead(_tag.User) && !::Tactical.getNavigator().isTravelling(_tag.User))
			::Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, null, null, false);
		_tag.Skill.m.IsTumbling = false;
	}

	function onTeleportDone(_entity, _tag) {
		_tag.Skill.m.IsTumbling = false;
		local myTile = _entity.getTile();
		local potentialVictims = [];
		local betterThanNothing = null;
		local ZOC = [];
		local dirToTarget = _tag.OldTile.getDirectionTo(myTile);

		for( local i = 0; i < 6; i++ ) {
            if (!myTile.hasNextTile(i)) continue;

            local tile = myTile.getNextTile(i);
            if (!tile.IsOccupiedByActor) continue;

            local actor = tile.getEntity();
            if (actor.isAlliedWith(_entity) || actor.getCurrentProperties().IsStunned) continue;

            ZOC.push(actor);

            local dirLeft = (dirToTarget + 5) % 6;
            local dirRight = (dirToTarget + 1) % 6;

            if (i == dirToTarget || i == dirLeft || i == dirRight) {
                if (betterThanNothing == null) {
                    betterThanNothing = actor;
                }

                if (!actor.getCurrentProperties().IsImmuneToStun) {
                    potentialVictims.push(actor);
                }
            }
        }

		local zoc_fail = false;

		foreach (actor in ZOC) {
			if (actor.onMovementInZoneOfControl(_entity, true)) {
				if (actor.onAttackOfOpportunity(_entity, true)) {
					zoc_fail = true;
					local dir = myTile.getDirectionTo(_tag.OldTile);

					if (myTile.hasNextTile(dir)) {
						local tile = myTile.getNextTile(dir);

						if (tile.IsEmpty && ::Math.abs(tile.Level - myTile.Level) <= 1 && tile.getDistanceTo(actor.getTile()) > 1) {
							if (!::Legends.S.isEntityNullOrDead(_entity)) {
								_tag.TargetTile = tile;
								_tag.Skill.m.IsTumbling = true;
								::Time.scheduleEvent(::TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
							}

							if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer) {
								::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_entity) + " tumbles and is repelled");
							}

							return;
						}
					}

					for( local i = 0; i < 6; i++ ) {
                        if (!myTile.hasNextTile(i)) continue;
                        local tile = myTile.getNextTile(i);

                        if (tile.IsEmpty && ::Math.abs(tile.Level - myTile.Level) <= 1) {
                            if (!::Legends.S.isEntityNullOrDead(_entity)) {
                                _tag.TargetTile = tile;
								_tag.Skill.m.IsTumbling = true;
                                ::Time.scheduleEvent(::TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
                            }

                            if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer) {
                                ::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_entity) + " tumbles and is repelled");
                            }
                            return;
                        }
                    }
				}
			}
		}

		if (potentialVictims.len() == 0 && betterThanNothing != null) {
			potentialVictims.push(betterThanNothing);
		}

		if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer) {
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_entity) + " tumbles away from danger");
		}
	}

	function onMissed(_attacker, _skill) {
		if (!this.m.CanTeleport || this.m.IsTumbling) {
			return;
		}

		local actor = this.getContainer().getActor();
		if (::Legends.S.isEntityNullOrDead(actor) || ::Legends.S.isEntityMovementDisabled(actor)) {
			return;
		}

		local targetTile = this.findFreeTile();
		if (targetTile == null) {
			return;
		}

		this.m.EvadeSkillCounter = ::Const.SkillCounter;
		this.teleportMe(actor, targetTile);
	}

	function onCombatStarted()	{
		this.m.Frame = 0;
		this.m.HitSkillCounter = 0;
		this.m.EvadeSkillCounter = 0;
	}

	function onCombatFinished()	{
		this.skill.onCombatFinished();
		this.m.Frame = 0;
		this.m.HitSkillCounter = 0;
		this.m.EvadeSkillCounter = 0;
	}
});
