::mods_hookExactClass("events/events/all_naked_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_16.png[/img]Marching along, you spot a fellow traveler who leans forward and then back and then forward again, all the while his hand knowing not whether to shield the sun or peel away to let himself be blinded. He shakes his head and spits.%SPEECH_ON%I\'d heard word of you folks. Buncha trouserless folk in a land of evil, like some devil\'s little joke sprung to life. The hell are you?%SPEECH_OFF%You shrug and tell the man that, so far, you\'ve no issue with taking on your troubles sans leather or plate or cloth of loin. Again, the traveler shakes his head and spits.%SPEECH_ON%Farkin\' hell. A warrior in battle with nothing on him is more naked than the day he\'d done been born! I s\'pose the irony is that if we - and I mean anybody-we - come find ya dead in the fields, then we\'ll probably dress ya better for the grave than you dress yourself now. Which shan\'t be hard, seeing as how you\'ve dressed yourself none at all.%SPEECH_OFF%With a bit of a wave, you thank the traveler for his kind words before continuing your merry march.";
			}
		}
	}
})
