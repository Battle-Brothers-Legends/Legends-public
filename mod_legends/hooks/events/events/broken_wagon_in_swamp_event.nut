::mods_hookExactClass("events/events/broken_wagon_in_swamp_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "Butcher") {
				s.Text = "[img]gfx/ui/events/event_14.png[/img]%SPEECH_ON%Sir, wait.%SPEECH_OFF%The former meat seller, %butcher%, says. The mercenary moves on ahead and starts hacking at the corpse of a horse. %butcher% cuts out a series of chunks, wraps them in large leaves, dries them with a bit of dirt and salt, and hands them over.%SPEECH_ON%No reason in leaving behind what can be used.%SPEECH_OFF%";
			}
		}
	}
});
