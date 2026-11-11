this.perk_legend_strength_in_numbers <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendStrengthInNumbers);
	}

	function onUpdate( _properties ) {
		_properties.SurroundedBonusMult = 2.0;
	}

	// o.onAnySkillUsed <- function (_skill, _targetEntity, _properties) {
	// 	if (_targetEntity == null) {
	// 		return;
	// 	}

	// 	local surroundedCount = _targetEntity.getSurroundedCount();
	// 	if (surroundedCount > 0) {
	// 		_properties.DamageRegularMult *= 1.0 + surroundedCount * 0.05;
	// 		_properties.DamageDirectMult *= 1.0 + surroundedCount * 0.03;
	// 	}
	// }

});

