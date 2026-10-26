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
