this.perk_legend_pacifist <- this.inherit("scripts/skills/skill", {
	m = {
		this.m.ForcedToFight = null;
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendPacifist);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


	function onUpdate( _properties )
	{
		_properties.IsContentWithBeingInReserve = true;
		_properties.BraveryMult *= 1.1;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack())
			this.m.ForcedToFight = true;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		if (this.m.ForcedToFight != null)
		{
			this.getContainer.getActor().worsenMood(1.5, "Was forced to attack someone agains their wishes");
			this.m.ForcedToFight = null;
		}
	}
});
