this.legend_named_whip_bleed_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Bonus = 0
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendNamedWhipBleed);
		this.m.Order = ::Const.SkillOrder.Item;
		this.m.IsStacking = true;
		this.m.IsWeaponSkill = true;
		this.m.IsHidden = true;
	}

	function setBonus(_bonus) {
		this.m.Bonus = _bonus;
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (_skill == null || _skill.m.IsWeaponSkill == false || !_skill.isAttack() || _skill.getItem() == null || this.getItem() == null || _skill.getItem().getInstanceID() != this.getItem().getInstanceID()) {
			return;
		}

		if (!_targetEntity.getCurrentProperties().IsImmuneToBleeding && ::Math.rand(0, 100) <= this.m.Bonus) {
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Bleeding, function (_effect) {
				if (_skill.getContainer().getActor().getFaction() == ::Const.Faction.Player) {
					_effect.setActor(this.getContainer().getActor());
				}
				_effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
			}.bindenv(this));
		}
	}
});
