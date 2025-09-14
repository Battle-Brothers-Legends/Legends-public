this.legend_enraged_hyena_bite_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendEnragedHyenaBite);
		this.m.Description = "A vicious leaping bite usable up to two tiles between the hyena and its prey. The hyena leaps into the gap to bite; on a hit it instantly retreats to its original position while dragging the victim, locking them adjacent and immobilized until the hyena is struck in melee.";
		this.m.KilledString = "Mauled to death";
		this.m.Icon = "skills/active_197.png";
		this.m.Overlay = "active_197";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc6/hyena_bite_01.wav",
			"sounds/enemies/dlc6/hyena_bite_02.wav",
			"sounds/enemies/dlc6/hyena_bite_03.wav",
			"sounds/enemies/dlc6/hyena_bite_04.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/enemies/werewolf_claw_hit_01.wav",
			"sounds/enemies/werewolf_claw_hit_02.wav",
			"sounds/enemies/werewolf_claw_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingAndPiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingAndPiercingHead;
		this.m.DirectDamageMult = 0.6;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 8;
		this.m.MinRange = 2;
		this.m.MaxRange = 3;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 33;
		this.m.ChanceSmash = 0;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Usable up to two tiles away if the middle tiles are empty (height difference up to 1 allowed)"
		});
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "On hit: retreats and drags the target away, immobilizing them"
		});
		tooltip.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Target defenses are halved while held"
		});
		tooltip.push({
			id = 9,
			type = "text",
			icon = "ui/icons/special.png",
			text = "A melee hit on the hyena frees the victim"
		});
		return tooltip;
	}

	function onUpdate(_properties) {
		_properties.DamageRegularMin += 25;
		_properties.DamageRegularMax += 40;
		_properties.DamageArmorMult *= 0.8;
	}

	function validateLeapPath(_originTile, _targetTile, _distance) {
		local dir = _originTile.getDirectionTo(_targetTile);
		local tile1 = null;
		if (_originTile.hasNextTile(dir)) {
			tile1 = _originTile.getNextTile(dir);
		}
		if (tile1 == null || !tile1.IsEmpty || tile1.IsOccupiedByActor) {
			::logDebug("legend_enraged_hyena_bite_skill: Invalid 1st tile (null/occupied/not empty)");
			return false;
		}
		if (this.Math.abs(tile1.Level - _originTile.Level) > 1) {
			::logDebug("legend_enraged_hyena_bite_skill: Height difference origin -> tile1 too large (" + _originTile.Level + " -> " + tile1.Level + ")");
			return false;
		}
		if (_distance == 2) {
			return true;
		}

		local tile2 = null;
		if (tile1.hasNextTile(dir)) {
			tile2 = tile1.getNextTile(dir);
		}
		if (tile2 == null || !tile2.IsEmpty || tile2.IsOccupiedByActor) {
			::logDebug("legend_enraged_hyena_bite_skill: Invalid 2nd tile (null/occupied/not empty)");
			return false;
		}
		if (this.Math.abs(tile2.Level - tile1.Level) > 1) {
			::logDebug("legend_enraged_hyena_bite_skill: Height difference tile1 -> tile2 too large (" + tile1.Level + " -> " + tile2.Level + ")");
			return false;
		}
		if (this.Math.abs(_targetTile.Level - tile2.Level) > 1) {
			::logDebug("legend_enraged_hyena_bite_skill: Height difference tile2 -> target too large (" + tile2.Level + " -> " + _targetTile.Level + ")");
			return false;
		}

		return true;
	}

	// TODO needs to be flexible on directionand allow leaping diagonally
	// TODO must not be engaged in melee
	function onVerifyTarget(_originTile, _targetTile) {
		::logDebug("legend_enraged_hyena_bite_skill: onVerifyTarget _originTile= x=" + _originTile.X + " y=" + _originTile.Y + " ; _targetTile= x=" + _targetTile.X + " y=" + _targetTile.Y);

		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) {
			::logDebug("legend_enraged_hyena_bite_skill: Base skill target verification failed");
			return false;
		}

		local distance = _originTile.getDistanceTo(_targetTile);
		if (distance != 2 && distance != 3) {
			::logDebug("legend_enraged_hyena_bite_skill: Target distance " + distance + " is invalid");
			return false;
		}

		local target = _targetTile.getEntity();
		if (::Legends.S.skillEntityAliveCheck(target)) {
			::logDebug("legend_enraged_hyena_bite_skill: Target is not alive");
			return false;
		}

		if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab) {
			::logDebug("legend_enraged_hyena_bite_skill: Target is immune to knockback and grab");
			return false;
		}

		// Ensure exactly one or two empty tiles in between to leap into, max height difference 1
		if (!this.validateLeapPath(_originTile, _targetTile, distance)) {
			return false;
		}

		::logDebug("legend_enraged_hyena_bite_skill: Valid target at distance " + distance);
		return true;
	}

	function onUse(_user, _targetTile) {
		::logDebug("legend_enraged_hyena_bite_skill: onUse called");

		local originTile = _user.getTile();
		local target = _targetTile.getEntity();
		local distance = originTile.getDistanceTo(_targetTile);
		local dir = originTile.getDirectionTo(_targetTile);

		::logDebug("legend_enraged_hyena_bite_skill: onUse originTile= x=" + originTile.X + " y=" + originTile.Y + " ; targetTile x=" + _targetTile.X + " y=" + _targetTile.Y + " distance= " + distance + " dir= " + dir);

		if (!this.validateLeapPath(originTile, _targetTile, distance)) {
			::logError("legend_enraged_hyena_bite_skill: Invalid leap path on use");
			return false;
		}

		// Get the intermediate tiles for leap destination
		local tile1 = originTile.getNextTile(dir);
		if (tile1 != null) {
			::logDebug("tile1= x=" + tile1.X + " y=" + tile1.Y);
		}
		local tile2 = null;
		if (distance == 3) {
			tile2 = tile1.getNextTile(dir);
			if (tile2 != null) {
				::logDebug("tile2= x=" + tile2.X + " y=" + tile2.Y);
			}
		}

		// Double-check tiles are still valid right before execution
		if (tile1 == null || !tile1.IsEmpty || tile1.IsOccupiedByActor) {
			::logError("legend_enraged_hyena_bite_skill: tile1 became unavailable");
			return false;
		}
		if (distance == 3 && (tile2 == null || !tile2.IsEmpty || tile2.IsOccupiedByActor)) {
			::logError("legend_enraged_hyena_bite_skill: tile2 became unavailable");
			return false;
		}

		local leapDest = distance == 2 ? tile1 : tile2;
		if (!_user.isHiddenToPlayer()) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " leaps towards " + this.Const.UI.getColorizedEntityName(target));
		}

		// Leap to destination
		::logDebug("legend_enraged_hyena_bite_skill: Leaping to x=" + leapDest.X + " y=" + leapDest.Y);
		_user.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		this.Tactical.getNavigator().teleport(_user, leapDest, null, null, true, 0.0);
		::logDebug("legend_enraged_hyena_bite_skill: Hyena position after leap x=" + _user.getTile().X + " y=" + _user.getTile().Y);

		// Attack from current (leaped) position
		::logDebug("legend_enraged_hyena_bite_skill: Attacking from leaped position");
		if (::Legends.S.skillEntityAliveCheck(target)) {
			return true;
		}
		local success = this.attackEntity(_user, target);
		if (!success || target.getHitpoints() <= 0 || ::Legends.S.skillEntityAliveCheck(target)) {
			::logDebug("legend_enraged_hyena_bite_skill: Attack missed or target is dead");
			return success;
		}

		// Retreat hyena to original tile
		::logDebug("legend_enraged_hyena_bite_skill: Retreating to original position");
		_user.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		this.Tactical.getNavigator().teleport(_user, originTile, null, null, true, 0.0);
		::logDebug("legend_enraged_hyena_bite_skill: Hyena position after retreat x=" + _user.getTile().X + " y=" + _user.getTile().Y);

		// Drag target to tile1
		::logDebug("legend_enraged_hyena_bite_skill: Dragging target");
		target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		this.Tactical.getNavigator().teleport(target, tile1, null, null, true, 0.0);
		if (!_user.isHiddenToPlayer()) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " drags " + this.Const.UI.getColorizedEntityName(target) + " back!");
		}
		::logDebug("legend_enraged_hyena_bite_skill: Target position after dragging x=" + target.getTile().X + " y=" + target.getTile().Y);

		::logDebug("legend_enraged_hyena_bite_skill: Applying grab effect");
		this.spawnIcon("legend_enraged_hyena_bite_effect", target.getTile());
		::Legends.Effects.grant(target, ::Legends.Effect.LegendEnragedHyenaBite, function(_effect) {
			if ("setHyena" in _effect) {
				_effect.setHyena(_user);
			} else {
				::logError("legend_enraged_hyena_bite_skill: effect has no setHyena function");
			}
		}.bindenv(this));

		return success;
	}

});
