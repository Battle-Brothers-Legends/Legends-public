if (!("Backgrounds" in ::Legends)) {
	::Legends.Backgrounds <- {};
}

::Legends.Backgrounds.getContainer <- function (_target, _onError = "") {
	if (_target == null) {
		::logError("_target == null " + _onError);
		throw "_target == null";
	}
	if (::MSU.isKindOf(_target, "skill")) {
		return _target.getContainer();
	}
	if (::MSU.isKindOf(_target, "skill_container")) {
		return _target;
	}
	if (::MSU.isKindOf(_target, "actor")) {
		return _target.getSkills();
	}
	if (::MSU.isKindOf(_target, "character_background")) {
		return _target.getContainer();
	}
	if (::MSU.isKindOf(_target, "item")) {
		return ::Legends.Backgrounds.getContainer(_target.getContainer().getActor());
	}
	::logError("Unsupported _target class " + _onError);
	throw "Unsupported _target class";
}

/**
 * Helper function, that checks existence of skill on _target, adds it if needed,
 * with optional lambda to modify skill on the fly.
 * Can be used to modify existing backgrounds too.
 *
 * Example here:
 *
 * ::Legends.Backgrounds.grant(this, ::Legends.Background.LegendAlchemist, function (_skill) {
 *		_skill.m.Field = false;
 *	}.bindenv(this));
 *
 * bindenv is optional, if not used `this` inside function points to ::Legends.Backgrounds table
 *
 * Returns newly added skill
 */
::Legends.Backgrounds.grant <- function (_target, _def, _applyFn = null) {
	local container = ::Legends.Backgrounds.getContainer(_target, "on grant");
	local skillDef = ::Legends.Backgrounds.BackgroundDefObjects[_def];

	local skill = null;
	local hasSkill = container.hasSkill(skillDef.ID);

	// When granting to an item, always create a new skill instance so each weapon
	// has its own skill in m.SkillPtrs. This handles dual wielding (both identical
	// weapons and different weapons that share skills).
	if (::MSU.isKindOf(_target, "item")) {
		skill = ::new(skillDef.Script);
		if (skill == null) {
			return null;
		}
		if (_applyFn != null) {
			_applyFn(skill);
		}
		_target.addSkill(skill);
		skill.setContainer(container);
		return skill;
	}

	if (hasSkill) {
		skill = container.getSkillByID(skillDef.ID);
	} else {
		skill = ::new(skillDef.Script);
	}
	// Prevents an issue when deserializing dual wield weapons and having ambidextrous
	// which grants double swing active - not sure how to fix it properly yet
	if (skill == null) {
		return null;
	}
	if (_applyFn != null) {
		_applyFn(skill);
	}
	container.add(skill);
	return skill;
}

::Legends.Backgrounds.get <- function (_target, _def) {
	local container = ::Legends.Backgrounds.getContainer(_target, "on get");
	local id = ::Legends.Backgrounds.getID(_def);
	if (container.hasSkill(id)) {
		return container.getSkillByID(id);
	}
	return null;
}

::Legends.Backgrounds.getName <- function (_def) {
	return ::Legends.Backgrounds.BackgroundDefObjects[_def].Name;
}

::Legends.Backgrounds.has <- function (_target, ...) {
	local container = ::Legends.Backgrounds.getContainer(_target, "on has");
	if (container.getBackground() == null)
		return false;
	return container.getBackground().getID() == ::Legends.Backgrounds.getID(_def);
}

::Legends.Backgrounds.hasAny <- function (_target, ...) {
	local container = ::Legends.Backgrounds.getContainer(_target, "on hasAny");
	local arr = vargv;
	if (typeof vargv[0] == "array")
		arr = vargv[0];
	return ::Legends.S.any(arr, @(_def) ::Legends.Backgrounds.has(container, _def));
}

::Legends.Backgrounds.remove <- function (_target, _def) {
	local container = ::Legends.Backgrounds.getContainer(_target, "on remove");
	container.removeByID(::Legends.Backgrounds.getID(_def));
}

::Legends.Backgrounds.new <- function (_def) {
	return ::new(::Legends.Backgrounds.BackgroundDefObjects[_def].Script);
}

::Legends.Backgrounds.onCreate <- function (_target, _def) {
	local defs = ::Legends.Backgrounds.BackgroundDefObjects[_def];
	_target.m.ID = defs.ID;
	_target.m.Name = defs.Name;
}
