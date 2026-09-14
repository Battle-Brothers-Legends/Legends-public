::mods_hookExactClass("events/events/historian_mysterious_text_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function(_screen) {
			_screen.Text = "[img]gfx/ui/events/event_57.png[/img]You come across an abandoned chapel. Cobwebs dress its cracks, and bird nests the corners. The pews are tipped over or have been chopped up for firewood. The old gods have surely left this place.\n\n %historian% the historian comes to you with what look like muddy logs in %their_historian% hands.%SPEECH_ON%Would you look at this? Old scripts!%SPEECH_OFF%%They_historian% blows the blackened dust and ash off the scrolls.%SPEECH_ON%Have you ever seen something so spectacular? I don\'t know what they say yet, but it\'s still a most interesting of finds!%SPEECH_OFF%Right, whatever.";
		});
		::Legends.Screens.hook(this, "B", function(_screen) {
			_screen.Text = "[img]gfx/ui/events/event_15.png[/img]As you make camp outside the temple, %historian% the historian enters your tent.%SPEECH_ON%Sir, I think you might be interested in this.%SPEECH_OFF%%They_historian%\'s got the scrolls from the chapel in %their_historian% arms and unravels a few of them across your desk. There you see the historian\'s sloppy scribblings. %Their_historian% notes are in a language you can\'t read, but you can easily follow the arrows %they_historian%\'s drawn over the pages to connect segments together. %They_historian% then unfurls another scroll, a fresh one, with all the translations.%SPEECH_ON%These are old training manuals. They speak of techniques I never knew existed. Shall I disperse them amongst the men?%SPEECH_OFF%";
		});
		::Legends.Screens.hook(this, "C", function(_screen) {
			_screen.Text = "[img]gfx/ui/events/event_15.png[/img]While sitting in your tent outside the abandoned temple, %historian% the historian enters in a manner best described as reluctant. In %their_historian% hands are the scrolls %they_historian% found in the chapel a few days back.%SPEECH_ON%Sir, uh, the scrolls... they were most interesting.%SPEECH_OFF%Bored, you inquire as to \'how interesting.\' The %person_historian% explains.%SPEECH_ON%Well, they\'ve been written in a very ancient language. I\'m not well versed in it, but I can certainly read portions here and there.%SPEECH_OFF%You ask %them_historian% what %they_historian% wants then.%SPEECH_ON%I\'d like to read the scrolls, but I could use a little bit of confidence before I do. Would you grace the reading? That is what my old professors would do before any great undertaking.%SPEECH_OFF%";
		});
		::Legends.Screens.hook(this, "D", function(_screen) {
			_screen.Text = "[img]gfx/ui/events/event_12.png[/img]%historian% picks up the scrolls. %They_historian% licks %their_historian% lips, clears %their_historian% throat, and begins to read aloud. The words that come forth are not ones you\'d easily recognize. They sound so lazily produced as though %they_historian% were being wrangled from a deep sleep, and indeed bringing with %them_historian% the monsters that would inhabit the dreamworlds.\n\n %They_historian% stops and looks up.%SPEECH_ON%That was it. Do you feel anything?%SPEECH_OFF%You raise an eyebrow. Feel anything? Why would--\n\n Madness. You see a spiraling darkness wreathed in living shadows, the screaming specters of creatures that still yet yearn for finality in death, and amongst them swirl beings, grinning and yapping, like bestial puppet masters, maws slipped to yonder depths, their boned teeth the only light in this realm, their smiles but crescents of ill-shaped moons come to feast on the stars themselves.%SPEECH_ON%Oh naive one, does thou think Davkul does not listen?%SPEECH_OFF%You suddenly awake to %historian%\'s screams. %They_historian% says all manner of monsters are afoot. With not a moment to waste you go to warn the men before all the hells and those not yet known can break loose.";
		});
		::Legends.Screens.hook(this, "E", function(_screen) {
			_screen.Text = "[img]gfx/ui/events/event_15.png[/img]%historian% picks up the scroll and begins to read. The language is at both familiar and yet primordially ancient. It tickles the ear like the scratch of vipers over sand and by no means any less threatening. When %they_historian%\'s finished, the historian looks up.%SPEECH_ON%Feel anything?%SPEECH_OFF%Suddenly a dark, yet soft hand wraps around the %person_historian% from behind, curving down toward %their_historian% loins.%SPEECH_ON%Oh, humans. We did not think you would survive this long, and indeed it has been long since our services were called upon.%SPEECH_OFF%Lithe, hip-swaying creatures slip so lightly into the tent as though they were hardly more than the wind itself. Outside, you can hear the murmur of the rest of the company being overcome by the seductive beings. One walks toward you, her shape flashing between all the women of your life, testing your response, and when your heart warms it settles on a young lady that once broke your heart. The succubus falls atop you.%SPEECH_ON%Don\'t mind me, human, this is for you. Relax.%SPEECH_OFF%You let the pleasures wash over you.\n\n Immeasurable hours later you awake with your trousers down and %historian% in the corner rubbing %their_historian% head.%SPEECH_ON%They were so wonderful, but the scroll\'s gone. I think it burned up after I said the words. Oh by the old gods do I wish I remember what they said!%SPEECH_OFF%";
		});
	}

	o.onUpdateScore = function () {
		if (this.World.getTime().Days < 10)
			return;

		local town = ::Legends.S.getClosestSettlement();
		if (town == null || town.getTile().getDistanceTo(::World.State.getPlayer().getTile()) > 8)
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_historian = [];

		foreach( bro in brothers ) {
			if (bro.getLevel() >= 3 && (::Legends.Backgrounds.has(bro, ::Legends.Background.Historian) || bro.getSkills().hasPerk(::Legends.Perk.LegendScholar))) {
				candidates_historian.push(bro);
			}
		}

		if (candidates_historian.len() == 0)
			return;

		this.m.Historian = candidates_historian[this.Math.rand(0, candidates_historian.len() - 1)];
		this.m.Score = 5;
	}
})
