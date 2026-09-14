::mods_hookExactClass("ai/tactical/behaviors/ai_attack_deathblow", function(o) {
	o.queryBestMeleeTarget = function ( _entity, _skill, _targets ) {
		for( local i = _targets.len() - 1; i >= 0; i = --i ) {
			local targetStatus = _targets[i].getSkills();
			local bonus = false;

			if (::Legends.S.isEntityMovementDisabled(_targets[i])) {
				bonus = true;
			}

			foreach ( skill in _skill.m.ApplicableSkills) {
				if (targetStatus.hasEffect(skill)) {
					bonus = true;
				}
			}
			if (!bonus) {
				_targets.remove(i);
			}
		}

		return this.behavior.queryBestMeleeTarget(_entity, _skill, _targets);
	}

	o.queryBestRangedTarget = function ( _entity, _skill, _targets, _maxRange = 0 ) {
		for( local i = _targets.len() - 1; i >= 0; i = --i ) {
			local targetStatus = _targets[i].getSkills();
			local bonus = false;

			if (::Legends.S.isEntityMovementDisabled(_targets[i])) {
				bonus = true;
			}

			foreach ( skill in _skill.m.ApplicableSkills) {
				if (targetStatus.hasEffect(skill)) {
					bonus = true;
				}
			}
			if (!bonus) {
				_targets.remove(i);
			}
		}

		return this.behavior.queryBestRangedTarget(_entity, _skill, _targets, _maxRange);
	}
});
