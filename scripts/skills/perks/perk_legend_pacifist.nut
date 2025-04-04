this.perk_legend_pacifist <- this.inherit("scripts/skills/skill", {
	m = {
		ForcedToFight = null
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

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.isAttack())
			this.m.ForcedToFight = true;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		local actor = this.getContainer().getActor();
		if (actor == null)
			return;
		if (this.m.ForcedToFight != null)
		{
			actor.worsenMood(1.5, "Was forced to attack someone against their wishes");
			this.m.ForcedToFight = null;
		}
	}
});
