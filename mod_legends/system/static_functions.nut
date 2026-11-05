::Legends.S <- {};

::Legends.S.isNull <- ::MSU.isNull;

::Legends.S.randomizeFractionToInt <- @(_value)((_value * 100).tointeger() + ::Math.rand(0, 99)) / 100;

::Legends.S.getClosestSettlement <- function (_predicate = @(_, _town)true) {
	local towns = ::World.EntityManager.getSettlements().filter(_predicate);
	if (towns.len() == 0) {
		return null;
	}
	local playerTile = ::World.State.getPlayer().getTile();
	towns.sort(@(a, b) playerTile.getDistanceTo(b.getTile()) <=> playerTile.getDistanceTo(a.getTile()));
	return towns.top();
}

::Legends.S.isEntityMovementDisabled <- function (_entity) {
	local properties = _entity.getCurrentProperties();
	return properties.IsStunned || properties.IsRooted;
}

::Legends.S.isEntityNullOrDead <- function (_entity, _otherEntity = 0) {
	if (::Legends.S.isNull(_entity) || !_entity.isAlive() || _entity.isDying()) {
		return true;
	}
	if (_otherEntity == 0) {
		return false;
	}
	if (::Legends.S.isNull(_otherEntity) || !_otherEntity.isAlive() || _otherEntity.isDying()) {
		return true;
	}
	return false;
}

::Legends.S.scaleBaseProperties <- function (_properties) {
	if (::Tactical.State.isScenarioMode()) {
		return;
	}
	local daysToScale = ::World.getTime().Days - ::Legends.Difficulty.DayScaling[::World.Assets.getCombatDifficulty()];
	if (daysToScale > 0) {
		local bonus = ::Math.floor(daysToScale / 20.0);
		_properties.MeleeSkill += bonus;
		_properties.RangedSkill += bonus;
		_properties.MeleeDefense += ::Math.floor(bonus / 2);
		_properties.RangedDefense += ::Math.floor(bonus / 2);
		_properties.Hitpoints += ::Math.floor(bonus * 2);
		_properties.Initiative += ::Math.floor(bonus / 2);
		_properties.Stamina += bonus;
		//	b.XP += ::Math.floor(bonus * 4);
		_properties.Bravery += bonus;
		_properties.FatigueRecoveryRate += ::Math.floor(bonus / 4);
	}
}

::Legends.S.getToolEfficiency <- function () {
	// Sum combined tool efficiency modifier (eg +4 from Tool Drawers) from all brothers
	local toolEfficiencyModifier = 0;
	foreach (bro in ::World.getPlayerRoster().getAll()) {
		toolEfficiencyModifier += bro.getToolEfficiencyModifier();
	}
	toolEfficiencyModifier += ::World.Assets.m.ProfessionEffect.LegendSpareParts;
	// Repair tent adds ~25% efficiency (yields ~20 dura per tool instead of 15 ie. 33% increase).
	if (::World.Retinue.hasFollower(::Legends.Camp.Upgrades[::Legends.Camp.CampBuildings.Repair])) {
		toolEfficiencyModifier += 25;
	}
	// Cap efficiency at 50%
	return ::Math.maxf(0.5, (100.0 - toolEfficiencyModifier) / 100.0);
}

::Legends.S.applyBleed <- function (_target, _actor, _hpBefore, _soundsA, _soundsB, _damage = 0, _effect = ::Legends.Effect.Bleeding, _bypassHitpointsCheck = false) {
	local damage = (_damage > 0 ? _damage : (_actor.getCurrentProperties().IsSpecializedInCleavers ? 10 : 5));

	if (::Legends.S.isEntityNullOrDead(_target)) {
		local sound = ((_target.getFlags().has("tail") || !_target.getCurrentProperties().IsImmuneToBleeding) ? _soundsA[::Math.rand(0, _soundsA.len() - 1)] : _soundsB[::Math.rand(0, _soundsB.len() - 1)]);
		::Sound.play(sound, ::Const.Sound.Volume.Skill, _actor.getPos());
	} else if (!_target.getCurrentProperties().IsImmuneToBleeding && (_hpBefore - _target.getHitpoints() >= ::Const.Combat.MinDamageToApplyBleeding || _bypassHitpointsCheck)) {
		::Legends.Effects.grant(_target, _effect, function (_effect) {
			if (_actor.getFaction() == ::Const.Faction.Player) {
				_effect.setActor(_actor);
			}
			_effect.setDamage(damage);
		}.bindenv(this));
		::Sound.play(_soundsA[::Math.rand(0, _soundsA.len() - 1)], ::Const.Sound.Volume.Skill, _actor.getPos());
	} else {
		::Sound.play(_soundsB[::Math.rand(0, _soundsB.len() - 1)], ::Const.Sound.Volume.Skill, _actor.getPos());
	}
}

::Legends.S.oneOf <- function (_value, ...) {
	if (vargv.len() == 0) {
		::logError("::Legends.S.oneOf used with empty args, returning false");
		return false;
	}
	local arr = vargv;
	if (typeof vargv[0] == "array") {
		arr = vargv[0];
	}
	return ::Legends.Array.any(arr, @(_val) _val == _value);
}

// it's intended to use with .pop() when filling, so the sort is opposite of what it would normally be
::Legends.S.getEmptySlotsInFormation <- function () {
	local formation = ::World.getPlayerRoster().getAll().filter(@(_, _bro) ! _bro.isInReserves()).map(@(_bro) _bro.getPlaceInFormation());
	local ret = [];
	for (local i = 0; i < 27; i++) {
		if (formation.find(i) == null) {
			ret.push(i);
		}
	}
	ret.sort(function (a, b) {
		local rowA = a / 9, rowB = b / 9, colA = a % 9, colB = b % 9;
		if (rowA != rowB) {
			// prefer further rows
			return rowA - rowB;
		}
		local distA = ::Math.abs(colA - 4);
		local distB = ::Math.abs(colB - 4);
		return distB - distA; // prefer closer to center of row
	});
	return ret;
}

::Legends.S.setSounds <- @(_prefix, _count = 1, _startIndex = 1, _suffix = ".wav") array(_count).map(@(_) format(_prefix + "_%02d" + _suffix, _startIndex++));

// unused
/*::Legends.S.getNeighbouringActors <- function (_tile) {
	local actors = [];
	for (local i = 0; i < 6; i++) {
		if (_tile.hasNextTile(i)) {
			local next = _tile.getNextTile(i);
			if (next.IsOccupiedByActor && ::Math.abs(next.Level - _tile.Level) <= 1) {
				actors.push(next.getEntity());
			}
		}
	}
	return actors;
}
::Legends.S.getOverlappingNeighbourActors <- function (_actor, _secondActor) {
	local firstActorEntities = ::Legends.S.getNeighbouringActors(_actor.getTile());
	local overlaps = [];
	foreach (entity in ::Legends.S.getNeighbouringActors(_secondActor.getTile())) {
		if (firstActorEntities.find(entity) != null) {
			overlaps.push(entity);
		}
	}
	return overlaps;
}
::Legends.S.isInZocWithActor <- function (_actor, _secondActor) {
	if (::Legends.S.isEntityNullOrDead(_secondActor)) {
		return false;
	}
	if (_secondActor.isNonCombatant()) {
		return false;
	}
	if (_secondActor.isAlliedWith(_actor)) {
		return false;
	}
	if (!_secondActor.m.IsUsingZoneOfControl) {
		return false;
	}
	if (!_secondActor.getCurrentProperties().IsStunned || !_secondActor.isArmedWithRangedWeapon()) {
		return false;
	}
	return true;
}*/

// TODO remove with 19.6 tbd
::Legends.S.fadeForDarkBackground <- function (_text) {
	::logWarning("Legends.S.fadeForDarkBackground deprecated, will be removed in 19.6");
	return ::Const.UI.getColorized(_text, ::Const.UI.Color.getFadeDarkBackgroundValue());
};

// TODO remove with 19.6 tbd
::Legends.S.getChangingWord <- function (_value) {
	::logWarning("Legends.S.getChangingWord deprecated, will be removed in 19.6");
	return (_value >= 0 ? "increase" : "decrease");
};

// TODO remove with 19.6 tbd
::Legends.S.hasItemFlag <- function (_text) {
	::logWarning("Legends.S.hasItemFlag deprecated, will be removed in 19.6, use ::Legends.Items.hasItemFlag instead");
	return ::Legends.Items.hasItemFlag(_text);
};

// TODO remove with 19.6 tbd
::Legends.S.logArmor <- function (_armor) {
	::logWarning("Legends.S.logArmor deprecated, will be removed in 19.6, use ::Legends.Items.logArmor instead");
	return ::Legends.Items.logArmor(_armor);
};

// TODO remove with 19.6 tbd
::Legends.S.logHelmet <- function (_helmet) {
	::logWarning("Legends.S.logHelmet deprecated, will be removed in 19.6, use ::Legends.Items.logHelmet instead");
	return ::Legends.Items.logHelmet(_helmet);
};

// TODO remove with 19.6 tbd
::Legends.S.skillEntityAliveCheck <- function (_entity, _otherEntity = 0) {
	::logWarning("Legends.S.skillEntityAliveCheck deprecated, will be removed in 19.6, use ::Legends.S.isEntityNullOrDead instead");
	return ::Legends.S.isEntityNullOrDead(_entity, _otherEntity);
}

// TODO remove with 19.6 tbd
::Legends.S.isCharacterWeaponSpecialized <- function (_properties, _weapon) {
	::logWarning("Legends.S.isCharacterWeaponSpecialized deprecated, will be removed in 19.6, use ::Legends.Weapons.isCharacterWeaponSpecialized instead");
	return ::Legends.Weapons.isCharacterWeaponSpecialized(_properties, _weapon);
}

// TODO remove with 19.6 tbd
::Legends.S.patternIsInText <- function (pattern, text) {
	::logWarning("Legends.S.patternIsInText deprecated, will be removed in 19.6, use ::Legends.Text.isPatternInText instead");
	return ::Legends.Text.isPatternInText(pattern, text);
}

// TODO remove with 19.6 tbd
::Legends.S.getSign <- function (_value) {
	::logWarning("Legends.S.getSign deprecated, will be removed in 19.6, use ::Legends.Text.getSign instead");
	return ::Legends.Text.getSign(_value);
}

// TODO remove with 19.6 tbd
::Legends.S.colorize <- function (_valueString, _value, _threshold = 0) {
	::logWarning("Legends.S.colorize deprecated, will be removed in 19.6, use ::Legends.Text.colorize instead");
	return ::Legends.Text.colorize(_valueString, _value, _threshold = 0);
}
