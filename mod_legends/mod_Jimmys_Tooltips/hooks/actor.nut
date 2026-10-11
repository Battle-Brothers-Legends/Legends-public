::ModJimmysTooltips.ModHook.hook("scripts/entity/tactical/actor", function (q) {

	q.getTooltip = @(__original) function (_targetedWithSkill = null) {
		return ::ModJimmysTooltips.modTacticalTooltip(__original(_targetedWithSkill), _targetedWithSkill, this);
	}
});
