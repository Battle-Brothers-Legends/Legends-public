this.perk_legend_hammer_the_gap <- this.inherit("scripts/skills/skill", {
	m = {
		PreviousTile = null,
		Bonus = 0
	},
	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHammerTheGap);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!_skill.isUsingHitchance()) {
			return;
		}

		if (!_skill.isAOE()) {
			return;
		}

		if (_targetEntity == null) {
			return;
		}

		if (_targetEntity.getTile() == null) {
			return;
		}

		if (_targetEntity.getTile() != this.m.PreviousTile) {
			return;
		}

		local bonus = this.Math.min(10, this.m.Bonus * 5);
		_properties.MeleeSkill += bonus;
		_properties.RangedSkill += bonus;
		if (!_skill.isUsingHitchance())
			return;
		if (!_skill.isRanged()) {
			_skill.m.HitChanceBonus += bonus;
		}
		else if (_skill.isRanged()) {
			if (::MSU.isIn("AdditionalAccuracy", _skill.m, true)) {
				_skill.m.AdditionalAccuracy += bonus;
			} else {
				::logError("AdditionalAccuracy not found in skill")
			}
		}
	}
	
	function onCombatStarted() {
		this.m.Bonus = 0;
		this.m.PreviousTile = null;
	}

	function onCombatFinished() {
		this.m.Bonus = 0;
		this.m.PreviousTile = null;
	}

	function onAnySkillExecuted (_skill, _targetTile, _targetEntity, _forFree) {
		if (this.m.PreviousTile == null || this.m.PreviousTile != _targetTile) {
			this.m.PreviousTile = _targetTile;
			this.m.Bonus = 1;
		}
		else {
			this.m.Bonus += 1;
		}
	}
});

