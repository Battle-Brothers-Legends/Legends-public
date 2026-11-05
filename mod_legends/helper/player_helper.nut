::Legends.Player <- {};

::Legends.Player.calculateExperienceOnKill <- function (_bro, _xp, _scale = true) {
	if (_scale) {
		_xp *= ::Const.Combat.GlobalXPMult;
		if ("State" in ::World && ::World.State != null) {
			_xp *= ::Const.Difficulty.XPMult[::World.Assets.getDifficulty()] * ::World.Assets.m.XPMult;

			if (_bro.m.Level < 12) {
				_xp *= (1 + ::World.Assets.m.ProfessionEffect.LegendDrillSergeant);
			}
		}
		// a lil experiment to see if this would make avatar starts more viable
		// if (::World.getPlayerRoster().getSize() < 3)
		// {
		// 	_xp *= (1.0 - (3 - ::World.getPlayerRoster().getSize()) * 0.15);
		// }
	}

	if (_bro.m.Level >= 12) {
		_xp *= ::Const.Combat.GlobalXPVeteranLevelMult;
	}

	_xp *= _bro.m.CurrentProperties.XPGainMult;

	return _xp;
}

::Legends.Player.getStatPotential <- function (_bro, _attribute) {
	local baseProp = 0;
	switch (_attribute) {
		case ::Const.Attributes.Hitpoints:
			baseProp = _bro.getBaseProperties().Hitpoints;
			break;
		case ::Const.Attributes.Bravery:
			baseProp = _bro.getBaseProperties().Bravery;
			break;
		case ::Const.Attributes.Fatigue:
			baseProp = _bro.getBaseProperties().Stamina;
			break;
		case ::Const.Attributes.Initiative:
			baseProp = _bro.getBaseProperties().Initiative;
			break;
		case ::Const.Attributes.MeleeSkill:
			baseProp = _bro.getBaseProperties().MeleeSkill;
			break;
		case ::Const.Attributes.RangedSkill:
			baseProp = _bro.getBaseProperties().RangedSkill;
			break;
		case ::Const.Attributes.MeleeDefense:
			baseProp = _bro.getBaseProperties().MeleeDefense;
			break;
		case ::Const.Attributes.RangedDefense:
			baseProp = _bro.getBaseProperties().RangedDefense;
			break;
	}

	local attributeMin = ::Const.AttributesLevelUp[_attribute].Min + ::Math.min(_bro.m.Talents[_attribute], 2);
	local attributeMax = ::Const.AttributesLevelUp[_attribute].Max;
	if (_bro.m.Talents[_attribute] == 3) {
		attributeMax += 1;
	}
	local levelUps = ::Math.max(12 - _bro.getLevel() + _bro.getLevelUps(), 0);
	local min = baseProp + attributeMin * levelUps;
	local max = baseProp + attributeMax * levelUps;

	return {
		min = min,
		max = max,
		avg = (min + max) / 2
	};
}
