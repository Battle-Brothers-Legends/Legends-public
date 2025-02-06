if (!("Actives" in ::Legends))
	::Legends.Actives <- {};

::Legends.Actives.getContainer <- function (_target, _onError = "") {
	local container = null;
	if (_target == null) {
		::logError( "_target == null " + _onError);
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
		return ::Legends.Actives.getContainer(_target.getContainer().getActor());
	::logError( "Unsupported _target class " + _onError);
	throw "Unsupported _target class";
}

/**
 * Helper function, that checks existence of skill on _target, adds it if needed,
 * with optional lambda to modify skill on the fly.
 * Can be used to modify existing actives too.
 *
 * Example here:
 *
 * ::Legends.Actives.grant(this, ::Legends.Active.LegendBaffled, function (_skill) {
 *		_skill.m.Field = false;
 *	}.bindenv(this));
 *
 * bindenv is optional, if not used `this` inside function points to ::Legends.Actives table
 *
 * Returns newly added skill
 */
::Legends.Actives.grant <- function (_target, _def, _applyFn = null) {
	local container = ::Legends.Actives.getContainer(_target, "on grant");
	local skillDef = ::Legends.Actives.ActiveDefObjects[_def];

	local skill = null;
	local hasSkill = container.hasSkill(skillDef.ID);
	if (hasSkill) {
		skill = container.getSkillByID(skillDef.ID);
	} else {
		skill = ::new(skillDef.Script);
	}
	if (_applyFn != null)
		_applyFn(skill);
	// actives by default should be tied to items if _target is an item
	if (::MSU.isKindOf(_target, "item")) {
		if (!hasSkill)
			_target.addSkill(skill);
	} else
		container.add(skill);
	return skill;
}

::Legends.Actives.getID <- function (_def) {
	return ::Legends.Actives.ActiveDefObjects[_def].ID;
}

::Legends.Actives.get <- function (_target, _def) {
	local container = ::Legends.Actives.getContainer(_target, "on get");
	local id = ::Legends.Actives.getID(_def);
	if (container.hasSkill(id))
		return container.getSkillByID(id);
	return null;
}

::Legends.Actives.has <- function (_target, _def) {
	return ::Legends.Actives.getContainer(_target, "on has").hasSkill(::Legends.Actives.getID(_def));
}

::Legends.Actives.remove <- function (_target, _def) {
	local container = ::Legends.Actives.getContainer(_target, "on remove");
	container.removeByID(::Legends.Actives.getID(_def));
}

::Legends.Actives.new <- function(_def) {
	return ::new(::Legends.Actives.ActiveDefObjects[_def].Script);
}

::Legends.Actives.onCreate <- function(_target, _def) {
	local defs = ::Legends.Actives.ActiveDefObjects[_def];
	_target.m.ID = defs.ID;
	_target.m.Name = defs.Name;
}
