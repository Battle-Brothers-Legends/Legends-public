::mods_hookExactClass("events/events/butcher_gives_pointers_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_38.png[/img]You find %butcher% the butcher tracing a finger along %flagellant%\'s unclothed back. He finds a point between the sinews and scars and taps it.%SPEECH_ON%Here. If you strike yourself here, the largest amount of meat - I mean muscle, I will be hit.%SPEECH_OFF%The flagellant looks up.%SPEECH_ON%Will it be painful?%SPEECH_OFF%A grin crosses the butcher\'s face.%SPEECH_ON%Oh yes, very much so.%SPEECH_OFF%It appears the man is giving the flagellant pointers on how to mark himself up. Before you can step in, %flagellant% takes up a whip and hits himself right where %butcher% had directed him to. The tendrils of leather, glass, and sharpened bone snap against the man\'s back, dig in, and then upon retrieval tear his flesh asunder.";
			}
		}
	}
})
