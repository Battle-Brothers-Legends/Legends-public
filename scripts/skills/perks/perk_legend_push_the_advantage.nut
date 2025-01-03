this.perk_legend_push_the_advantage <- this.inherit("scripts/skills/skill", {
	m = {
		EffectsToGiveBonus = [
			"effects.sleeping",
			"effects.stunned",
			"effects.dazed",
			"effects.legend_dazed",
			"effects.net",
			"effects.legend_grappled",
			"effects.staggered",
			"effects.web",
			"effects.legend_baffled",
			"effects.rooted",
			"effects.distracted",
			"effects.debilitated",
			"effects.insect_swarm",
			"effects.debilitated"
		]
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendPushTheAdvantage);
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
			if ( targetSkills.hasSkill(effect) )
			{
				return true;
			}
		}

		return false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

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
