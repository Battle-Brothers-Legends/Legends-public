this.legend_named_hammer_stun_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Bonus = 0
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendNamedHammerStun);
		this.m.Order = ::Const.SkillOrder.Item;
		this.m.IsWeaponSkill = true;
		this.m.IsHidden = true;
	}

	function setBonus(_bonus) {
		this.m.Bonus = _bonus;
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (_skill == null || _skill.m.IsWeaponSkill == false || !_skill.isAttack() || _skill.getItem() == null || _skill.getItem().getID() != this.getItem().getID()) {
			return;
		}

		local actor = this.getContainer().getActor();
		if (::Legends.S.isEntityNullOrDead(actor, _targetEntity)) {
			return;
		}

		if (!_targetEntity.getCurrentProperties().IsImmuneToStun && !_targetEntity.getSkills().hasEffect(::Legends.Effect.Stunned) && ::Math.rand(0, 100) <= this.m.Bonus) {
			local stun = ::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Stunned);

			if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer) {
				::Tactical.EventLog.log(stun.getLogEntryOnAdded(::Const.UI.getColorizedEntityName(actor), ::Const.UI.getColorizedEntityName(_targetEntity)));
			}
		}
	}
});
