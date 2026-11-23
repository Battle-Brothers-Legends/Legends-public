this.legend_RSW_bleeding <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRswBleeding);
		this.m.Description = "Rune Sigil: Bleeding";
		this.m.Icon = "ui/rune_sigils/legend_rune_sigil.png";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsHidden = true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor ) {
		if ( _skill == null || _skill.m.IsWeaponSkill == false )
			return;

		if (!_skill.isAttack())
			return;

		if (_skill.getItem() == null || this.getItem() == null)
			return;

		if (_skill.getItem().getInstanceID() != this.getItem().getInstanceID())
			return;

		if (::Legends.S.skillEntityAliveCheck(this.getContainer().getActor(), _targetEntity))
			return;

		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding)
			return;

		::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendRswBleedingEffect, function (_effect) {
			_effect.setActor(this.getContainer().getActor());
			_effect.setStats(this.getItem().getRuneBonus1(), this.getItem().getRuneBonus2());
		}.bindenv(this));

		if (!_targetEntity.isHiddenToPlayer()) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is bleeding.");
		}

	}
});
