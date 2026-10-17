this.legend_named_mace_stagger_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Bonus = 0
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendNamedMaceStagger);
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

	function setBonus(_bonus) {
		this.m.Bonus = _bonus;
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (_skill == null || _skill.m.IsWeaponSkill == false || !_skill.isAttack() || _skill.getItem() == null || _skill.getItem().getID() != this.getItem().getID()) {
			return;
		}

		local actor = this.getContainer().getActor();
		if (!::Legends.S.isEntityNullOrDead(actor, _targetEntity) && ::Math.rand(0, 100) <= this.m.Bonus) {
			local stagger = ::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Staggered);
			if (!_targetEntity.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer && !_targetEntity.getFlags().has("tail")) {
				::Tactical.EventLog.log(stagger.getLogEntryOnAdded(::Const.UI.getColorizedEntityName(actor), ::Const.UI.getColorizedEntityName(_targetEntity)));
			}
		}
	}
});
