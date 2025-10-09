this.perk_legend_backswing <- this.inherit("scripts/skills/skill", {
	m = {
		TimeAdded = 0
		Skills = [
			::Legends.Actives.getID(::Legends.Active.Swing),
			::Legends.Actives.getID(::Legends.Active.Thresh),
			::Legends.Actives.getID(::Legends.Active.CenserCastigate),
			::Legends.Actives.getID(::Legends.Active.Reap),
			::Legends.Actives.getID(::Legends.Active.RoundSwing)
		]
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendBackswing);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk | this.Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate(_properties)
	{
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

	function onAdded()
	{
		this.m.TimeAdded = this.Time.getVirtualTimeF();
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !_targetEntity.isAttackable())
			return;

		if (!this.m.IsGarbage && this.m.TimeAdded + 0.1 < this.Time.getVirtualTimeF() && !_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			if (_skill == null || this.m.Skills.find(_skill.getID()) == null || !this.isBackswing())
				return;
			if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Swing))
				_properties.DamageTotalMult *= 0.75;
			else
				_properties.DamageTotalMult *= 0.5;
			this.removeSelf();
		}
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

	function onWaitTurn()
	{
		this.removeSelf();
	}

	function onMovementFinished()
	{
		this.removeSelf();
	}
});
