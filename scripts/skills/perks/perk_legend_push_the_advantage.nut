this.perk_legend_push_the_advantage <- this.inherit("scripts/skills/skill", {
	m = {
		EffectsToGiveBonus = [
			::Legends.Effect.Sleeping,
			::Legends.Effect.Stunned,
			::Legends.Effect.Dazed,
			::Legends.Effect.LegendDazed,
			::Legends.Effect.Net,
			::Legends.Effect.LegendGrappled,
			::Legends.Effect.Staggered,
			::Legends.Effect.Web,
			::Legends.Effect.LegendBaffled,
			::Legends.Effect.Rooted,
			::Legends.Effect.Distracted,
			::Legends.Effect.Debilitated,
			::Legends.Effect.InsectSwarm,
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

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
			return;

		if ( !_targetEntity.isAlliedWith(this.getContainer().getActor()) )
		{
			if ( this.isBonusEligible( _targetEntity ) )
			{
				_properties.MeleeSkill += 10;
				_properties.RangedSkill += 10;
				_properties.HitChance[this.Const.BodyPart.Head] += 20;
			}
		}
	}

});
