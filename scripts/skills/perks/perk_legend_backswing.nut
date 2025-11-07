this.perk_legend_backswing <- this.inherit("scripts/skills/skill", {
	m = {
		IsEffectActive = false,
		Skills = [
			::Legends.Actives.getID(::Legends.Active.Swing),
			::Legends.Actives.getID(::Legends.Active.Thresh),
			::Legends.Actives.getID(::Legends.Active.CenserCastigate),
			::Legends.Actives.getID(::Legends.Active.Reap),
			::Legends.Actives.getID(::Legends.Active.RoundSwing),
			::Legends.Actives.getID(::Legends.Active.Shatter),
		]
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBackswing);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk | this.Const.SkillOrder.Any;
	}

	function isHidden()
	{
		return !this.m.IsEffectActive;
	}

	function getDescription()
	{
		return "Use your built up inertia to wreak havoc on the next swing.";
	}

	function onAfterUpdate(_properties)
	{
		if (!this.m.IsEffectActive)
			return;

		local skills = this.getContainer().getAllSkillsOfType(::Const.SkillType.Active);
		foreach (skill in skills)
		{
			if (this.m.Skills.find(skill.getID()) != null)
			{
				skill.m.FatigueCost *= 0.5;
				skill.m.ActionPointCost /= 2;
			}
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill == null || this.m.Skills.find(_skill.getID()) == null)
				return;

		this.m.IsEffectActive = !this.m.IsEffectActive;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == null || this.m.Skills.find(_skill.getID()) == null || !this.m.IsEffectActive)
			return;

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Swing))
			_properties.DamageTotalMult *= 0.75;
		else
			_properties.DamageTotalMult *= 0.5;
	}

	function onTurnEnd()
	{
		this.m.IsEffectActive = false;
	}

	function onWaitTurn()
	{
		this.m.IsEffectActive = false;
	}

	function onMovementFinished()
	{
		this.m.IsEffectActive = false;
	}
});
