::mods_hookExactClass("scenarios/world/runeknights_scenario", function(rs) {
	local create = ::mods_getMember(rs, "create");
	local onSpawnAssets = ::mods_getMember(rs, "onSpawnAssets");
	local onSpawnPlayer = ::mods_getMember(rs, "onSpawnPlayer");

	::mods_override(rs, "create", function() {
		create();

		setRosterReputationTiers(Const.Roster.createReputationTiers(m.StartingBusinessReputation));
	});

	::mods_override(rs, "onSpawnAssets", function() {
		onSpawnAssets();

		local bros = World.getPlayerRoster().getAll();

		// Legends veteran level perk points, ick, eww, cooties
		bros[0].setVeteranPerks(2);
		bros[1].setVeteranPerks(2);

		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Head));

		items.equip(Const.World.Common.pickArmor([ [1, "barbarians/reinforced_heavy_iron_armor"] ]));
		items.equip(Const.World.Common.pickHelmet([ [1, "barbarians/closed_scrap_metal_helmet"] ]));

		bros[1].getBackground().m.RawDescription = "Before being taken as a thrall, %name% served as a squire to a southern lord. While years have passed since the %person% adopted the northern culture as %their% own, it seems old habits die hard. When " + bros[0].getName() + " slaughtered the rest of %their% clan, %they% asked to be spared that %they% might serve as the chosen's second in battle and see " + Const.LegendMod.getPronoun(bros[0].getGender(), "their") + " deeds under Ironhand's guidance reach their full potential. An unusual pact for a northerner to take on, but taken on it was, and %they% has served faithfully since.";
		bros[1].getBackground().buildDescription(true);

		items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Head));

		items.equip(Const.World.Common.pickArmor([ [1, "barbarians/rugged_scale_armor"] ]));
		items.equip(Const.World.Common.pickHelmet([ [1, "barbarians/bear_headpiece"] ]));
	});

	::mods_override(rs, "onSpawnPlayer", function() {
		onSpawnPlayer();

		World.Assets.updateLook(203);
	});
});

::mods_hookNewObject("retinue/followers/drill_sergeant_follower", function(dsf) {
	local isVisible = dsf.isVisible;

	// Force DS visibility to true
	// Legends removes the permanent injury requirement so he should no longer be disabled for Rune Chosen
	dsf.isVisible = function() {
		if (World.Assets.getOrigin().getID() == "scenario.runeknights")
			return true;
		else
			return isVisible();
	};
});

::mods_hookNewObject("events/offplus_runeknights_events/events/death_knight_confrontation_event", function(dkce) {
	foreach(screen in dkce.m.Screens) {
		if (screen.ID == "A") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);
				_event.m.Dude.setGender(0);
				_event.m.Dude.getBackground().setGender(0);
				_event.m.Dude.getBackground().m.RawDescription = "%name% is a true chosen, acting on visions granted by Old Ironhand to go mete out the god's judgement upon the world. He holds no doubts as to his purpose, and seeks the true end in all he does. This has done no favors to the man's personality, but one can't deny his skill as a warrior.";
				_event.m.Dude.getBackground().buildDescription(true);
			};
		}

		if (screen.ID == "B") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);
				local gender = _event.m.Champion.getGender();
				Text = "{%terrainImage%%champion% steps up, ready to fight. " + Const.LegendMod.getPronoun(gender, "They") + " locks eyes with the barbarian for a moment, then lunges forward. There's a flash of metal and a spurt of blood and, to your shock, you see the mercenary's decapitated head soar through the air before landing with a clunk. The stranger relaxes his stance and bows his head.%SPEECH_ON%A fine strike and a true warrior. Were I not guided by the cloaked will, it would be mine death this day and not " + Const.LegendMod.getPronoun(gender, "theirs") + ". Let a rune be carved.%SPEECH_OFF%The company, though clearly disturbed by the the death of a comrade, are somewhat mollified by this display of respect. Some of the more devout in the company even seem to be inspired by the rune knight's adherence to the old ways. You order a rune carved for %champion%, and the stranger takes up a place in the ranks.%SPEECH_ON%I would visit mine death upon Ironhand's foes under your command, captain. I can see that the warriors you travel with serve his will admirably, and I assure you that you won't find my skills wanting for a place in your renewed band.%SPEECH_OFF%Seeing as how the %companyname% just lost one of its most veteran fighters, you agree to his request, provided he understands that you're in charge. He nods.%SPEECH_ON%Of course. Ironhand saw fit that you should receive his talon not once, but twice. It's a privilege to follow such a favored chosen.%SPEECH_OFF%}";
			};
		}
	}
});

::mods_hookNewObject("events/offplus_runeknights_events/events/ironhand_dream_01_event", function(id1e) {
	local screen = id1e.m.Screens.filter(function(index, screen) {
		return screen.ID == "A";
	})[0];

	local start = screen.start;
	screen.start = function(_event) {
		start(_event);
		local gender = _event.m.Chosen.getGender();
		Text = "[img]gfx/ui/events/event_39.png[/img]{You sit in camp in front of the fire, your hands tented atop your sword, and you stare into the flames and they stare back at you. You feel yourself pulled into them, then under them, deep into the earth, under the winding roots and the bugs and the dirt until you find yourself in a vast nothing.\n\n%randombarbarianname%, your first true friend, bars the way in front of you. You fight. You win. A smile on his face, your first time carving a rune, the tears of joy and sorrow and victory clouding your vision, the sense of completeness as you took his rune into you and felt his strength course through your veins.\n\nYou look up and there is Old Ironhand, hunched over his gnarled staff and cowled, pointing a bony finger to the horizon. You turn to the direction he points and see a swirling blue light, infinitely distant, yet just out of reach. Now the Scorched Tribe stands in your way, now Hafgufa the Chosen, now the sacking of %randomtown% - every conquest, every death, every rune brings you closer to that light, yet you cannot fathom what distance remains. The only constant is Old Ironhand, his wizened body and his pointed finger, urging you to ever greater heights.\n\nYou awake slowly, deliberately, allowing the haze of the vision to fall away gradually as you return to the surface. The fire is long dead, ash in its place. %chosen% comes up to you excitedly and tells you " + Const.LegendMod.getPronoun(gender, "they") + " saw a vision from Old Ironhand himself, a sure sign that the %companyname% are his favored chosen. You smile and tell " + Const.LegendMod.getPronoun(gender, "them") + " you saw it too, and soon the whole company is speaking of dreams and good omens.}";
	}
});

::mods_hookNewObject("events/offplus_runeknights_events/events/ironhand_dream_02_event", function(id2e) {
	local screen = id2e.m.Screens.filter(function(index, screen) {
		return screen.ID == "A";
	})[0];

	local start = screen.start;
	screen.start = function(_event) {
		start(_event);
		local gender = _event.m.Chosen.getGender();
		Text = "[img]gfx/ui/events/event_39.png[/img]{You once again find yourself in front of the fire, its flickering light casting the shadows of men into the world. You look at it with pity, knowing how it struggles, knowing what true flames look like, knowing how it wishes it could char your flesh instead of merely warm it.\n\nFew understand that this is the true nature of fire, despite your attempts to teach them. You remember the Scorched Tribe and their mewling adherence to rituals and castes, to pointless sacrifice and to wanton banditry. All a smokescreen to hide the fear behind all they did. Fear of cold, fear of hunger, fear of man, fear of death. Old Ironhand bid you remind them the origin of their savage little games, show them the reason they turn to savagery in the first place. He bid you show them the fire that produced the smoke.\n\nBut they had spent too long in the cold, and none of them could stand the heat of Ironhand's hearth. Nothing of them now remains, the place their village once stood a blackened scar on the land and even their name lost to the fire. Yet even then other northmen villages learned nothing, instead speaking of them in hushed tones, dubbing them the Scorched and giving them a legend their end did not deserve.\n\nThe southerners are even worse, so desperately clutching at life that they have neglected death. They live not even in smoke, but in an endless winter that belies their warm lands, given purpose and life only by the sputtering of conflicts that might as well be candles. And then there are the dream men, standing in gilded halls you have never seen, who were so cold they sought to never die at all, to spend the rest of eternity in an endless vacuum without heat or purpose, and you sneer at their memory, and the old bearded man who you know but don't know stares at you with that same disappointment as ever, and your fingers begin to tingle with pain, and then %chosen% pulls your hand out of the fire and the trance is broken.%SPEECH_ON%I see it too, but do not despair, captain. These false fires will give way to Old Ironhand's hearth in time. We'll see to it.%SPEECH_OFF%You give the " + Const.LegendMod.getPronoun(gender, "person") + " a nod in thanks, and the two of you return to your ruminations. Sleep does not come, and the fire eventually dies, but the one inside burns bright yet.}";
	}
});

::mods_hookNewObject("events/offplus_runeknights_events/events/ironhand_dream_03_event", function(id3e) {
	local screen = id3e.m.Screens.filter(function(index, screen) {
		return screen.ID == "A";
	})[0];

	screen.Text = "[img]gfx/ui/events/event_39.png[/img]{You're unable to sleep. After tossing and turning for a time you admit defeat and get up, only to find that outside your tent is not the camp, but a desolate heath bathed in dusk. Plumes of smoke rise on the horizon, and all around you see the enemies of man. Shadowy creatures running from knoll to knoll on all fours, rabid hunger in their eyes. Orc war parties blighting the lands upon which they walk while goblins stalk the sidelines. Gross approximations of men rise from the ground, bone and rotting flesh and mindless drive. Old Ironhand sits down on a stoop beside you.%SPEECH_ON%Mine enemies and mine folly. Each held such promise, each delivered such disappointment.%SPEECH_OFF%He sweeps a bony arm across the heath.%SPEECH_ON%Once I thought that beasts could inherit mine will, so singular and savage are they. Yet granting them purpose was only hunger, hunger and fear. The many-legs cowered and ran, the tree-men shut their ears, and the giants thought their own schemes more important.\n\nThe green-man could hath taken on the burden, but he lacked fortitude of mind. Not a creature of fear, no, but of complete selfishness. He hath no ambition beyond what he sees in the world hither, no concept of the greater plan.%SPEECH_OFF%Ironhand begins to tremble with anger.%SPEECH_ON%And worst, the dead-but-living. Once I thought them the truest strength, a death everlasting, yet I found only betrayal and treason in the old bones, loyalty to one who hath long lost right!%SPEECH_OFF%He turns to you suddenly, his un-pupiled eyes flashing from white to red to white, his beard swaying, his body wracked with anger.%SPEECH_ON%Tis only thee, mine chosen, that inherits mine will! Tis only thee that understands the purpose of life, the power of death! Tis only thee that can serve the greater plan! Go now! Visit thine death upon mine foes, and in thine death make them see the wrath of Ironhand!%SPEECH_OFF%You awaken with a start. You find a number of the company had similar visions, a newfound rage for the old god's enemies burning within them.}";
});

::mods_hookNewObject("events/offplus_runeknights_events/events/ironhand_dream_04_event", function(id4e) {
	local screen = id4e.m.Screens.filter(function(index, screen) {
		return screen.ID == "A";
	})[0];

	local start = screen.start;
	screen.start = function(_event) {
		start(_event);
		local gender = _event.m.Chosen.getGender();
		Text = "[img]gfx/ui/events/event_39.png[/img]{As the company settles around the campfire, a sudden weariness falls upon you. You make your way to your tent, but on the way you bump into %chosen%. " + Const.LegendMod.getPronoun(gender, "They") + "'s got something in " + Const.LegendMod.getPronoun(gender, "their") + " hands you can't see.%SPEECH_ON%Oh, captain, there you are. I wanted to show you this. It's the darndest thing.%SPEECH_OFF%" + Const.LegendMod.getPronoun(gender, "They") + " hands you what looks like some kind of black rock, and the instant you touch it the whole world falls away. You find yourself in a scorched wasteland, bits of charred grass and dead trees breaking up the otherwise featureless hills. In front of you wanders a herd not of sheep but of gray, dying wolves, led by a cloaked shepherd tossing out seeds on the ground.\n\nYou fill with rage at the sight of the farce. You think to confront the shepherd, to berate him for sowing a barren land and herding not livestock but predators. You think to rip away the notion of a peaceful land sustained by farming, to compel the shepherd to take up arms and slay the wolves and feast on their meat, to give meaning to his struggle and give it purpose and thus death.\n\nBut the words do not come, and instead see the shepherd's bearded face begin to squirm and morph, and he turns to you and you see a face you recognize for a moment but then his mouth opens and laughs and keeps opening and the maw consumes him whole, and underneath the hood you can now see nothing but teeth, teeth affixed in an evil smile that is reflected by the teeth in the starless, empty void of the sky, and the shepherd's staff twists and warps and turns and an axehead appears at its tip and the cackling fills your ears and the wolves have the faces of men and you stare at one and it is your face.%SPEECH_ON%Death and purpose indeed, 'mine chosen'. I await thee.%SPEECH_OFF%The cackling grows louder still, piercing you, and you double over in pain, and you are back in camp with %chosen% and the black rock is gone.%SPEECH_ON%Captain, are you alright? You've gone pale.%SPEECH_OFF%You remember nothing. You were feeling tired and headed to your tent, but the fatigue is gone, replaced only with an empty, gnawing doubt. The rest of the company feel it too, but none can put a finger on why. Something just feels...wrong.}";
	}
});

::mods_hookNewObject("events/offplus_runeknights_events/events/runeseeker_joins_event", function(rje) {
	local screen = rje.m.Screens.filter(function(index, screen) {
		return screen.ID == "A";
	})[0];

	local start = screen.start;
	screen.start = function(_event) {
		start(_event);
		local gender = _event.m.Dude.getGender();
		Text = "%terrainImage%{A lone " + Const.LegendMod.getPronoun(gender, "person") + " approaches you from the wilderness. You look " + Const.LegendMod.getPronoun(gender, "them") + " up and down. " + Const.LegendMod.getPronoun(gender, "They") + " hulks like a beast, adorned in furs and tribal symbols, yet seems tiny and featureless against the expanse of the northern wastes. " + Const.LegendMod.getPronoun(gender, "They") + " stops several paces away and speaks in a voice that sounds like it's never been used.%SPEECH_ON%Old Ironhand's chosen?%SPEECH_OFF%You nod, subtly motioning for the company to make ready for a fight. Even among the northerners, those who know Ironhand's name rarely bear good intent towards his followers. " + Const.LegendMod.getPronoun(gender, "They") + " shows no hostility, however, instead lowering " + Const.LegendMod.getPronoun(gender, "their") + " head slightly.%SPEECH_ON%I seek the end. It is proper to seek alongside a rune carver, lest I fall in obscurity. Will you have me?%SPEECH_OFF% | Barbarians are a dangerous folk, even to their own kind. This holds doubly true for those who besmirch the ancestors in favor of their own glory, as Old Ironhand's followers are oft accused of. As such, you're not quite sure what to expect when a northerner stops you on the road, but as you reach for your sword " + Const.LegendMod.getPronoun(gender, "they") + " surprises you with a parley.%SPEECH_ON%You follow the rune god. He spoke of you, and said that if I died in your company you would do me the honor of granting the rune rite. Are such omens true? Will you allow me to fight with you?%SPEECH_OFF%}";

		local r = Math.rand(0, 2);

		if (r == 0)
			_event.m.Dude.getBackground().m.RawDescription = "It was in the barren north, surrounded by forgotten men sacrificed in the names of their ancestors, that %name% first heard Old Ironhand's call. %They% has wandered the lands ever since, guided by the old god's quiet whispers, searching for those who know the secret of the rune rite. It wasn't long before %they% found %their% way into the %companyname%.";
		else if (r == 1)
			_event.m.Dude.getBackground().m.RawDescription = "Often sickly, %name% was told one day by %their% tribe's shaman that %they% had but a few years left to live. Rather than waste it worshipping the ancestors who failed to guard %them% from the ailment, %they% set off to find %their% own glory. Hearing of Old Ironhand's rune rite, %they% now seeks the company of warriors whose aspirations reach beyond their own deaths.";
		else
			_event.m.Dude.getBackground().m.RawDescription = "With a glare as hard as steel and as cold as the northern lands %they% once called home, %name% cuts an imposing figure. You don't know what drove the barbarian into Old Ironhand's flock, but %they% fights like a %person% possessed and is wholly unconcerned about living to see the next day's dawn. A model warrior, truly.";
		_event.m.Dude.getBackground().buildDescription(true);
	}
});

::mods_hookNewObject("events/offplus_runeknights_events/events/trickster_god_emissary_event", function(tgee) {
	foreach(screen in tgee.m.Screens) {
		if (screen.ID == "B") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);
				_event.m.Dude.setGender(0);
				_event.m.Dude.getBackground().setGender(0);

				local gender = _event.m.Barbarian;
				Text = "{%terrainImage%%barbarian% the barbarian steps forward.%SPEECH_ON%I recognize that man. He was kin. We thought him lost to a blizzard years ago.%SPEECH_OFF%The " + Const.LegendMod.getPronoun(gender, "person") + "'s face takes on a plaintive aspect as " + Const.LegendMod.getPronoun(gender, "they") + " observes the madman murmuring to himself, walking about in a strange, looping pattern.%SPEECH_ON%Captain, let's take him with us. He was chosen when I knew him, and even in this state he'll be a valuable addition to the %companyname%.%SPEECH_OFF%The strange man freezes in his tracks and stares at you both, a rope of drool hanging from his mouth, eyes full of fear and wonder and malice and yet vacant at the same time.}";
			}
		}

		if (screen.ID == "C") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);
				_event.m.Barbarian.getMoodChanges()[1].Text = "Found " + Const.LegendMod.getPronoun(_event.m.Barbarian.getGender(), "their") + " long-lost kin " + _event.m.Dude.getName();
			}
		}

		if (screen.ID == "D") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);

				local gender = _event.m.Barbarian;
				Text = "{%terrainImage%You tell the " + Const.LegendMod.getPronoun(gender, "person") + " no. There are enough madmen in the company already, and you're not looking to add what seems to be a deranged lunatic to the mix - even a deranged lunatic with a strange rune. The barbarian is clearly disappointed, but accepts your decision in stony silence.\n\nYou tell the company to move on, glancing back at the crazed man. He's still standing there, frozen in place, eyes full and vacant. Then his face breaks into another wide grin and he runs off, whooping and hollering and cackling with a joy that only those free of sanity's shackles possess.}";
				_event.m.Barbarian.getMoodChanges()[0].Text = "You refused to take in " + Const.LegendMod.getPronoun(gender, "their") + " long-lost kin";
			}
		}
	}
});

::mods_hookNewObject("events/offplus_runeknights_events/scenario/runeknights_intro_event", function(rie) {
	local screen = rie.m.Screens.filter(function(index, screen) {
		return screen.ID == "A";
	})[0];

	screen.Text = "[img]gfx/ui/events/event_145.png[/img]{%deadbro% is at the base of the tree, propped up by the heavy javelin impaling him to its trunk. The shaft of the weapon loses all form where it meets flesh, its head obscured by an ocean of blood whose tides steadily pump the warrior's life onto the ground.\n\nIt's a good wound - and quite mortal - earned by the many slain foes littering the area around him. You're proud of the man, and tell him so. His eyes flicker. You order %death_knight% to transcribe a rune for him. The eyes close and do not open again. As the last vestiges of life escape from his fleshen vessel, you motion for the others to collect the bodies and build a pyre.\n\nThe corpse smoke fills yours eyes, then your lungs, then finally your mind, and there he is. Ironhand's cloaked, wizened form is hunched in front of you, as frail and as formidable as ever. He points a bony finger and speaks in his fathomless tongue.%SPEECH_ON%I hath need of thine skills elsewhere, mine chosen. The green-men plot beyond the passes, the dead stir in their graves below, and now the dead-but-living skulk in the shadows of civilization itself. Waste not thineself hither - hie you to visit thine death upon mine foes.%SPEECH_OFF%The vision fades and you see the pyre, now a smoldering mound of ash and bone. You've heard tell of sellswords, men who are paid to fight and roam the world - an ideal profession from which to mete out the old god's judgement further afield than these northern wastes. You give the edict to the band and tell them to gather their supplies.}"
});