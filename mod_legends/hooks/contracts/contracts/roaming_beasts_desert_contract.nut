::mods_hookExactClass("contracts/contracts/roaming_beasts_desert_contract", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Name = "Desert Fangs";
		this.m.DescriptionTemplates = [
			"Amid the burning sands, the gnawed bones of deceased travelers are starting to pile up.",
			"The harsh desert trade routes are being made even more treacherous by hungry desert beasts.",
			"Reports of a new pack of roaming desert predators have left travelers on edge.",
			"Being devoured by ferocious desert beasts was not high on your list of things to do today.",
			"Rumor is that a pack of fierce predators have been ambushing caravans in the desert.",
			"A fierce pack of sand beasts appear to have developed quite a taste for human flesh.",
			"The Viziers seek crownling warriors to expend on quelling the sand beast threat.",
			"Some kind of unnatural beasts have been haunting the shifting sands.",
		];
	}

	local createScreens = o.createScreens;
	o.createScreens = function () {
		createScreens();
		local event = this;
		::Legends.Screens.hook(this, "Task", function (_screen) {
			_screen.Title = event.m.Name;
			_screen.Text = "[img]gfx/ui/events/event_162.png[/img]{You enter %employer%\'s place to find %them_employer% standing over a fancy rug littered with human body parts. %They_employer% looks up at you.%SPEECH_ON%These were beast slayers, allegedly, and now here they are, recovered from the task at which they were directed.%SPEECH_OFF%The Vizier nods and a few helpers come over and roll up the rug. Flesh and guts flop and squeeze together and gush out the sides. The servants tilt the rug up, throw it onto their shoulders and march it out, with one dismembered hand flopping lazily from one end. %employer% claps %their_employer% hands.%SPEECH_ON%In the desert lives my problem, a collection of cruel beasts that are harvesting the locals. I\'ve stared into the Eternal Fires and found guidance to seek a Crownling to help resolve this monstrous issue. Do you, Crownling, find %reward% crowns a suitable allotment to purchase your temporary allegiance?%SPEECH_OFF% | You walk into %employer%\'s domicile, but a veritable wall of guards stop you from approaching any closer. %They_employer% stands at the base of a throne with a short staircase descending from it. %They_employer% walks down it with deliberation at every step, coming to the landing. A man looks back at %them_employer%, and the Vizier nods. The man looks back at you and hands you a scroll. It reads that creatures of an undetermined sort are wreaking havoc within the protectorate of %townname%. If you find and destroy said monsters you are to be rewarded in a manner suitable to the task, %reward% crowns. | %employer% is found surrounded by a harem of half-naked women. %They_employer% is holding up a severed hand which, surprisingly, the women seem more fascinated with than disgusted. As %they_employer% sees you, the Vizier drops the hand and wipes %their_employer% hand on the shoulder of one of the women, this time garnering a fair bit of disdain, albeit slavenly muted.\n\n%employer% snaps %their_employer% fingers at a servant who rushes over with a jar of wine. The Vizier sighs and shoos the servant away and snaps %their_employer% fingers once more. A second servant realizes he\'s been called and comes forward, hurriedly handing you a scroll and speaks its words aloud: monsters have been spotted near %townname% and they are to be destroyed posthaste.\n\n The reward for this is not spoken quite so loudly. Instead, the servant taps the page where a number has been written: %reward% crowns. | %employer% is standing over a map so enormous that it cannot fit on any table, but is instead parceled out and spread across the marbled floor. It seems unnecessary, as a map could be easily contained in proper resolution, but you keep this observation to yourself. The Vizier walks over the paper and points at a location.%SPEECH_ON%Beasts have set upon this part of the realm and are seeing to its destruction in a manner that I have not agreed to. I\'ve more important matters to attend to there.%SPEECH_OFF%%They_employer% points to another area of the map which just looks like a bunch of empty desert. %They_employer% continues.%SPEECH_ON%So I need a man such as yourself, Crownling, to see these roaming monsters. Particular to your success, you will be rewarded %reward% crowns which should be more than suitable.%SPEECH_OFF%}";
		});
		::Legends.Screens.hook(this, "Success1", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_162.png[/img]{%employer% is already outside %their_employer% palace when you return. %They_employer% has a few men in silken garb standing at %their_employer% side. When you deposit the hyenas\' corpses, these men hurry the bodies away. The Vizier remains with a few guards at %their_employer% sides. %They_employer% snaps %their_employer% fingers and a servant hands you a chest of crowns. The Vizier nods.%SPEECH_ON%Well done, Crownling. We shall make good use of these parcels which you have delivered in good time.%SPEECH_OFF%Parcels? You thought you were here to help solve a monster menace. As guards hurry you out of the square, you eye one of the wise men using a protractor to start making measurements while another man sets up a pedestal and begins to paint. | %employer% stands at %their_employer% door, though you are kept at a good distance. %Their_employer% servants, instead, are the ones to greet you. They take the hyena scalps and loft them into silvered wheelbarrows. The servants scamper the goods back across the yard and disappear just as soon as they came. The Vizier whistles like a hawk bearing down on its prey. You twitch for a second, but all that comes is another pair of servants carrying a trove of crowns. One looks to the sky as he recites.%SPEECH_ON%Crownling, this job, you have done well, see to the chest, and you will find your purse swell.%SPEECH_OFF%The servant clicks his tongue and looks down, grinning wildly.}";
		});
		::Legends.Screens.hook(this, "Success2", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_162.png[/img]{%employer% welcomes you into %their_employer% throne room. It is filled to the brim with what looks like very important people, yet you are brought in anyway. Pausing briefly because you\'re not sure if the crowd can take it, you shrug and then spill out the nachzehrers\' remains. The froth of blood and guts and heads puddles across the floor, but not a peep comes from the onlookers.\n\nAll you can hear is the soft steps of the Vizier walking over. %They_employer% stares at the remains, hands clasped before %them_employer% like some scientist, then %they_employer% snaps %their_employer% fingers and a horde of servants come over and clean up the mess. One man with a quill pen and papers makes notations. When all is said and done the Vizier returns to %their_employer% throne and sits in silence. The only other sound you hear is the chinky-chank of a treasure chest being dragged over. All %reward% crowns are handed to you as promised, then you are quietly urged to leave the room.\n\n Looking back, you see the crowd return their attention to the Vizier who starts into prayers. | A man stops you outside %employer%\'s room. He has with him a few scrawny men with quill pens and ledgers. They descend upon your collection of nachzehrers and make attributions accordingly to their papers. Each one finishes and tears the page away and hands it to the first man who compares his notes. Satisfied, he hands you a purse of %reward% crowns.%SPEECH_ON%May your road be ever gilded, Crownling.%SPEECH_OFF%}";
			_screen.Options[0] = "We\'re done here.";
		});
		::Legends.Screens.hook(this, "Success3", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_162.png[/img]{You meet with employer in %their_employer% garden. %They_employer% stares at you with a pair of clipping scissors in hand.%SPEECH_ON%I take it the task is completed?%SPEECH_OFF%Nodding, you produce a serpent\'s head and throw it to the ground. It plops mutely and rolls to the Vizier\'s foot which slowly moves out of the way. %employer% looks at you sternly.%SPEECH_ON%Theatrics are not necessary, Crownling, it is the completion of the task itself which is suitable in impressing me. My guards will furnish your purse a weight of %reward% crowns, as agreed upon.%SPEECH_OFF% | You drag the serpent skins toward %employer%, but a man wearing a feathered turban stops you. He speaks in what sounds like gibberish, though the occasional word slips through. It seems he is in the employ of the Vizier, and he is taking the serpent\'s remains. You look to %employer% who nods to confirm that this is what is to happen. %They_employer% also seems to notice the signs of tension on your face as you worry about your payment. %They_employer% speaks loudly and proudly.%SPEECH_ON%Fear not, Crownling, the only snakes here are the ones you have brought to us.%SPEECH_OFF%}";
		});
	}

	o.onPrepareVariables = function (_vars) {
		local brothers = ::World.getPlayerRoster().getAll();
		local candidates_helpful = brothers.filter(@(_,_bro) (_bro.getBackground().isBackgroundType(::Const.BackgroundType.Lowborn)	&& !_bro.getBackground().isBackgroundType(::Const.BackgroundType.OffendedByViolence) && !_bro.getSkills().hasTrait(::Legends.Trait.Bright) && !::Legends.Backgrounds.has(_bro, ::Legends.Background.Hunter)));
		local candidates_bro1 = brothers.filter(@(_,_bro) (!_bro.getSkills().hasTrait(::Legends.Trait.Player)));
		local helpful = candidates_helpful.len() != 0 ? candidates_helpful[::Math.rand(0, candidates_helpful.len() - 1)] : brothers[::Math.rand(0, brothers.len() - 1)];
		local bro1 = candidates_bro1.len() != 0 ? candidates_bro1[::Math.rand(0, candidates_bro1.len() - 1)] : brothers[::Math.rand(0, brothers.len() - 1)];
		local candidates_bro2 = brothers.filter(@(_,_bro) (!_bro.getSkills().hasTrait(::Legends.Trait.Player) && !_bro.getBackground().isBackgroundType(::Const.BackgroundType.OffendedByViolence) && _bro.getBackground().isBackgroundType(::Const.BackgroundType.Combat) && _bro.getID() != bro1.getID()));
		local brothersWithoutBro1 = brothers.filter(@(_,_bro) (_bro.getID() != bro1.getID()));
		local bro2 = candidates_bro2.len() > 1 ? candidates_bro2[::Math.rand(0, candidates_bro2.len() - 1)] : (brothers.len() > 1 ? brothersWithoutBro1[::Math.rand(0, brothersWithoutBro1.len() - 1)] : bro1);

		_vars.push([
			"helpfulbrother",
			helpful.getName()
		]);
		_vars.push([
			"bro1",
			bro1.getName()
		]);
		_vars.push([
			"bro2",
			bro2.getName()
		]);
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull()	? "" : ::Const.Strings.Direction8[::World.State.getPlayer().getTile().getDirection8To(this.m.Target.getTile())]
		]);
	}
});
