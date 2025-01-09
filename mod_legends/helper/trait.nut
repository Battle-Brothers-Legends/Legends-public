if (!("Traits" in ::Legends))
	::Legends.Traits <- {};

::Legends.Traits.getContainer <- function (_target, _onError = "") {
	local container = null;
	if (_target == null) {
		::logError( "_target == null " + _onError);
		throw "_target == null";
	}
	if (::isKindOf(_target, "skill"))
		return _target.getContainer();
	if (::isKindOf(_target, "skill_container"))
		return _target;
	if (::isKindOf(_target, "actor"))
		return _target.getSkills();
	if (::isKindOf(_target, "character_background"))
		return _target.getContainer();
	if (::isKindOf(_target, "item"))
		return ::Legends.Perks.getContainer(_target.getContainer().getActor())
	::logError( "Unsupported _target class " + _onError);
	throw "Unsupported _target class";
}

/**
 * Helper function, that checks existence of trait on _target, adds it if needed,
 * with optional lambda to modify trait on the fly.
 * Can be used to modify existing traits too.
 *
 * Returns newly added trait
 */
::Legends.Traits.grant <- function (_target, _def, _applyFn = null) {
	local container = ::Legends.Traits.getContainer(_target, "on grant");
	local traitDef = ::Legends.Traits.TraitDefObjects[_def];

	if (container.hasSkill(traitDef.ID)) {
		local trait = container.getSkillByID(traitDef.ID);
		if (_applyFn != null)
			_applyFn(trait);
		return trait;
	} else {
		local trait = ::new(traitDef.Script);
		if (_applyFn != null)
			_applyFn(trait);
		container.add(trait);
		return trait;
	}
}

::Legends.Traits.getID <- function (_def) {
	return ::Legends.Traits.TraitDefObjects[_def].ID;
}

::Legends.Traits.get <- function (_target, _def) {
	local container = ::Legends.Traits.getContainer(_target, "on get");
	local id = ::Legends.Traits.getID(_def);
	if (container.hasSkill(id))
		return container.getSkillByID(id)
	return null;
}

::Legends.Traits.has <- function (_target, _def) {
	local container = ::Legends.Traits.getContainer(_target, "on has");
	return container.hasSkill(::Legends.Traits.getID(_def));
}

::Legends.Traits.remove <- function (_target, _def) {
	local container = ::Legends.Traits.getContainer(_target, "on remove");
	local id = ::Legends.Traits.getID(_def);
	if (container.hasSkill(id))
		container.removeByID(id)
}

