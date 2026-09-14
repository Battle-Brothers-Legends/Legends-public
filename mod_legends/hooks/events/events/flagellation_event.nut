::mods_hookExactClass("events/events/flagellation_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]%otherguy% approaches with a pained look on %their_otherguy% face. His helmet is in hand as he wipes %their_otherguy% brow.%SPEECH_ON%Sir, uh, you should come and see this.%SPEECH_OFF%You inquire as to what it is you are going to see.%SPEECH_ON%I don\'t have the words for it. You\'d best come and see with your own eyes.%SPEECH_OFF%You look down at your work - plotting the march for the coming days - but, judging by the look on %their_otherguy% face, it can wait.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_38.png[/img]You get up and have %them_otherguy% lead you to whatever it is that\'s causing an issue. You come across a throng of brothers circled around something or someone. Breaking your way through the crowd, the company quiets as you come into the clearing to find %flagellant_short% the flagellant unconscious on the ground.\n\n%Their_flagellant% back is stripped raw and you think you can even see a rib or two. Thorns have broken off %their_flagellant% brutish whip, embedding themselves in %their_flagellant% flesh, and %their_flagellant% skin hangs in strands where it hangs at all. It is good %they_flagellant% has passed out. Not because %they_flagellant% would be horrible in pain, but because you think %they_flagellant% might not otherwise have stopped. You order the men to clean %them_flagellant% up, dress %their_flagellant% wounds, and hide %their_flagellant% tools of misery.";
			}
		}
	}
})
