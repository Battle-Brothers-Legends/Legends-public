if (!("Perks" in ::Legends))
	::Legends.Perks <- {};

::Legends.Perks.getContainer <- function (_target, _onError = "") {
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
 * Helper function, that checks existence of perk on _target, adds it if needed,
 * with optional lambda to modify perk on the fly.
 * Can be used to modify existing perks too.
 *
 * Example here:
 *
 * ::Legends.Perks.grant(this, ::Legends.Perk.NineLives, @(_perk) {
 *		_perk.IsRefundable = false;
 *	});
 */
::Legends.Perks.grant <- function (_target, _def, _applyFn = null) {
	local container = ::Legends.Perks.getContainer(_target, "on grant");
	local perkDef = ::Const.Perks.PerkDefObjects[_def];

	if (container.hasPerk(_def)) {
		if (_applyFn != null)
			_applyFn(container.getSkillByID(perkDef.ID));
	} else {
		local perk = ::new(perkDef.Script);
		if (_applyFn != null)
			_applyFn(perk);
		container.add(perk);
	}
}

::Legends.Perks.getID <- function (_def) {
	return ::Const.Perks.PerkDefObjects[_def].ID;
}

::Legends.Perks.get <- function (_target, _def) {
	local container = ::Legends.Perks.getContainer(_target, "on get");
	if (container.hasPerk(_def))
		return container.getSkillByID(::Legends.Perks.getID(_def))
	return null;
}

::Legends.Perks.remove <- function (_target, _def) {
	local container = ::Legends.Perks.getContainer(_target, "on remove");
	if (container.hasPerk(_def))
		container.removeByID(::Legends.Perks.getID(_def))
}

::Legends.Perks.blueprint <- function (_def) {
	return { Scripts = [::Const.Perks.PerkDefObjects[_def].Script] }
}
