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
		_properties.DamageArmorMult *= 1.6;
	}

	function formatTile(_t) {
		return "(x=" + _t.X + " y=" + _t.Y + ")";
	}

	function validateLeapPath(_originTile, _targetTile) {
		// ::logDebug("legend_enraged_hyena_bite_skill: validateLeapPath _originTile=" + this.formatTile(_originTile) + " _targetTile=" + this.formatTile(_targetTile));
		local distance = _originTile.getDistanceTo(_targetTile);
		if (distance < this.m.MinRange || distance > this.m.MaxRange) {
			return null;
		}

		local path = [];
		local current = _originTile;
		for (local i = 0; i < distance - 1; i++) {
			local dir = current.getDirectionTo(_targetTile);

			if (!current.hasNextTile(dir)) {
				// ::logDebug("legend_enraged_hyena_bite_skill: validateLeapPath current has no next tile in dir=" + dir);
				return null;
			}

			local next = current.getNextTile(dir);
			if (!this.validateNextTile(current, next)) {
				// ::logDebug("legend_enraged_hyena_bite_skill: validateLeapPath next tile is not valid: " + this.formatTile(next));
				return null;
			}

			path.append(next);
			current = next;
		}

		// Next tile should be the _targetTile
		local dir = current.getDirectionTo(_targetTile);
		if (!current.hasNextTile(dir)) {
			// ::logDebug("legend_enraged_hyena_bite_skill: validateLeapPath current has no next tile in dir=" + dir);
			return null;
		}
		if (!current.getNextTile(dir).isSameTileAs(_targetTile)) {
			// ::logDebug("legend_enraged_hyena_bite_skill: validateLeapPath next tile is not target tile: " + this.formatTile(current.getNextTile(dir)) + " != " + this.formatTile(_targetTile));
			return null;
		}

		// Also ensure the final step to the target respects the height difference
		if (this.Math.abs(_targetTile.Level - current.Level) > 1) {
			// ::logDebug("legend_enraged_hyena_bite_skill: validateLeapPath target tile level difference too high: " + _targetTile.Level + " vs " + current.Level);
			return null;
		}

		return path;
	}

	function validateNextTile(_originTile, _targetTile) {
		if (_targetTile == null || !_targetTile.IsEmpty || _targetTile.IsOccupiedByActor) {
			return false;
		}
		if (this.Math.abs(_targetTile.Level - _originTile.Level) > 1) {
			return false;
		}
		return true;
	}

	function onVerifyTarget(_originTile, _targetTile) {
		// ::logDebug("legend_enraged_hyena_bite_skill: onVerifyTarget _originTile=" + this.formatTile(_originTile) + " _targetTile=" + this.formatTile(_targetTile));

		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) {
			// ::logDebug("legend_enraged_hyena_bite_skill: onVerifyTarget failed");
			return false;
		}

		local target = _targetTile.getEntity();
		if (::Legends.S.skillEntityAliveCheck(target)) {
			// ::logDebug("legend_enraged_hyena_bite_skill: Target is not alive");
			return false;
		}

		if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab) {
			// ::logDebug("legend_enraged_hyena_bite_skill: Target is immune to knockback and grab");
			return false;
		}

		if (target.getFlags().has("LegendEnragedHyenaAttacker")) {
			// ::logDebug("legend_enraged_hyena_bite_skill: Target is already held by another hyena");
			return false;
		}

		local path = this.validateLeapPath(_originTile, _targetTile);
		// ::logDebug("legend_enraged_hyena_bite_skill: onVerifyTarget path=" + path);
		if (path == null || path.len() == 0) {
			// ::logDebug("legend_enraged_hyena_bite_skill: Invalid leap path");
			return false;
		}

		// local pathString = "";
		// for (local i = 0; i < path.len(); i++) {
		// 	pathString += "x=" + path[i].X + " y=" + path[i].Y;
		// 	if (i < path.len() - 1) {
		// 		pathString += " -> ";
		// 	}
		// }
		// ::logDebug("legend_enraged_hyena_bite_skill: Valid leap path: " + pathString);
		return true;
	}

	function isUsable() {
		if (!this.skill.isUsable()) {
			return false;
		}
		local actor = this.getContainer().getActor();
		if (actor == null) {
			return false;
		}
		if (actor.getTile() != null && actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions())) {
			return false;
		}
		if (actor.getFlags().has("LegendEnragedHyenaBiteVictim")) {
			return false;
		}
		return true;
	}

	function onUse(_actor, _targetTile) {
		// ::logDebug("legend_enraged_hyena_bite_skill: onUse _actor= " + _actor + " ; _targetTile= x=" + _targetTile.X + " y=" + _targetTile.Y);
		local originTile = _actor.getTile();
		local target = _targetTile.getEntity();

		// Paranoid checks
		local path = this.validateLeapPath(originTile, _targetTile);
		if (path == null || path.len() == 0) {
			::logError("legend_enraged_hyena_bite_skill: Invalid leap path on use");
			return false;
		}
		for (local i = 0; i < path.len(); i++) {
			if (path[i] == null || !path[i].IsEmpty || path[i].IsOccupiedByActor) {
				::logError("legend_enraged_hyena_bite_skill: tile " + i + " became unavailable");
				return false;
			}
		}

		if (!_actor.isHiddenToPlayer()) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_actor) + " leaps towards " + this.Const.UI.getColorizedEntityName(target));
		}

		local tag = {
			skill = this,
			actor = _actor,
			target = target,
			originTile = originTile,
			tile1 = path[0],
			tile2 = path[path.len() - 1],
		};

		this.onLeapStart(tag);
		return true;
	}

	function onLeapStart(_tag) {
		for (local i = 0; i < Const.Tactical.DustParticles.len(); i++) {
			Tactical.spawnParticleEffect(
				false,
				Const.Tactical.DustParticles[i].Brushes,
				_tag.actor.getTile(),
				Const.Tactical.DustParticles[i].Delay,
				Const.Tactical.DustParticles[i].Quantity,
				Const.Tactical.DustParticles[i].LifeTimeQuantity,
				Const.Tactical.DustParticles[i].SpawnRate,
				Const.Tactical.DustParticles[i].Stages
			);
		}

		// Leap to destination
		_tag.actor.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		this.Tactical.getNavigator().teleport(_tag.actor, _tag.tile2, null, null, false, 3.0);

		// Schedule attack
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 200, this.onAttackStart.bindenv(this), _tag);
	}

	function onAttackStart(_tag) {
		// ::logDebug("legend_enraged_hyena_bite_skill: onAttackStart _tag= " + _tag);

		if (::Legends.S.skillEntityAliveCheck(_tag.target)) {
			::logError("legend_enraged_hyena_bite_skill: Target is no longer valid");
			return;
		}
		local success = _tag.skill.attackEntity(_tag.actor, _tag.target);
		if (!success || _tag.target.getHitpoints() <= 0 || ::Legends.S.skillEntityAliveCheck(_tag.target)) {
			// ::logDebug("legend_enraged_hyena_bite_skill: Attack missed or target is dead");
			return;
		}

		// Schedule retreat
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 300, this.onRetreatStart.bindenv(this), _tag);
	}

	function onRetreatStart(_tag) {
		// ::logDebug("legend_enraged_hyena_bite_skill: onRetreatStart _tag= " + _tag);

		for (local i = 0; i < Const.Tactical.DustParticles.len(); i++) {
			Tactical.spawnParticleEffect(
				false,
				Const.Tactical.DustParticles[i].Brushes,
				_tag.actor.getTile(),
				Const.Tactical.DustParticles[i].Delay,
				Const.Tactical.DustParticles[i].Quantity,
				Const.Tactical.DustParticles[i].LifeTimeQuantity,
				Const.Tactical.DustParticles[i].SpawnRate,
				Const.Tactical.DustParticles[i].Stages
			);
		}

		// Retreat to original tile
		_tag.actor.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		this.Tactical.getNavigator().teleport(_tag.actor, _tag.originTile, null, null, false, 2.0);

		// Schedule drag
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 100, this.onDragStart.bindenv(this), _tag);
	}

	function onDragStart(_tag) {
		// ::logDebug("legend_enraged_hyena_bite_skill: onDragStart _tag= " + _tag);

		if (::Legends.S.skillEntityAliveCheck(_tag.target)) {
			::logError("legend_enraged_hyena_bite_skill: Target is no longer valid");
			return;
		}

		_tag.target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		this.Tactical.getNavigator().teleport(_tag.target, _tag.tile1, null, null, false, 1.0);

		if (!_tag.actor.isHiddenToPlayer()) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_tag.actor) + " drags " + this.Const.UI.getColorizedEntityName(_tag.target) + " back!");
		}

		// Apply grab effect and spawn icon
		_tag.skill.spawnIcon("legend_enraged_hyena_bite_effect", _tag.target.getTile());
		::Legends.Effects.grant(_tag.target, ::Legends.Effect.LegendEnragedHyenaBite, function(_effect) {
			if ("setHyena" in _effect) {
				_effect.setHyena(_tag.actor);
			} else {
				::logError("legend_enraged_hyena_bite_skill: effect has no setHyena function");
			}
		}.bindenv(this));

		::Legends.Effects.grant(_tag.actor, ::Legends.Effect.LegendEnragedHyenaGrip);
	}

});
