::mods_hookExactClass("events/events/no_food_event", function(o) {
	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		if (::World.Assets.getOrigin().getID() == "scenario.legends_risen_legion" || (::World.State.getEscortedEntity() != null && !::World.State.getEscortedEntity().isNull()))
			return;
		onUpdateScore();
	}
})
