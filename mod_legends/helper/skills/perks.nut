if (!("Perks" in ::Legends))
	::Legends.Perks <- {};

::Legends.Perks.getContainer <- function (_target, _onError = "") {
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
		return ::Legends.Perks.getContainer(_target.getContainer().getActor());
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
 * ::Legends.Perks.grant(this, ::Legends.Perk.NineLives, function (_perk) {
 *		_perk.m.Property = false;
 *	}.bindenv(this));
 *
 * bindenv is optional, if not used `this` inside function points to ::Legends.Perks table
 *
 * Returns newly added perk
 */
::Legends.Perks.grant <- function (_target, _def, _applyFn = null) {
	local container = ::Legends.Perks.getContainer(_target, "on grant");
	local effectDef = ::Const.Perks.PerkDefObjects[_def];

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

::Legends.Perks.getID <- function (_def) {
	return ::Const.Perks.PerkDefObjects[_def].ID;
}

::Legends.Perks.get <- function (_target, _def) {
	local container = ::Legends.Perks.getContainer(_target, "on get");
	if (container.hasPerk(_def))
		return container.getSkillByID(::Legends.Perks.getID(_def));
	return null;
}

::Legends.Perks.has <- function (_target, _def) {
	return ::Legends.Perks.getContainer(_target, "on get").hasSkill(::Legends.Perks.getID(_def));
}

::Legends.Perks.remove <- function (_target, _def) {
	local container = ::Legends.Perks.getContainer(_target, "on remove");
	if (container.hasPerk(_def))
		container.removeByID(::Legends.Perks.getID(_def));
}

::Legends.Perks.blueprint <- function (_def) {
	return { Scripts = [::Const.Perks.PerkDefObjects[_def].Script] };
}

::Legends.Perks.onCreate <- function (_perk, _perkDef) {
	local def = ::Const.Perks.PerkDefObjects[_perkDef];
	_perk.m.ID = def.ID;
	_perk.m.Name = ::Const.Strings.PerkName[def.Const];
	_perk.m.Description = ::Const.Strings.PerkDescription[def.Const];
	_perk.m.Icon = def.Icon;
	_perk.m.IconDisabled = def.IconDisabled;
	_perk.m.Type = ::Const.SkillType.Perk;
	_perk.m.Order = ::Const.SkillOrder.Perk;
	_perk.m.IsActive = false;
	_perk.m.IsStacking = false;
	_perk.m.IsHidden = false;
}
