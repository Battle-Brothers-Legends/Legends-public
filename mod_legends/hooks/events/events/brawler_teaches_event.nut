::mods_hookExactClass("events/events/brawler_teaches_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]A shadow crosses over you from behind. When you look back, %brawler% is standing there with a rather distant look in his eyes. He cracks his knuckles in one long staccato before asking if he can train up %noncom%. You ask why. The brawler looks down at you.%SPEECH_ON%Because weakness must leave the body through pain.%SPEECH_OFF%Hmmm, good enough.";
				s.Options[0].Text = "See how long you can keep it going.";
				s.Options[1].Text = "Toughen em up, will you?";
				s.Options[2].Text = "Show em how to brawl.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_06.png[/img]%brawler% and %noncom% are found in a mudpit with their hands wrapped in cloth and leaves, padding for the knuckles and to keep them from cutting one another with every punch. The brawler has his trainee bouncing counter-clockwise along the ring of the fighting circle, punching the air as they go, and with the trainer hitting or kicking every time the student passes by. The mercenaries glisten with sweat as they work. When %noncom% begins to slow, %brawler% hits hard as though a jockey would a sluggish horse.\n\n After an hour of this, %brawler% steps back and invites his trainee to attack him. Predictably, the assault is aimless and pitiful. Long, looping punches are thrown with no energy behind them. The brawler ducks and weaves out of the way, punching every attempted strike with a counter-punch of his own.%SPEECH_ON%See what happens when you are tired? This is why we must train. Even the most able and deadly are worth nothing without air in their lungs and fresh legs beneath them.%SPEECH_OFF%";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_06.png[/img]The brawler has %noncom% stand completely still. He circles about, cracking his knuckles as he sizes the trainee up. Finally, he lets his intentions be known.%SPEECH_ON%I am going to beat you until you break.%SPEECH_OFF%A moment is given to the trainee to acknowledge what is about to happen, who sucks in a great gulp of breath and then nods. %brawler% wastes no time wheeling a bola punch right into the chest. The trainee bowls over and is kicked in the shoulder repeatedly until managing to stand back up.\n\nThere the brawler continues to circle and deliver blows. Not every strike is thrown with conviction: most are meant to inflict pain, but not what could be called irreversible damage. The brawler, if he wanted to, could kill this man with his bare fists, but that is not the purpose of this training. You realize that this mode of \'toughening up\' probably happened to the brawler himself at some point or another.";
			}
			if (s.ID == "") {
				s.Text = "[img]gfx/ui/events/event_06.png[/img]%brawler% the heavy-handed-rough-and-tumble brawler is found leaning over, his arms fenced out before himself in a defensive posture, and %noncom% is standing adjacent, trying to mimic the stance. The brawler drops his body low and shoots in under %noncom%\'s arms, there wrapping both hands around the waist and lifting up in the air before dumping the trainee hard, back smacking into the ground. %brawler% steps away, cracking his knuckles and telling %noncom% to get up.%SPEECH_ON%You need to be ready for two things: me coming in low, and me coming in high.%SPEECH_OFF%%noncom% dusts off then complains a little.%SPEECH_ON%How can I possibly do both?%SPEECH_OFF%The brawler ignores the question and simply asks the trainee to attack him. %noncom% obliges, coming in high with a hurled fist. %brawler% deflects the blow with a shoulder-roll before throwing a cross-counter that has %noncom% spinning on their feet. The fist-fighter cracks his knuckles again and spits.%SPEECH_ON%Practice. That\'s how. Now get back up and let\'s go again.%SPEECH_OFF%";
			}
		}
	}
})
