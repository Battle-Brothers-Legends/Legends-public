::mods_hookExactClass("events/events/dlc6/desert_heat_event", function (o) {
	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		if (::World.Assets.m.ProfessionEffect.LegendTrailblazer > 0) {
			return;
		}
		onUpdateScore();
	}
});
