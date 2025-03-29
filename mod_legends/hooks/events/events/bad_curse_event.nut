::mods_hookExactClass("events/events/bad_curse_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]%superstitious% enters your tent with hat in hand. The rim of it turns round and round in their fingers as though plucking feathers from it. Even though you haven\'t said a word the %superstitious% \'s head nods furiously, with eyes darting around as if looking for the words to say.\n\nYou put your quill pen down and ask what the issue is. Licking lips, %superstitious%  nods again and begins to explain the predicament. The words come fast, but the general gist of it seems to be that a local witch has cursed %superstitious% to be incapable of some sexual exploit, as it were.\n\nYou shake your head and ask what it is the witch wants and %superstitious% says %payment% crowns, lest the curse be for life.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]Thumb and finger pinching your eyes shut, you wonder if maybe this wasn\'t the life for you. Killing\'s easy, but this? Whatever. You throw your hands up and get out of your chair to retrieve a satchel of crowns. The superstitious mercenary totters up on toe tips.%SPEECH_ON%Please count it out! It mustn\'t be a crown short!%SPEECH_OFF%You begrudgingly set the satchel on the table and begin counting. Once the appropriate number is had, you shuffle it into a purse and toss it to %superstitious%, who bows, thanking you and your mercy. You wave the sellsword off to quickly get the whole incident out of your tent.";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]You further muddy %superstitious%\'s poor countenance with some bad news: you\'re not paying any witch anything.%SPEECH_ON%A few farcical words from some strange woman in the woods is no basis for an exchange of business. What you\'ve heard is a tramp\'s attempt to get at you, mercenary. You cannot listen to such tripe, especially a tramp\'s tripe for a tramp\'s tripe is always in pursuit of one\'s coin.%SPEECH_OFF%None of these words help %superstitious% who quickly runs out of the tent, perhaps in pursuit of another mercenary who will give a loan.";
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]Wondering if maybe %monk% could help, you go and fetch the holy figure.\n\n %monk% is happy to lend a hand, for the old gods are always at war with the evils of witchcraft and other sorcery. Before an incoming long monologue about this old god or that one, you dip away and send in %superstitious%. For a few minutes, there is peace and quiet in your tent. But you know it can\'t last, for you are like someone beneath a rockslide, awaiting the tumbling stone with their name on it.\n\n However, %superstitious% doesn\'t return. After a few minutes more you realize there still hasn\'t been a disruptive entrance. In fact, the absence altogether has you on edge, as though silence itself might be haranguing. You leave the tent to find the holy one and so-called cursed one deep in religious talks. Smiling, you return to your tent. If there\'s one thing the holy are best at, it\'s maintaining a sense of tranquility.";
			}
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]You snap your fingers, suddenly remembering %sorcerer%, the so-called sorceror. Wanting to not spend another minute being a part of this bizarre affair, you refer %superstitious% to the sorcerer who is quick to leave, but unfortunately returns a few minutes later, explaining that %sorcerer% has removed the curse.%SPEECH_ON%All I had to do was...%SPEECH_OFF%You hold your hand up, stopping the story right where it be. When asked if you want to hear the rest of it, you give a firm no.";
			}
		}
	}
})
