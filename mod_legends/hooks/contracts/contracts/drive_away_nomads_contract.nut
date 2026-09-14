::mods_hookExactClass("contracts/contracts/drive_away_nomads_contract", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Name = "Desert Raiders";
		this.m.DescriptionTemplates = [
			"A nomadic camp has been preying on roads to %s. Elusive and evasive, the desert tribes have been here for centuries.",
			"Life among the sand nomads is a constant journey beneath the scorching sun. Help them journey elsewhere.",
			"Amidst the dunes, the sand nomads carve out a life of resilience and adaptability. Do not underestimate them.",
			"Among the sand nomads, kinship and tradition are the bedrock of their society. Sounds lovely, but you\'ve seen what they do to unarmed traders on the roads.",
			"Sand nomads strike swiftly, their raids leaving nothing but dust and despair.",
			"Nomads haunt the desert around %s, their raids a constant threat to those who traverse the sands.",
		];
	}

	o.formatDescription <- function () {
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null) {
			r = format(r, ::Const.UI.getColorized(this.m.Home.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));
		}

		this.m.Description = r;
	}

	local createScreens = o.createScreens;
	o.createScreens = function () {
		createScreens();
		::Legends.Screens.hook(this, "Task", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_163.png[/img]{There are no horns, no confetti, no cheers, but there\'s still yet a certain level of pomp when you enter %employer%\'s room. It is so decorated with golds and silvers, intricate jewelries made by genuine craftsmen, and a harem of nothing but the most attractive women, that one can\'t help but be spurred to do whatever is asked if only to have a chance to partake in the seemingly day-to-day festivities. %employer% sits upon a pile of cushions.%SPEECH_ON%Ah, Crownling. I\'ve been expecting you. Please, come no closer, you will scare my attractions. I have a simple task for you. Nomads have been plundering my caravans, hereat, I am with fewer coins in my coffers. I\'m sure you understand what it is like to be deprived of in any manner, yes? Ah, you seem so dumb. So blank. So, well, involved with what you do. I need those nomads killed, and I\'m willing to pay %reward% crowns to have it done. Does this language please whatever resides between those ears?%SPEECH_OFF% | %employer% is partly sitting on a throne of silken cushions, and partly on the bodies of a harem of attractive women. %They_employer% puts %their_employer% hand up.%SPEECH_ON%If you step further, Crownling, then you will grow in sight but diminish in view, understand? A smart man knows his place. I have a simple task for your swordhand. Nomads outside %townname% have taken to thievery and thuggery. For a handsome handsel, I need you to annihilate these men who have made my life uncomfortable.%SPEECH_OFF% | You find %employer% feeding a bird in a cage. The bird is a collage of colors some of which you\'re not sure you have even seen before. Suspecting your presence, or perhaps smelling it, %employer% turns with a hint of disgust.%SPEECH_ON%You are scaring my bird, Crownling, so I will make this brief for her sake. There are nomads roaming the peripheral of my lands and I need them destroyed. I\'m sure a man of your, eh, station, would be willing to undertake such a simple, easy task?%SPEECH_OFF% | You enter %employer%\'s room. %They're_employer% feeding on fruits and %their_employer% lower half is submerged in a sea of flesh, a harem of caretakers who are noisily at work. Standing idly for far too long, you open your mouth but the %person_employer% throws a hand up. %They_employer% points at one of %their_employer% servants and snaps %their_employer% fingers. The servant skirts across the marble floor on sandals with silken soles. He presents to you a piece of paper. It reads:%SPEECH_ON%To Crownlings who are interested, nomads have taken to disturbing the peace around %townname%. They are to be dealt with posthaste for a reward of %reward% crowns. Uninterested parties are to leave immediately.%SPEECH_OFF%The servant looks at you for an answer. | %employer% sighs as you enter %their_employer% room.%SPEECH_ON%Ah, a Crownling, I\'d almost forgotten I had requested your sort to come ruin my day.%SPEECH_OFF%You stare at the Vizier as %they_employer% is far too belabored to extricate %themselves_employer% from a sea of cushions and the harem of women who are there to fluff each and every one.%SPEECH_ON%Well, I suppose I shall sully an hour if only to get this matter settled. Nomads are ravaging my caravans, as they are wont to do, and hereat my markets are deprived of certain goods which I wish to have. I offer %reward% crowns to find and destroy these sand ridden mites.%SPEECH_OFF%}";
		});
		::Legends.Screens.hook(this, "Treasure1", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_54.png[/img]{The nomads are surprisingly stationary and surprisingly many, but it appears there\'s a reason for that: you find the sand dwellers huddled around a hole in the ground. They\'ve constructed pullies around it and are working feverishly to drag up whatever it is they\'ve found in the desert. Based upon the grin of the man overseeing the operation, it is no doubt a trove of treasure.\n\nYou could attack now, and face more opposition, or you could wait until they\'re done and have left with whatever they\'re digging up.}";
		});
		::Legends.Screens.hook(this, "Success1", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_04.png[/img]{A servant heads you off from meeting %employer%. He hands you a scroll as well as a satchel. Despite having already handed you the paper, the servant puts his hands behind his back and looks at the ceiling as he recites.%SPEECH_ON%The Crownling is rewarded %reward_completion% crowns as per prior arrangements. Having taken his reward, he is dismissed from the property posthaste.%SPEECH_OFF%The servant looks down at you and nods.%SPEECH_ON%Leave.%SPEECH_OFF%He says. | You try to enter %employer%\'s room but a large, scarred guard lowers the business end of a polearm across the door.%SPEECH_ON%No visitors.%SPEECH_OFF%You state that you have business with the Vizier. The guard shakes his head. A servant comes up behind you and puts a satchel in your arms and then departs just as fast. The guard returns the polearm to his side.%SPEECH_ON%Your trivialities with the Vizier concluded when you first departed %their_employer% presence. You are not to poison %their_employer% mood any further. Leave. Now. Before you poison mine.%SPEECH_OFF% | As you approach %employer%\'s room, a woman claps from across the lobby. You look over and she\'s already far too close. Four birds perch upon her shoulders and they sway with her every step.%SPEECH_ON%Crownling.%SPEECH_OFF%She produces a satchel and hands it over.%SPEECH_ON%%employer% need not smell you once more, this far into %their_employer% home is sufficient. Count it if you wish to insult us, leave if you wish to please us.%SPEECH_OFF%She turns on her heels and walks away, her otherworldly dress flowing side to side. One of the birds rotates on her shoulder and squawks at you.}";
		});
	}
});
