::mods_hookExactClass("events/events/disowned_noble_reminisces_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img]You find %disowned% sitting by %themselves_disowned% outside the camp. As the jeers and cheers of the mercenaries around the campfire crackle behind you, you approach the %person_disowned% and ask what %they_disowned%\'s sulking for. %They_disowned% shrugs.%SPEECH_ON%Not sulking, sir, just thinking. Though I suppose one could be easily mistaken for the other.%SPEECH_OFF%Chuckling, %they_disowned% offers a bit of %their_disowned% drink, which you take. Settling down beside %them_disowned%, you ask what it is %they_disowned% is \'thinking\' about. The disowned noble%person_disowned% shrugs again.%SPEECH_ON%Ahh, nothing really. Just thinking about home. I\'m a long ways away from it now, and the last I remember of it isn\'t exactly the best, yet I still find myself wishing to be there now and again. Homesick for a land that thinks me a sort of noble sickness, go figure.%SPEECH_OFF%You hand %them_disowned% back to %their_disowned% drink as %they_disowned% probably needs it more than you. While you\'re still clearheaded, you try and speak your mind...";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img]You speak.%SPEECH_ON%Where you\'re from is a house, not a home. You yearn for a different place in a different time, when you\'re in this place, right here, right now. The %companyname% looks after you, and you it, and only together will we persevere.%SPEECH_OFF%The %person_disowned% stares into %their_disowned% drink for a time. %They_disowned% chuckles, sips, and wipes the froth away.%SPEECH_ON%Yeah, I suppose that\'s one way to look at it. Thank you, captain.%SPEECH_OFF%";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img]You clap the %person_disowned% on %their_disowned% shoulder and speak.%SPEECH_ON%Hey, thinking of the old is good for the soul, even if it\'s through a thicket of shit and cruelty and evil and all else that makes any %person_disowned% stay up at night. But it\'s only good for a time. You look at the past, you acknowledge it, and then you move on. You have to be sure to only visit the past, not dwell in it. Everyone here has a past, %disowned%, and in that respect you will never be alone.%SPEECH_OFF%The disowned noble%person_disowned% stares at the ground for a time. %They_disowned% slowly starts to nod.%SPEECH_ON%Yeah, yeah, that\'s right. I guess a part of me was worried that I was genuinely wanting to return there. I was picturing it with the hearth alight, smoke out of the chimney, soft candlelight beyond the windows, and my family there awaiting me. I was ignoring the locked door, the guard dogs squatting outside, and those I love telling me to never come back lest it\'s in a box to bury far beneath the earth. I wasn\'t thinking of my past so much as dreaming of it, and I think you\'ve helped me realize that, captain. Thank you. I know that, one day, I shan\'t have to dream about the %companyname%, but instead remember it clearly and fondly.%SPEECH_OFF%";
			}
		}
	}
});
