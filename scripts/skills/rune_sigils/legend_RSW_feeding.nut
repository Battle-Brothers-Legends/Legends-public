this.legend_RSW_feeding <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRswFeeding);
		this.m.Description = "Rune Sigil: Feeding";
		this.m.Icon = "ui/rune_sigils/legend_rune_sigil.png";
		this.m.Type = ::Const.SkillType.Special | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsHidden = true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if ( _skill == null || _skill.m.IsWeaponSkill == false )
			return;

		if (!_skill.isAttack())
			return;

		if (_skill.getItem() == null || this.getItem() == null)
			return;

		if (_skill.getItem().getInstanceID() != this.getItem().getInstanceID())
			return;

		if (_damageInflictedHitpoints <= 0)
			return;

		local drain = this.getItem().getRuneBonus1() / 100.0;
		local actor = this.getContainer().getActor();
		actor.setFatigue(::Math.max(0, actor.getFatigue() - ::Math.ceil(_damageInflictedHitpoints * drain)));
		::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " recovers " + ::Math.ceil(_damageInflictedHitpoints * drain) + " fatigue.");
	}
});
