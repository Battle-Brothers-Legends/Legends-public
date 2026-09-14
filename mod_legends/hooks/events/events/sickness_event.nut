::mods_hookExactClass("events/events/sickness_event", function(o) {
	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion" || ::World.Assets.m.ProfessionEffect.LegendTrailblazer > 0)
			return;
		onUpdateScore();
	}
})
