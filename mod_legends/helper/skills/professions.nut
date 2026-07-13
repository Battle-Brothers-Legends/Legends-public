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
	local effectDef = ::Const.Professions.ProfessionDefObjects[_def];

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
	return ::Const.Professions.ProfessionDefObjects[_def].ID;
}

::Legends.Professions.get <- function (_target, _def) {
	local container = ::Legends.Professions.getContainer(_target, "on get");
	if (container.hasProfession(_def))
		return container.getSkillByID(::Legends.Professions.getID(_def));
	return null;
}

::Legends.Professions.has <- function (_target, _def) {
	return ::Legends.Professions.getContainer(_target, "on get").hasSkill(::Legends.Professions.getID(_def));
}

::Legends.Professions.remove <- function (_target, _def) {
	local container = ::Legends.Professions.getContainer(_target, "on remove");
	if (container.hasProfession(_def))
		container.removeByID(::Legends.Professions.getID(_def));
}

::Legends.Professions.new <- function (_def) {
	return ::new(::Const.Professions.ProfessionDefObjects[_def].Script);
}

::Legends.Professions.onCreate <- function (_profession, _professionDef) {
	local def = ::Const.Professions.ProfessionDefObjects[_professionDef];
	_profession.m.ID = def.ID;
	_profession.m.Name = ::Const.Strings.ProfessionName[def.Const];
	_profession.m.Description = ::Const.Strings.ProfessionDescription[def.Const];
	_profession.m.Icon = def.Icon;
	_profession.m.IconDisabled = def.IconDisabled;
	_profession.m.Type = ::Const.SkillType.Profession;
	_profession.m.Order = ::Const.SkillOrder.Profession;
	_profession.m.IsActive = false;
	_profession.m.IsStacking = false;
	_profession.m.IsHidden = false;
}

::Legends.Professions.getProfessionEffect <- function (_def) {
	local roster = ::World.getPlayerRoster().getAll();
	local count = 0;

	foreach (bro in roster) {
		if (bro.getSkills().hasSkill(_def.ID)) {
			count++;
		}
	}
	local effect = 0.0;
	if (count > 0 && _def.ScalingArray.len() > 0) {
		local end = _def.ScalingArray.len() - 1;
		if (count <= end) {
			effect = _def.ScalingArray[count];
		} else {
			effect = _def.ScalingArray[end] * (1.0 + ((count - end) * _def.ScalingFactor));
		}
	}
	return effect;
}

::Legends.Professions.recalculateAllProfessions <- function() {
    foreach (prof in ::Const.Professions.ProfessionDefObjects) {
		if ("ScalingArray" in prof) {
        	local effect = ::Legends.Professions.getProfessionEffect(prof);    
        	::World.Assets.m.ProfessionEffect[prof.Const] = effect;
		}
    }
}
