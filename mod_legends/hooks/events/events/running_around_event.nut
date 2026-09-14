::mods_hookExactClass("events/events/running_around_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "%terrainImage%{Walking, running, fighting, fucking, all good for a man\'s heart. The time spent traveling the land has improved the vitality and vigor of the mercenaries. You even caught one of the cheekier mercenaries flexing into pondwater, admiring %their_dude% own reflection like some a vain noble. | All this running about the land has increased the stamina of the mercenaries. One runs in place, holding a finger to %their_dude% neck. %They_dude% remarks that %their_dude% heart rate isn\'t going up at all. Another brother remarks that the sellsword doesn\'t even know how to count. The running %person_dude% pauses.%SPEECH_ON%Oh. That\'s right.%SPEECH_OFF%}";
		});
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
			return;
		onUpdateScore();
	}
})
