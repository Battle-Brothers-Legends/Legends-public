this.perk_legend_pacifist <- this.inherit("scripts/skills/skill", {
	m = {
		ForcedToFight = false
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPacifist);
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
		if (actor != null && this.m.ForcedToFight)
		{
			actor.worsenMood(1.5, "Was forced to attack someone against their wishes");
			this.m.ForcedToFight = false;
		}
	}
});
