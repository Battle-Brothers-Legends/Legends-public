if (!("Effects" in ::Legends))
	::Legends.Effects <- {};

::Legends.Effects.getContainer <- function (_target, _onError = "") {
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
		return ::Legends.Effects.getContainer(_target.getContainer().getActor());
	::logError( "Unsupported _target class " + _onError);
	throw "Unsupported _target class";
}

/**
 * Helper function, that checks existence of effect on _target, adds it if needed,
 * with optional lambda to modify effect on the fly.
 * Can be used to modify existing effects too.
 *
 * Example here:
 *
 * ::Legends.Effects.grant(this, ::Legends.Effect.LegendBaffled, function (_effect) {
 *		_effect.m.Field = false;
 *	}.bindenv(this));
 *
 * bindenv is optional, if not used `this` inside function points to ::Legends.Effects table
 *
 * Returns newly added effect
 */
::Legends.Effects.grant <- function (_target, _def, _applyFn = null) {
	local container = ::Legends.Effects.getContainer(_target, "on grant");
	local effectDef = ::Legends.Effects.EffectDefObjects[_def];

	local skill = null;
	if (container.hasSkill(effectDef.ID)) {
		skill = container.getSkillByID(effectDef.ID);
		if (skill.m.IsStacking) {
			skill = ::new(effectDef.Script);
		}
	} else {
		skill = ::new(effectDef.Script);
	}
	if (_applyFn != null)
		_applyFn(skill);
	container.add(skill);
	return skill;
}

::Legends.Effects.getID <- function (_def) {
	return ::Legends.Effects.EffectDefObjects[_def].ID;
}

::Legends.Effects.get <- function (_target, _def) {
	local container = ::Legends.Effects.getContainer(_target, "on get");
	local id = ::Legends.Effects.getID(_def);
	if (container.hasSkill(id))
		return container.getSkillByID(id);
	return null;
}

::Legends.Effects.has <- function (_target, _def) {
	return ::Legends.Effects.getContainer(_target, "on has").hasSkill(::Legends.Effects.getID(_def));
}

::Legends.Effects.remove <- function (_target, _def) {
	local container = ::Legends.Effects.getContainer(_target, "on remove");
	container.removeByID(::Legends.Effects.getID(_def));
}

::Legends.Effects.new <- function(_def) {
	return ::new(::Legends.Effects.EffectDefObjects[_def].Script);
}

::Legends.Effects.onCreate <- function(_target, _def) {
	local defs = ::Legends.Effects.EffectDefObjects[_def];
	_target.m.ID = defs.ID;
	_target.m.Name = defs.Name;
}
