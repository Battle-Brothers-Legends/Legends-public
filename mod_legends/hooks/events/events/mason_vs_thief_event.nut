::mods_hookExactClass("events/events/mason_vs_thief_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img]%mason% the mason is stoking the campfire with %thief% standing nearby. The thief is mulling a question over.%SPEECH_ON%Hmm, what was the hardest to break into? Well, vaults were the easiest, let\'s get that out of the way first. I once stole so much from a vault that they tried to hang the locksmith for being so easily defeated by a common thief. They couldn\'t find the locksmith, for you see I\'m no common thief, for the locksmith was me. Ha-ha! To answer your question, a tower is the hardest to break into, especially a tower standing alone.%SPEECH_OFF%Sitting back on their laurels, the mason nods.%SPEECH_ON%Aye, thought you might say so. Towers be built for prisoners of import or items of peculiar fancy. Little more than cages in the sky for creatures with no wings. But one time, a prisoner, some notorious fish thief, did manage an escape. He spent years upon years pulling out strands of his own hair and tying them together until the \'rope\' was long enough for him to throw it out and climb down. They caught him a day later, unfortunately. He did the same trick again a few years later, but that time he roped it half-as-long and simply hanged himself instead.%SPEECH_OFF%%thief% laughs.%SPEECH_ON%That\'s interesting and all, but I\'m a true thief, mason, not a mere robber of fishmongers. My question is how do I get -into- the tower.%SPEECH_OFF%The mason nods.%SPEECH_ON%Simple. Commit a... herring offense.%SPEECH_OFF%";
			}
		}
	}
})
