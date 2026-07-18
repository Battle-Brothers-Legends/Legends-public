::mods_hookExactClass("events/events/dlc6/desert_fall_event", function (o) {
	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		if (::World.Assets.m.ProfessionEffect.LegendTrailblazer > 0) {
			return;
		}
		onUpdateScore();
	}
});
