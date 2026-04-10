this.legend_RSW_accuracy <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRswAccuracy);
		this.m.Description = "Rune Sigil: Accuracy";
		this.m.Icon = "ui/rune_sigils/legend_rune_sigil.png";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties ) {
		if (_skill.isAttack() && _skill.getItem() != null && _skill.getItem().getID() == this.getItem().getID()) {
			_properties.MeleeSkill += this.getItem().getRuneBonus1();
			_properties.RangedSkill += this.getItem().getRuneBonus2();
			if (!_skill.isUsingHitchance())
				return;
			if (!_skill.isRanged())
			{
				_skill.m.HitChanceBonus += this.getItem().getRuneBonus1();
			}
			else if (_skill.isRanged())
			{
				if (::MSU.isIn("AdditionalAccuracy", _skill.m, true)) {
					_skill.m.AdditionalAccuracy += this.getItem().getRuneBonus2();
				} else {
					::logError("AdditionalAccuracy not found in skill")
				}
			}
		}
	}
});
