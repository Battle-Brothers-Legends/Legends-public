::mods_hookExactClass("events/events/cripple_vs_injury_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img]The recent battle left %injured% with a horrific and permanent injury. As the mercenary sits glumly about the campfire, %cripple% the cripple takes a seat next to the injured.%SPEECH_ON%So here you sit, bummed out about something that don\'t matter. Look at me. Just look at me! Look at where I am! I\'ve lost that which can\'t be returned, but did I dwell on it? No. I pressed on. I joined the %companyname%. Because that, that injury right there, that\'s gone and done. This up here...%SPEECH_OFF%The cripple taps the side of their head.%SPEECH_ON%Up here is what can be made anew. Up here is where you can think, yeah, that happened, but I\'m still alive and I\'m still in this. If the world wants me dead, it\'ll have to take all the pieces I got to give because I\'m not giving up until the last of me is gone!%SPEECH_OFF%%injured% nods with a mood that seems infinitely improved.";
				s.Options[0].Text = "Quite the spirit on that one.";
			}
		}
	}
})
