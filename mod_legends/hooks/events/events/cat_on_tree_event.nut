::mods_hookExactClass("events/events/cat_on_tree_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "ArrowGood") {
				s.Text = "[img]gfx/ui/events/event_97.png[/img]%archer% nocks an arrow and sticks their tongue out while aiming up the tree. The girl and boy don\'t seem fond of this idea and clap their hands over their eyes. The archer looses the shot and it cracks against the cat\'s branch, breaking it and sending the cat cartwheeling down the tree like a game of devil sticks. When it hits the ground, the boy and girl lunge on it. They pet it and thank you for your troubles. The girl squeezes the cat warmly.%SPEECH_ON%Finally, we got ourselves something to eat!%SPEECH_OFF%";
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
				}
			}
			if (s.ID == "ArrowBad") {
				s.Text = "[img]gfx/ui/events/event_97.png[/img]%archer% readies, nocking an arrow and taking aim. The cat purrs as it stares down the line of the shot, rather sublime in its suicidal stance. Closing one eye, the archer lets the arrow fly. There isn\'t much mewling to be had. The cat tumbles down the tree like a game of devil sticks and lands on the ground with an arrow shaft halfway out its head. The girl crouches down and stares at the slinky bit of brain wobbling off the arrowtip. She looks up at you, as though it were you who fired the shot.%SPEECH_ON%That was my friend.%SPEECH_OFF%You tell her you\'re sorry and that she\'ll find more friends. As for the boy, he pockets the bit of brain and slings the cat carcass over his shoulder. He bleakly states.%SPEECH_ON%At least we\'ve somethin\' to eat now.%SPEECH_OFF%";
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					this.World.Assets.addMoralReputation(1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
				}
			}
			if (s.ID == "Ratcatcher") {
				s.Text = "[img]gfx/ui/events/event_97.png[/img]%ratcatcher% snaps their fingers.%SPEECH_ON%Oy, I\'veuhplan! You little runts just wait a moment!%SPEECH_OFF%The rat catcher takes a rat out of a pocket you\'d no idea they even had. Chirping through lips like a mewling cat, the ratcatcher holds the little rodent up. The cat takes notice, perking its ears.%SPEECH_ON%Yeah that\'s right you pussy, c\'mon down, it\'s lunch time.%SPEECH_OFF%The rat catcher brings the rat to their lips and whispers.%SPEECH_ON%No it\'s not, heheh.%SPEECH_OFF%As the cat descends, %ratcatcher% holds the friend out a little more. It begins to scrape and scuttle against the mercenary\'s hands, perhaps not trusting its master to keep it. But the moment the cat lunges for the meal, the rat catcher pockets the rat and snags the cat all in one swift motion. The children clap and cheer as the cat is handed over. Even some of the company are impressed by the catcher\'s feline-like reflexes!";
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
				}
			}
		}
	}
})
