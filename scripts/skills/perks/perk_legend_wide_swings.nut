this.perk_legend_wide_swings <- this.inherit("scripts/skills/skill", {
	m = {
		AlreadyUsed = false,
		ExecutingAttack = false
	},
	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendWideSwings);
	}

	function onTargetKilled (_targetEntity, _skill) {
		if (this.m.AlreadyUsed || _skill.isRanged()) {
			return;
		}

		this.m.AlreadyUsed = true;

		local executeFollowup;
		executeFollowup = (function(_retries) {
			local actor = this.getContainer().getActor();
			if (::Legends.S.isEntityNullOrDead(actor) || actor.m.MoraleState == ::Const.MoraleState.Fleeing || actor.getCurrentProperties().IsStunned || !::Tactical.TurnSequenceBar.isActiveEntity(actor)) {
				this.m.AlreadyUsed = false;
				return;
			}

			local tile = actor.getTile();
			local AOO = this.getContainer().getAttackOfOpportunity();
			local targetTiles = [];

			if (AOO == null) {
				this.m.AlreadyUsed = false;
				return;
			}

			local targetsAreMovingInvoluntarily = false;

			for (local i = 0; i < 6; i++) {
				if (tile.hasNextTile(i)) {
					local next = tile.getNextTile(i);

					if (next.IsOccupiedByActor && ::Math.abs(next.Level - tile.Level) <= 1 && !next.getEntity().isAlliedWithPlayer() && AOO.onVerifyTarget(tile, next)) {
						local entity = next.getEntity();
						if (entity.m.CurrentMovementType == ::Const.Tactical.MovementType.Involuntary || ::Tactical.getNavigator().isTravelling(entity)) {
							if (_retries > 20) {
								entity.setCurrentMovementType(::Const.Tactical.MovementType.Default); // temporary fix, assume any movement has finished by now
							} else {
								targetsAreMovingInvoluntarily = true;
								break;
							}
						}

						if (AOO.onVerifyTarget(tile, next)) {
							targetTiles.push(next);
						}
					}
				}
			}

			if (targetsAreMovingInvoluntarily) {
				::Time.scheduleEvent(::TimeUnit.Virtual, 50, executeFollowup, _retries + 1);
				return;
			}

			if (targetTiles.len() == 0) {
				this.m.AlreadyUsed = false;
				return;
			}

			this.m.ExecutingAttack = true;
			AOO.useForFree(targetTiles[::Math.rand(0, targetTiles.len() - 1)]);
			this.m.ExecutingAttack = false;
		}).bindenv(this);
		::Time.scheduleEvent(::TimeUnit.Virtual, 10, executeFollowup, 0);
	}

	function onAnySkillUsed (_skill, _targetEntity, _properties) {
		if (this.m.ExecutingAttack) {
			_properties.DamageTotalMult *= 0.5;
		}
	}

	function onTurnStart () {
		this.m.AlreadyUsed = false;
	}
});

