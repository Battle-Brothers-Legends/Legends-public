this.legend_named_flail_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendNamedFlail);
		this.m.Order = ::Const.SkillOrder.Item;
		this.m.IsWeaponSkill = true;
		this.m.IsHidden = true;
	}

	function getTooltip() {
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function setBonus(_bonus) {}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (_skill == null || _skill.m.IsWeaponSkill == false || !_skill.isAttack() || _skill.getItem() == null || _skill.getItem().getID() != this.getItem().getID()) {
			return;
		}

		local actor = this.getContainer().getActor();
		if (::Legends.S.isEntityNullOrDead(actor, _targetEntity)) {
			return;
		}

		if (_bodyPart == ::Const.BodyPart.Head && !_targetEntity.getCurrentProperties().IsImmuneToDaze) {
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Dazed);
			if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer && !_targetEntity.isHiddenToPlayer()) {
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " struck a hit that leaves " + ::Const.UI.getColorizedEntityName(_targetEntity) + " dazed");
			}
		}
	}
});
