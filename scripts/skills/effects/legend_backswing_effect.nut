this.legend_backswing_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TimeAdded = 0
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendBackswing);
		this.m.Description = "Another swing will remove the rest of the reeds.";
		this.m.Icon = "ui/perks/feint_circle.png";
		this.m.IconMini = "feint_circle_mini";
		this.m.Overlay = "feint_circle_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%negative%]-50%[/color] Fatigue Cost for [color=#400080]Round Swing[/color], [color=#400080]Swing[/color], [color=#400080]Thresh[/color], [color=#400080]Reap[/color], [color=#400080]Castigate[/color]"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=%negative%]-50%[/color] Action Point cost for [color=#400080]Round Swing[/color], [color=#400080]Swing[/color], [color=#400080]Thresh[/color], [color=#400080]Reap[/color], [color=#400080]Castigate[/color]"
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%negative%]-50%[/color] Damage for [color=#400080]Round Swing[/color], [color=#400080]Thresh[/color], [color=#400080]Reap[/color], [color=#400080]Castigate[/color]"
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%negative%]-25%[/color] Damage for [color=#400080]Swing[/color]"
			}
		];
		return ret;
	}

	function onAdded()
	{
		this.m.TimeAdded = this.Time.getVirtualTimeF();
	}

	function onAfterUpdate(_properties)
	{
		if (!this.isBackswing())
			return;
		local skills = this.getContainer().getAllSkillsOfType(this.Const.SkillType.Active);
		foreach (skill in skills)
		{
			if (this.m.Skills.find(skill.getID()) != null)
			{
				skill.m.FatigueCostMult *= 0.5;
				skill.m.ActionPointCost /= 2;
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !_targetEntity.isAttackable())
			return;

		if (!this.m.IsGarbage && this.m.TimeAdded + 0.1 < this.Time.getVirtualTimeF() && !_targetEntity.isAlliedWith(this.getContainer().getActor()))
			this.removeSelf();
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.removeSelf();
	}
});
