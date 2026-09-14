::mods_hookExactClass("events/events/no_food_event", function(o) {
	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
			return;
		onUpdateScore();
	}
})
