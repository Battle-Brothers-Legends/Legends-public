::mods_hookExactClass("events/events/butcher_vs_wardog_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_27.png[/img]You hear a yelp and quickly rush to the noise. When you get there, you\'re not sure whether it was human or dog that produced it. %butcher% the butcher is holding a cleaver up and a wardog is rearing beneath them, both sides ready to lunge. The mercenary sees you and quickly sheathes the weapon. The hound takes a squat and throws some puppy eyes your way. Raising an eyebrow, you try not to make sense of the scene.%SPEECH_ON%Play nice now.%SPEECH_OFF%The butcher scoffs.%SPEECH_ON%Oy\', me and the bitch were just having a talk that\'s all.%SPEECH_OFF%";
			}
		}
	}
})
