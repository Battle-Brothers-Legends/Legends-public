::ModJimmysTooltips.ModHook.hook("scripts/entity/tactical/player", function(q){
	
	q.getTooltip = @(__original) function(_targetedWithSkill = null)
	{
		local actor = ::Tactical.TurnSequenceBar.getActiveEntity();

		//if (!::MSU.isNull(actor))
		//{
		//	actor.getSkills().onOtherActorTooltip(::ModJimmysTooltips.modTacticalTooltip(__original(_targetedWithSkill), _targetedWithSkill), this);
		//}
		return ::ModJimmysTooltips.modTacticalTooltip(__original(_targetedWithSkill), _targetedWithSkill, this);
	}

});
