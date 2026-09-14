::ModJimmysTooltips.ModHook.hook("scripts/entity/tactical/actor", function(q){

	q.getTooltip = @(__original) function(_targetedWithSkill = null)
	{
		local actor = ::Tactical.TurnSequenceBar.getActiveEntity();
		local tooltip = ::ModJimmysTooltips.modTacticalTooltip(__original(_targetedWithSkill), _targetedWithSkill, this);
		if (!::MSU.isNull(actor)) {
			this.getSkills().onOtherActorTooltip(tooltip, actor);
		}
		return tooltip;
	}
});