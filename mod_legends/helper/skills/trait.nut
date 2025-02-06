if (!("Traits" in ::Legends))
	::Legends.Traits <- {};

::Legends.Traits.getContainer <- function (_target, _onError = "") {
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
		return ::Legends.Traits.getContainer(_target.getContainer().getActor());
	::logError( "Unsupported _target class " + _onError);
	throw "Unsupported _target class";
}

/**
 * Helper function, that checks existence of trait on _target, adds it if needed,
 * with optional lambda to modify trait on the fly.
 * Can be used to modify existing traits too.
 *
 * Example here:
 *
 * ::Legends.Traits.grant(this, ::Legends.Trait.EagleEyes, function (_trait) {
 *		_trait.m.Field = false;
 *	}.bindenv(this));
 *
 * bindenv is optional, if not used `this` inside function points to ::Legends.Traits table
 *
 * Returns newly added trait
 */
::Legends.Traits.grant <- function (_target, _def, _applyFn = null) {
	local container = ::Legends.Traits.getContainer(_target, "on grant");
	local effectDef = ::Legends.Traits.TraitDefObjects[_def];

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

::Legends.Traits.getID <- function (_def) {
	return ::Legends.Traits.TraitDefObjects[_def].ID;
}

::Legends.Traits.get <- function (_target, _def) {
	local container = ::Legends.Traits.getContainer(_target, "on get");
	local id = ::Legends.Traits.getID(_def);
	if (container.hasSkill(id))
		return container.getSkillByID(id);
	return null;
}

::Legends.Traits.has <- function (_target, _def) {
	return ::Legends.Traits.getContainer(_target, "on has").hasSkill(::Legends.Traits.getID(_def));
}

::Legends.Traits.remove <- function (_target, _def) {
	local container = ::Legends.Traits.getContainer(_target, "on remove");
	container.removeByID(::Legends.Traits.getID(_def));
}

