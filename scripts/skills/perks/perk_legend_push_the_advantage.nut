this.perk_legend_push_the_advantage <- this.inherit("scripts/skills/skill", {
	m = {
		EffectsToGiveBonus = [
			::Legends.Effect.Disarmed,
			::Legends.Effect.LegendParried,
			::Legends.Effect.Debilitated,
			::Legends.Effect.LegendTackled,
			::Legends.Effect.Dazed,
			::Legends.Effect.Distracted,
			::Legends.Effect.LegendBaffled,
			::Legends.Effect.LegendGrappled,
			::Legends.Effect.Net,
			::Legends.Effect.Rooted,
			::Legends.Effect.Shellshocked,
			::Legends.Effect.Sleeping,
			::Legends.Effect.Staggered,
			::Legends.Effect.Stunned,
			::Legends.Effect.Web,
			::Legends.Effect.Withered
		],
		FirstAttackDone = false
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendPushTheAdvantage);
		this.m.Icon = "ui/perks/onslaught_circle.png";
		this.m.IconDisabled = "ui/perks/onslaught_circle_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isBonusEligible( _targetEntity )
	{
		local targetSkills = _targetEntity.getSkills();
		foreach ( effect in this.m.EffectsToGiveBonus )
		{
			if ( targetSkills.hasEffect(effect) )
				return true;
		}
		return false;
	}

	function isAttackEligible (_skill)
	{
		local isH2h = _skill.getID == ::Legends.Actives.getID(::Legends.Active.HandToHand);
		local is1h = _skill.getItem() != null && _skill.getItem().isItemType(this.Const.Items.ItemType.Weapon) && _skill.getItem().isItemType(this.Const.Items.ItemType.OneHanded);
		if (!isH2h && !is1h)
			return false;

		return true;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (!_skill.isAttack())
			return;

		if (_skill.isRanged())
			return;

		if (this.m.FirstAttackDone)
			return;

		if (!this.isAttackEligible(_skill))
			return;

		local actor = this.getContainer().getActor();
		// actor.setFatigue(this.Math.max(0, actor.getFatigue() - this.Math.floor(_skill.getFatigueCost() * 0.2)));
		if (!_targetEntity.isAlive() || ("isDying" in _targetEntity && _targetEntity.isDying()))
			return;

		if (!_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendParried))
		{
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendParried);

			if (!actor.isHiddenToPlayer() && !_targetEntity.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " feinted " + this.Const.UI.getColorizedEntityName(_targetEntity) + " leaving them exposed!");
			}
		}

		this.m.FirstAttackDone = true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !this.isAttackEligible(_skill))
			return;

		if (!_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			if (this.isBonusEligible( _targetEntity ))
			{
				_properties.DamageTotalMult *= 1.1;
				_properties.DamageDirectAdd += 0.1;
			}
		}
	}
});
