if (!("Perks" in ::Legends))
	::Legends.Perks <- {};

::Legends.Perks.getContainer <- function (_target) {
	local container = null;
	if (::isKindOf(_target, "skill_container"))
		container = _target;
	else if (::isKindOf(_target, "actor"))
		container = _target.getSkills();
	else
		throw "Unsupported _target class";
	return container;
}

/**
 * Helper function, that checks existence of perk on _target, adds it if needed,
 * with optional lambda to modify perk on the fly.
 * Can be used to modify existing perks too.
 *
 * Example here:
 *
 * ::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.NineLives, @(_perk) {
 *		_perk.IsRefundable = false;
 *	});
 */
::Legends.Perks.grant <- function (_target, _def, _applyFn = null) {
	local container = ::Legends.Perks.getContainer(_target);
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
