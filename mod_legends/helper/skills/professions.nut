if (!("Professions" in ::Legends))
	::Legends.Professions <- {};

::Legends.Professions.getContainer <- function (_target, _onError = "") {
	if (_target == null) {
		::logError("_target == null " + _onError);
		throw "_target == null";
	}
	if (::MSU.isKindOf(_target, "skill"))
		return _target.getContainer();
	if (::MSU.isKindOf(_target, "skill_container"))
		return _target;
	if (::MSU.isKindOf(_target, "actor"))
		return _target.getSkills();
	if (::MSU.isKindOf(_target, "character_background"))
		return _target.getContainer();
	if (::MSU.isKindOf(_target, "item"))
		return ::Legends.Professions.getContainer(_target.getContainer().getActor());
	::logError("Unsupported _target class " + _onError);
	throw "Unsupported _target class";
}

/**
 * Helper function, that checks existence of profession on _target, adds it if needed,
 * with optional lambda to modify profession on the fly.
 * Can be used to modify existing professions too.
 *
 * Example here:
 *
 * ::Legends.Professions.grant(this, ::Legends.Profession.NineLives, function (_profession) {
 *		_profession.m.Property = false;
 *	}.bindenv(this));
 *
 * bindenv is optional, if not used `this` inside function points to ::Legends.Professions table
 *
 * Returns newly added profession
 */
::Legends.Professions.grant <- function (_target, _def, _applyFn = null) {
	local container = ::Legends.Professions.getContainer(_target, "on grant");
	local effectDef = ::Legends.Professions.ProfessionDefObjects[_def];

	local skill = null;
	if (container.hasSkill(effectDef.ID)) {
		skill = container.getSkillByID(effectDef.ID);
	} else {
		skill = ::new(effectDef.Script);
	}
	if (_applyFn != null)
		_applyFn(skill);
	container.add(skill);
	return skill;
}

::Legends.Professions.getID <- function (_def) {
	return ::Legends.Professions.ProfessionDefObjects[_def].ID;
}

::Legends.Professions.get <- function (_target, _def) {
	local container = ::Legends.Professions.getContainer(_target, "on get");
	if (container.hasProfession(_def))
		return container.getSkillByID(::Legends.Professions.getID(_def));
	return null;
}

::Legends.Professions.findById <- function (_professionID) {
	if (_professionID != null && _professionID in ::Legends.Professions.LookupMap) {
		return ::Legends.Professions.LookupMap[_professionID];
	}

	return null;
};

::Legends.Professions.has <- function (_target, _def) {
	return ::Legends.Professions.getContainer(_target, "on get").hasSkill(::Legends.Professions.getID(_def));
}

::Legends.Professions.remove <- function (_target, _def) {
	local container = ::Legends.Professions.getContainer(_target, "on remove");
	if (container.hasProfession(_def))
		container.removeByID(::Legends.Professions.getID(_def));
}

::Legends.Professions.new <- function (_def) {
	return ::new(::Legends.Professions.ProfessionDefObjects[_def].Script);
}

::Legends.Professions.onCreate <- function (_profession, _professionDef) {
	local def = ::Legends.Professions.ProfessionDefObjects[_professionDef];
	_profession.m.ID = def.ID;
	_profession.m.Name = def.Name;
	_profession.m.Description = def.Tooltip;
	_profession.m.Icon = def.Icon;
	_profession.m.IconDisabled = def.IconDisabled;
	_profession.m.Type = ::Const.SkillType.Profession;
	_profession.m.Order = ::Const.SkillOrder.Profession;
	_profession.m.IsActive = false;
	_profession.m.IsStacking = false;
	_profession.m.IsHidden = false;
}

// _excludedBro is a bro that is about to leave the company or lose the profession, but still counts at the time this is called
::Legends.Professions.getProfessionEffect <- function (_def, _additionalBros = 0, _excludedBro = null) {
    local count = ::World.getPlayerRoster().getAll().filter(@(_, _bro) _bro.getSkills().hasSkill(_def.ID) && (_excludedBro == null || _bro.getID() != _excludedBro.getID())).len();
    count += _additionalBros;
    local effect = 0.0;
    if (count > 0 && "ScalingArray" in _def) {
        local end = _def.ScalingArray.len() - 1;
        effect = count > end ? _def.ScalingArray[end] * (1.0 + ((count - end) * _def.ScalingFactor)) : _def.ScalingArray[count];
    }
    return effect;
}

::Legends.Professions.setProfessionEffect <- function (_def, _excludedBro = null) {
	::World.Assets.m.ProfessionEffect[_def.Const] = ::Legends.Professions.getProfessionEffect(_def, 0, _excludedBro);
}

::Legends.Professions.recalculateAllProfessions <- function() {
    foreach (prof in ::Legends.Professions.ProfessionDefObjects) {
		if ("ScalingArray" in prof) {
        	::Legends.Professions.setProfessionEffect(prof);
		}
    }
}

::Legends.Professions.DogBreederHitpoints <- 0.2;

::Legends.Professions.getAnimalSurvivalChance <- function (_additionalBros = 0) {
	local breeder = ::Legends.Professions.ProfessionDefObjects[::Legends.Profession.LegendDogBreeder];
	local barber = ::Legends.Professions.ProfessionDefObjects[::Legends.Profession.LegendButcherBarber];
	return ::Legends.Professions.getProfessionEffect({
		ID = breeder.ID,
		ScalingArray = barber.ScalingArray,
		ScalingFactor = barber.ScalingFactor
	}, _additionalBros);
}

// Called when an animal is unleashed from the item of its handler
::Legends.Professions.onAnimalDeployed <- function (_animal, _item) {
	if (::Legends.S.isNull(_item) || ::Legends.S.isNull(_item.getContainer()) || !("Assets" in ::World) || ::World.Assets == null) {
		return;
	}

	local handler = _item.getContainer().getActor();
	if (::Legends.S.isNull(handler) || handler.getFaction() != ::Const.Faction.Player || ::World.Assets.m.ProfessionEffect.LegendDogBreeder <= 0) {
		return;
	}

	local properties = _animal.getBaseProperties();
	local mult = 1.0 + ::Legends.Professions.DogBreederHitpoints;
	properties.Hitpoints = ::Math.round(properties.Hitpoints * mult);
	_animal.getSkills().update();
	_animal.setHitpoints(::Math.round(_animal.getHitpoints() * mult));
}

// Called before an unleashed animal dies. Without a fatality it has a chance to live
::Legends.Professions.onAnimalDowned <- function (_animal, _fatalityType) {
	if (_fatalityType != ::Const.FatalityType.None || ::Legends.S.isNull(_animal.m.Item) || _animal.getFaction() != ::Const.Faction.PlayerAnimals) {
		return;
	}

	if (!("Assets" in ::World) || ::World.Assets == null || ::Math.rand(1, 1000) > ::Legends.Professions.getAnimalSurvivalChance() * 1000) {
		return;
	}

	// the item still counts the animal as unleashed until the battle is over, so it can not be sent out again
	_animal.m.Item = null;
	::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_animal) + " is down, but will live");
}

// The camp station a character is at. On the march it is the one they would be at when making camp now, the Secondary when there is nothing to do at the Primary
::Legends.Professions.getCampStation <- function (_bro) {
	local camp = ::World.Camp;
	if (camp.isCamping() || camp.m.IsEscorting) {
		return _bro.getCampAssignment();
	}

	local secondary = _bro.getSecondaryCampAssignment();
	return secondary != null && camp.getActiveAssignment(_bro, false) == secondary ? secondary : _bro.getPrimaryCampAssignment();
}

// Called every hour. Each worker of a camp station adds 100% plus their working speed, the sum is split evenly between them
::Legends.Professions.updateExp <- function () {
	local exp = ::Legends.Professions.Exp;
	local roster = ::World.getPlayerRoster().getAll();

	foreach (station in exp.Stations) {
		local tent = ::World.Camp.getBuildingByID(station.ID);
		if (tent == null) {
			continue;
		}

		local workers = roster.filter(@(_, _bro) ::Legends.Professions.getCampStation(_bro) == station.ID);
		local total = 0.0;
		foreach (bro in workers) {
			total += 1.0 + bro.getCurrentProperties().Modifiers[station.Modifier];
		}

		// A station that is not at work, like on the march or a dangerous one while escorting, only grants the passive share
		local isWorking = ::World.Camp.canBuildingWorkCurrently(tent, true);
		foreach (bro in workers) {
			local share = total / workers.len() * (isWorking ? tent.getWorkEfficiency(bro) : exp.PassiveMult);
			bro.addProfessionExp(::Legends.Professions.has(bro, ::Legends.Profession.LegendScholar) ? share * exp.ScholarMult : share);
		}
	}
}
