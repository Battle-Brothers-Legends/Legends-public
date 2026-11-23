::mods_hookExactClass("events/events/bright_vs_dumb_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_15.png[/img]%dumb% is perhaps one of the dumbest individuals you\'ve ever met but, for a brief moment, it does appear that %bright% gets through and teaches %them_dumb% a thing or two about critical thinking and memorization. You watch as the two sit together and look over some scrolls. You\'re not sure where the smart %person_bright% got such papers, but the unlearning oaf is certainly paying a lot of attention to them.\n\nAs you watch, %dumb% is asking rather deep, profound questions. Questions about the land and its relationship to people, and the sky and its relationship to the birds. You slowly realize the idiot is merely glancing around and describing what %they're_dumb% seeing in the sort of \'inquisitive\' language %bright% has taught %them_dumb% - namely by attaching a smarmily-intoned question to the end of every sentence. When the two finish up, %bright% comes to you with a grin.%SPEECH_ON%I think we\'re really getting somewhere with %them_dumb%. %They're_dumb% learning, you know? With students like that, all you gotta do is be patient and take your time.%SPEECH_OFF%A little ways away, %dumb% is pounding ants with a rock. You simply nod and let %bright% live out every teacher\'s biggest fantasy.";
			}
		}
	}
})
