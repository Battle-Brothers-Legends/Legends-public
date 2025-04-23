this.perk_legend_backswing <- this.inherit("scripts/skills/skill", {
	m = {
		IsBackswing = false,
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
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function toggleBackswing()
	{
		this.m.IsBackswing = this.setBackswing(!this.m.IsBackswing);
	}

	function setBackswing(_bool)
	{
		this.m.IsBackswing = _bool;
	}

	function isBackswing()
	{
		this.m.IsBackswing;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill == null)
			return;

		if (this.m.Skills.find(_skill.getID()) == null)
			toggleBackswing();
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

	function onAnySkillUsed (_skill, _targetEntity, _properties)
	{
		if (_skill != null && this.m.Skills.find(_skill.getID()) != null && this.isBackswing())
			_properties.DamageTotalMult *= 0.5;
	}

	function onTurnEnd()
	{
		this.setBackswing(false);
	}

	function onWaitTurn()
	{
		this.setBackswing(false);
	}

	function onMovementFinished()
	{
		this.setBackswing(false);
	}

	function onCombatFinished()
	{
		this.setBackswing(false);
	}
});
