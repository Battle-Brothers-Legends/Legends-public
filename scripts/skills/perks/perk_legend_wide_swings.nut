this.perk_legend_wide_swings <- this.inherit("scripts/skills/skill", {
	m = {
		AlreadyUsed = false,
		ExecutingAttack = false
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendWideSwings);
	}

	function onTargetMissed( _skill, _targetEntity ) {
		if (!_skill.isAttack() || _skill.isRanged()) {
			return;
		}

		if (this.m.AlreadyUsed) {
			return;
		}

		if (this.Math.rand(1, 100) < 50)

		this.m.AlreadyUsed = true;
		local executeFollowup;
		executeFollowup = (function( _tag ) {
			local actor = this.getContainer().getActor();
			if (::Legends.S.isEntityNullOrDead(actor) || actor.m.MoraleState == this.Const.MoraleState.Fleeing || actor.getCurrentProperties().IsStunned || !::Tactical.TurnSequenceBar.isActiveEntity(actor)) {
				this.m.AlreadyUsed = false;
				return;
			}

			local tile = actor.getTile();
			local _skill = this.getContainer().getAttackOfOpportunity();
			local targetTiles = [];

			local targetsAreMovingInvoluntarily = false;

			for (local i = 0; i != 6; i = ++i) {
				if (tile.hasNextTile(i)) {
					local next = tile.getNextTile(i);

					if (next.IsOccupiedByActor && this.Math.abs(next.Level - tile.Level) <= 1 && !next.getEntity().isAlliedWithPlayer()	&& _skill.onVerifyTarget(tile, next)) {
						local entity = next.getEntity();
						if (entity.m.CurrentMovementType == this.Const.Tactical.MovementType.Involuntary || ::Tactical.getNavigator().isTravelling(entity)) {
							targetsAreMovingInvoluntarily = true;
							break;
						}
						if (_skill.onVerifyTarget(tile, next)) {
							targetTiles.push(next);
						}
					}
				}
			}

			if (targetsAreMovingInvoluntarily) {
            	::Time.scheduleEvent(::TimeUnit.Virtual, 50, executeFollowup, _tag);
            	return;
        	}

			if (targetTiles.len() == 0) {
				return;
			}

			this.m.ExecutingAttack = true;
			_skill.useForFree(targetTiles[this.Math.rand(0, targetTiles.len() - 1)]);
			this.m.ExecutingAttack = false;
		}).bindenv(this);
		::Time.scheduleEvent(::TimeUnit.Virtual, 10, executeFollowup, this);
	}

	function onAnySkillUsed (_skill, _targetEntity, _properties) {
		if (this.m.ExecutingAttack) {
			_properties.MeleeSkill += 30;
			_skill.m.HitChanceBonus += 30;
			_properties.DamageTotalMult *= 0.5;
		}
	}

	function onAnySkillExecuted (_skill, _targetTile, _targetEntity, _forFree) {
		if (this.m.AlreadyUsed && _forFree) {
			this.m.AlreadyUsed = false;
		}
	}

});

