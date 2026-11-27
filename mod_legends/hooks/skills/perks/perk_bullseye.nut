::mods_hookExactClass("skills/perks/perk_bullseye", function(o) {
	o.m.Skills <- [
		::Legends.Actives.getID(::Legends.Active.LegendFullDraw),
		::Legends.Actives.getID(::Legends.Active.AimedShot)
	];
	o.onUpdate = function ( _properties )
	{
		_properties.RangedAttackBlockedChanceMult *= 0.33;
		_properties.Vision += 1;
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties ) {
		if (_skill != null) {
			foreach (skill in this.m.Skills) {
				if (_skill.getID() == skill) {
					_properties.RangedAttackBlockedChanceMult *= 0.0;
				}
			}
		}
	}
});