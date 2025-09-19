this.perk_legend_push_the_advantage <- this.inherit("scripts/skills/skill", {
	m = {
		HighBonus = [
			::Legends.Effect.Debilitated,
			::Legends.Effect.LegendTackled
		],
		LowBonus = [
			::Legends.Effect.Dazed,
			::Legends.Effect.Distracted,
			::Legends.Effect.LegendBaffled,
			::Legends.Effect.LegendParried,
			::Legends.Effect.LegendGrappled,
			::Legends.Effect.Net,
			::Legends.Effect.Rooted,
			::Legends.Effect.Shellshocked,
			::Legends.Effect.Sleeping,
			::Legends.Effect.Staggered,
			::Legends.Effect.Stunned,
			::Legends.Effect.Web,
			::Legends.Effect.Withered
		]
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

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if ( _targetEntity != null && (this.isBonusEligible(_skill, _targetEntity) || this.isLowerBonusEligible(_skill, _targetEntity)))
		{
			this.spawnIcon("perk_16", this.getContainer().getActor().getTile());
		}
	}

	function calculateBonus ( _skill, _targetEntity )
	{
		
		local bonus = 0;

		foreach (effect in this.m.HighBonus)
		{
			if (_targetEntity.getSkills().hasEffect(effect))
			{
				bonus += 20;
			}
		}
		foreach (effect in this.m.LowBonus)
		{
			if (_targetEntity.getSkills().hasEffect(effect))
			{
				bonus += 10;
			}
		}

		return bonus;
	}

	function onBeforeTargetHit ( _skill, _targetEntity, _hitInfo )
	{
		if (_targetEntity != null && this.calculateBonus(_targetEntity) != 0) {
			this.spawnIcon("perk_16", this.getContainer().getActor().getTile());
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
			return;

		local bonus = this.calculateBonus(_targetEntity);
		_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.01 * bonus;
		_properties.HitChance[this.Const.BodyPart.Head] += bonus;
	}
});
