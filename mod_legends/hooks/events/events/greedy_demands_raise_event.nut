::mods_hookExactClass("events/events/greedy_demands_raise_event", function(o) {
	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.lone_wolf")
			return;
		onUpdateScore();
	}

})
