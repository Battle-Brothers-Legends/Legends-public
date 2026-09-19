this.legend_magic_sleep_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMagicSleep);
		this.m.Description = "Use soothing vapours to lull an enemy to sleep.";
		this.m.KilledString = "Slept";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/dlc2/alp_sleep", 12);
		this.m.IsUsingActorPitch = true;
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 300;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.MinRange = 1;
		this.m.MaxRange = 5;
		this.m.ActionPointCost = 9;
		this.m.FatigueCost = 70;
	}

	function isUsable() {
		local actor = this.getContainer().getActor();
		if (!actor.isArmedWithMagicStaff()) {
			return false;
		}

		return this.skill.isUsable() && (!::Tactical.isActive() || !actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions()));
	}

	function getTooltip() {
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Chance to apply to all enemies within 1 range of target tile."
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Hit chance based on the difference of Resolve between the user and the target."
		});
		return ret;
	}

	function getHitchance(_targetEntity) {
		local chance = ::Math.round(40 + (this.getContainer().getActor().getCurrentProperties().getBravery() - _targetEntity.getCurrentProperties().getBravery()) / 5);
		return ::Math.max(0, ::Math.min(100, chance));
	}

	function onUse(_user, _targetTile) {
		::Time.scheduleEvent(::TimeUnit.Virtual, 300, this.onDelayedEffect.bindenv(this), {
			User = _user,
			TargetTile = _targetTile
		});
		return true;
	}

	function canBePutToSleep(_user, _targetTile) {
		return _targetTile.IsOccupiedByActor && !_targetTile.getEntity().isNonCombatant() && !_user.isAlliedWith(_targetTile.getEntity()) && !_targetTile.getEntity().getFlags().has("undead");
	}

	function onDelayedEffect(_tag) {
		local targetTiles = [];
		local _targetTile = _tag.TargetTile;
		local _user = _tag.User;

		if (this.canBePutToSleep(_user, _targetTile)) {
			targetTiles.push(_targetTile);
		}

		local self = this;
		targetTiles.extend([0, 1, 2, 3, 4, 5].filter(@(_, _direction)(_targetTile.hasNextTile(_direction))).map(@(_direction)(_targetTile.getNextTile(_direction))).filter(@(_, _nextTile)(self.canBePutToSleep(_user, _nextTile))));

		foreach (tile in targetTiles) {
			local target = tile.getEntity();
			local roll = ::Math.rand(1, 100);
			local chance = this.getHitchance(target);

			local logString = ::Const.UI.getColorizedEntityName(_user) + " tries to put " + ::Const.UI.getColorizedEntityName(target) + " to sleep (Chance: " + chance + ", Rolled: " + roll + ")\n";

			if (roll <= chance) {
				::Legends.Effects.grant(target, ::Legends.Effect.Sleeping, function (_effect) {
					_effect.m.TurnsLeft = ::Math.max(1, 4 + this.getCurrentProperties().NegativeStatusEffectDuration);
				}.bindenv(target));

				if (!_user.isHiddenToPlayer() && tile.IsVisibleForPlayer) {
					::Tactical.EventLog.log(logString + ::Const.UI.getColorizedEntityName(target) + " falls into a magical sleep.");
				}
			} else {
				if (!_user.isHiddenToPlayer() && tile.IsVisibleForPlayer) {
					::Tactical.EventLog.log(logString + ::Const.UI.getColorizedEntityName(target) + " resists the urge to fall asleep.");
				}
			}
		}
	}
});
