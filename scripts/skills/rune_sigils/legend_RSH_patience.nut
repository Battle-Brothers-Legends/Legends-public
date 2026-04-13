this.legend_RSH_patience <- this.inherit("scripts/skills/skill", {
	m = {
		Bonus = 0
	},
	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRshPatience);
		this.m.Description = "Rune Sigil: Patience";
		this.m.Icon = "ui/rune_sigils/legend_rune_sigil.png";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onUpdate (_properties) {
		if (this.getItem() == null)
			return;
		_properties.Initiative *= (1.0 + this.getItem().getRuneBonus1() * 0.01);
	}

	function onWaitTurn() {
		if (this.getItem() == null)
			return;
		this.m.Bonus = this.getItem().getRuneBonus2();
	}

	function onTurnEnd() {
		if (this.getItem() == null)
			return;
		this.m.Bonus = 0;
	}

	function onCombatFinished () {
		if (this.getItem() == null)
			return;
		this.m.Bonus = 0;
	}

	function onAnySkillUsed (_skill, _targetEntity, _properties) {
		if (this.m.Bonus != 0 && _skill.isAttack()) {
			if (!_skill.isUsingHitchance())
				return;
			if (!_skill.isRanged()) {
				_skill.m.HitChanceBonus += this.m.Bonus;
			} else if (_skill.isRanged() && ::MSU.isIn("AdditionalAccuracy", _skill.m, true)) {
				_skill.m.AdditionalAccuracy += this.m.Bonus;
			}
			this.m.Bonus = 0;
		}
	}
});
