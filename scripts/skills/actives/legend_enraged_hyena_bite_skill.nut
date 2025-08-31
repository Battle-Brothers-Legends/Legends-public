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

	// TODO needs to be flexible on directionand allow leaping diagonally
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
		if (distance == 2) {
			::logDebug("legend_enraged_hyena_bite_skill: Valid target at distance 2");
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

		::logDebug("legend_enraged_hyena_bite_skill: Valid target at distance 3");
		return true;
	}

	function onUse(_user, _targetTile) {
		::logDebug("legend_enraged_hyena_bite_skill: onUse called");

		local target = _targetTile.getEntity();
		local originalTile = _user.getTile();
		local distance = originalTile.getDistanceTo(_targetTile);
		local dir = originalTile.getDirectionTo(_targetTile);

		local tile1 = null;
		if (originalTile.hasNextTile(dir)) {
			tile1 = originalTile.getNextTile(dir);
		}
		if (tile1 == null || !tile1.IsEmpty || tile1.IsOccupiedByActor || this.Math.abs(tile1.Level - originalTile.Level) > 1) {
			::logError("legend_enraged_hyena_bite_skill: Invalid 1st tile on use (null/occupied/not empty/height diff too large)");
			return false;
		}
		//  || (distance == 3 && (tile2 == null || !tile2.IsEmpty))

		local tile2 = null;
		if (distance == 3 && tile1.hasNextTile(dir)) {
			tile2 = tile1.getNextTile(dir);
			if (tile2 == null || !tile2.IsEmpty || tile2.IsOccupiedByActor || this.Math.abs(tile2.Level - tile1.Level) > 1) {
				::logDebug("legend_enraged_hyena_bite_skill: Invalid 2nd tile (null/occupied/not empty/height diff too large)");
				return false;
			}
		}

		local leapDest = distance == 2 ? tile1 : tile2;
		if (!_user.isHiddenToPlayer()) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " leaps towards " + this.Const.UI.getColorizedEntityName(target));
		}
		_user.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		this.Tactical.getNavigator().teleport(_user, leapDest, null, null, true);

		// Attack from current (possibly leaped) position
		if (::Legends.S.skillEntityAliveCheck(target)) {
			return true;
		}
		local success = this.attackEntity(_user, target);
		if (!success || target.getHitpoints() <= 0 || ::Legends.S.skillEntityAliveCheck(target)) {
			::logDebug("legend_enraged_hyena_bite_skill: Attack missed or target is dead");
			return success;
		}

		// Retreat hyena to original tile
		_user.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		this.Tactical.getNavigator().teleport(_user, originalTile, null, null, true);

		// Drag target along
		target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		this.Tactical.getNavigator().teleport(target, tile1, null, null, true);
		if (!_user.isHiddenToPlayer()) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " drags " + this.Const.UI.getColorizedEntityName(target) + " back!");
		}

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
