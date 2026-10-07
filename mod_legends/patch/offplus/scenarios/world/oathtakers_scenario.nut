::mods_hookExactClass("scenarios/world/oathtakers_scenario", function(os) {
	local create = ::mods_getMember(os, "create");
	local onSpawnAssets = ::mods_getMember(os, "onSpawnAssets");

	::mods_override(os, "create", function() {
		create();

		m.Order = 41;
		setRosterReputationTiers(Const.Roster.createReputationTiers(m.StartingBusinessReputation));
	});

	::mods_override(os, "onSpawnAssets", function() {
		onSpawnAssets();

		local bros = World.getPlayerRoster().getAll();

		// Legends veteran level perk points, ick, eww, cooties
		bros[0].setVeteranPerks(2);
		bros[1].setVeteranPerks(2);

		bros[0].getBackground().m.RawDescription = "{%name% is rather old, nigh on decrepit, a rarity amongst the militant and doubly so amongst the Oathtakers. Few throw themselves into danger with the reckless abandon of Young Anselm's paladins, and to grow old in their number requires great skill indeed. Though age has dulled some of %their% natural abilities, %they% still commands much respect from %their% fellow Oathtakers. Seeing %them% bellow as %they% cleaves through the order's foes, you can see why. | %name% is a walker of many spirits, having wandered the world in the shell of soldier, farmer, sellsword, and more. %They% has never divulged what events saw %them% join the Oathtakers, but in the years since %they% has proven one of the most ardent followers of the Oaths. When schism tore the group asunder, none questioned %name%'s right to safeguard Young Anselm's skull.}";
		bros[0].getBackground().buildDescription(true);

		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Head));

		items.equip(Const.World.Common.pickArmor([ [1, "adorned_mail_shirt"] ]));
		items.equip(Const.World.Common.pickHelmet([ [1, "heavy_mail_coif"] ]));

		bros[1].getBackground().m.RawDescription = "{Orphaned by a brigand raid, %name% was taken in and raised by a traveling group of Oathtakers. The eclectic warriors taught %them% how to survive on the road, how to fight, and most importantly how to follow Young Anselm's Oaths. Though now a grown %person%, %they% has yet to let the world's horrors and grind wear %them% down. In moments of honesty, %they% reminds you of yourself. In moments of reflection, you realize that %they% will likely one day resemble you as you are now. But until then, %their% earnest nature is a nice change of pace from the cynicism typical of sellswords.}";
		bros[1].getBackground().buildDescription(true);

		items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Head));

		items.equip(Const.World.Common.pickArmor([ [1, "adorned_warriors_armor"] ]));
		items.equip(Const.World.Common.pickHelmet([ [1, "adorned_closed_flat_top_with_mail"] ]));
	});
});

::mods_hookNewObject("events/offplus_oathtakers_events/events/oathtakers_ruined_priory_event", function(orpe) {
	foreach(screen in orpe.m.Screens) {
		if (screen.ID == "Treasures") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);
				local gender = _event.m.Oathtaker.getGender();
				Text = "[img]gfx/ui/events/event_40.png[/img]{You tell the monk your company can pass whatever test he has. He ponders a moment.%SPEECH_ON%The Oath of Righteousness calls on men to address the evil of unlife, and to set aside worldly matters in pursuit of its correction. Yet the Oath of Vengeance harkens to the more pressing dangers of the greenskin menace. After all, it was orcs and goblins, not undead, that broke our lands those many years ago. So why doesn't every Oathtaker follow the Oath of Vengeance and eschew the pursuit of lesser threats?%SPEECH_OFF%The company whisper amongst themselves until %oathtaker% steps up and speaks with confidence.%SPEECH_ON%'Tis a false choice! The Oath of Righteousness is a light to illuminate the crypt and the necropolis, while the Oath of Vengeance is a guide through wild and warcamp. Too often is the threat of the orc masked by the horrors of undeath, or the profanity of the necromancer given purchase because the fear of pillaging goblins. The pursuit of one Oath stumbles without the other, and so we must heed them with equal focus.%SPEECH_OFF%The priest smiles warmly.%SPEECH_ON%A fine answer, " + (gender == 0 ? "lad" : "lass") + ". I'm glad to see the order hasn't lost its way.%SPEECH_OFF%He disappears into the ruin and returns a moment later carrying a valuable looking tome.%SPEECH_ON%Here, from the vault. I have no need of it, and I would be honored if Anselm's faithful put it to good use.%SPEECH_OFF%You thank the man graciously and have " + Const.LegendMod.getPronoun(gender, "their") + " gift put in inventory.}";
			};
		}
	}
});

::mods_hookNewObject("events/offplus_oathtakers_events/scenario/oathtakers_intro_event", function(oie) {
	local screen = oie.m.Screens.filter(function(index, screen) {
		return screen.ID == "A";
	})[0];

	screen.Text = "[img]gfx/ui/events/event_180.png[/img]{It's been some time since you left the Oathtakers, and you've not regretted it for a day. The Oaths were stifling and constant, you never even got to hold Young Anselm's skull, and last you heard some debacle saw an Oathbringer steal off with the lad's preeminent jaw. Needless to say, you were none too happy when you opened the door this morning and were greeted by two Oathtakers, %oathtaker1% and %oathtaker2%.\n\nInitially you thought them assassins sent to avenge some imagined apostasy you commited by leaving, but the younger of the two offers you a bag of gold before you can draw your sword.%SPEECH_ON%The order has fallen on dark times. Evil stalks every corner of the world and we two cannot stamp it out alone. The Oathtakers need more men, but these few crowns are all we have. Our talents are fit only for mercenary work, yet we've no aptitude for the dark dealings of elder's halls and noble's chambers. We need help.%SPEECH_OFF%You inspect the gold. It's a respectable sum for an individual, but meager funds with which to fund an entire sellsword company. The older of the two paladins then produces a leather-wrapped bundle of parchment - the so-called Book of Oaths, though its damned contents seem slimmer than you remember -  and a familiar polished skull. Young Anselm. You've lost touch with the organization, but seeing that lad's dumb dome still brings a stir in your heart.%SPEECH_ON%The few Oaths we could safeguard, and our order's most treasured relic. With their guidance and your shrewdness, surely our venture shall succeed!%SPEECH_OFF%You have only one condition: you will take the Oath of Captaincy, which means all the battling and rough roading will be done by others. The Oathtakers agree without pause, and with that, you're off.}";
});

::mods_hookNewObject("events/offplus_oathtakers_events/special/oathtaker_brings_oaths_event", function(oboe) {
	foreach(screen in oboe.m.Screens) {
		if (screen.ID == "OathsUnlock") {
			local start = screen.start;

			screen.start = function(_event) {
				start(_event);
				local gender = _event.m.Dude.getGender();
				if (_event.m.OathGroup == "Chivalry")
					Text = "[img]gfx/ui/events/event_180.png[/img]{A " + Const.LegendMod.getPronoun(gender, "person") + " strides into camp escorted by %randombrother%, " + Const.LegendMod.getPronoun(gender, "their") + " head held high. In " + Const.LegendMod.getPronoun(gender, "their") + " hand " + Const.LegendMod.getPronoun(gender, "they") + " clutches a leather-bound folio. " + Const.LegendMod.getPronoun(gender, "They") + " comes up to you and opens it to reveal a sheaf of remarkably pristine papers.%SPEECH_ON%'Tis an unusual chimera you have here, captain, to marry oathtaking and sellswording so. I've heard tell of your company from laity and villain alike, however, and their words suggest you answer well to both callings.%SPEECH_OFF%" + Const.LegendMod.getPronoun(gender, "They") + " beholds the camp and company with a searching look, then gestures at the folio and smiles.%SPEECH_ON%I'm heartened that my eyes perceive the same. I've come on behalf of the order to deliver these Oaths, that your men might know creeds of virtue to match their skill. I quest to uphold them myself, but the words are ingrained in my heart and I've no need of the papers to hear Young Anselm's issuance.%SPEECH_OFF%Among the documents, your eye is caught in particular by two that detail honor and courage in combat. You transfer them all to the Book of Oaths and return to address the " + Const.LegendMod.getPronoun(gender, "person") + ".}";
				else if (_event.m.OathGroup == "Combat")
					Text = "[img]gfx/ui/events/event_180.png[/img]{%randombrother% steps into your tent.%SPEECH_ON%There's an Oathtaker here to see you, sir. Says " + Const.LegendMod.getPronoun(gender, "they") + " has something you'll want to see.%SPEECH_OFF%You set aside your quill and enter the camp to find a tall " + Const.LegendMod.getPronoun(gender, "person") + " clad in armor with " + Const.LegendMod.getPronoun(gender, "their") + " hands tented over the hilt of a weapon. " + Const.LegendMod.getPronoun(gender, "They") + " speaks up as you approach.%SPEECH_ON%Greetings, captain. I am " + _event.m.Dude.getName() + ", chosen warden of the Oaths of combat. It was shrewd to steer a band of Oathtakers towards mercenary work. In my own pursuit of the Oaths I've found myself in many a sellswording band, and the work offers ample opportunity to prove one's worth in battle.%SPEECH_OFF%" + Const.LegendMod.getPronoun(gender, "They") + " produces a parcel from " + Const.LegendMod.getPronoun(gender, "their") + " pack and hands it over. You open it. Inside is a collection of papers and holy scripts, some aged and dogeared, others stained with flecks of blood.%SPEECH_ON%I confer to your company these Oaths. Myself and the rest of the order have deemed your lot worthy of their keeping. It is a privilege, but also a gift - any of your company would do well to dedicate themselves to the first Oathtaker's treatises on combat.%SPEECH_OFF%You delicately place them into the Book of Oaths and thank the " + Const.LegendMod.getPronoun(gender, "person") + ".}";
				else if (_event.m.OathGroup == "Flesh")
					Text = "[img]gfx/ui/events/event_180.png[/img]{A curious visitor has made their way into camp. What was surely once a hail and hearty Oathtaker now stands doubled over before you, winded and bruised, leaning on " + Const.LegendMod.getPronoun(gender, "their") + " weapon for support. When " + Const.LegendMod.getPronoun(gender, "they") + " speaks, however, " + Const.LegendMod.getPronoun(gender, "their") + " voice is strong and even toned.%SPEECH_ON%Good tidings, captain. I come bearing gifts from the order.%SPEECH_OFF%" + Const.LegendMod.getPronoun(gender, "They") + " shakily proffers a collection of loose papers and scrolls.%SPEECH_ON%The Oaths pertaining to the flesh. Truly a worthy set of aspirations for any Oathtaker to follow, and a keen reminder that though the body be bruised and battered, the quest goes on. While my own trials continue, it is time for your company to benefit from Young Anselm's wisdom.%SPEECH_OFF%You question how much wisdom there can truly be in a codex built on self-torture, but you accept them out of concern it would harm the " + Const.LegendMod.getPronoun(gender, "person") + " to require further use of " + Const.LegendMod.getPronoun(gender, "their") + " limbs. You collect them into the Book of Oaths, making note that a handful of the scripts might do more good than ill if followed, then turn back to your beleaguered visitor. }";
				else if (_event.m.OathGroup == "Glory")
					Text = "[img]gfx/ui/events/event_180.png[/img]{Before you in camp stands perhaps the least subtle " + Const.LegendMod.getPronoun(gender, "person") + " you've ever seen. Clad in gleaming, polished armor, plastered all over with miscellaneous trophies and sigils, and clutching a stack of Young Anselm's writings, you have a feeling you could see the " + Const.LegendMod.getPronoun(gender, "person") + " and recognize " + Const.LegendMod.getPronoun(gender, "them") + " as an Oathtaker from a mile away.%SPEECH_ON%Ho there, captain! The order bid me relinquish these Oaths to your safeguard, in recognition of your accomplishments thus far.%SPEECH_OFF%" + Const.LegendMod.getPronoun(gender, "They") + " absentmindedly polishes a buckle as " + Const.LegendMod.getPronoun(gender, "they") + " hands you the texts.%SPEECH_ON%After all, was it not our own founder who said, \'and let every man be given lease to prove his own worth?\' My own questing can continue without need to hoard his writings to my own.%SPEECH_OFF%You add them to the Book of Oaths and return your attention back to the " + Const.LegendMod.getPronoun(gender, "person") + ", who appears to be adjusting some medal to make it more obvious.}";
				else if (_event.m.OathGroup == "Nemeses")
					Text = "[img]gfx/ui/events/event_180.png[/img]{%randombrother% comes jogging up to you in camp.%SPEECH_ON%Cap, we've got a visitor. Think you ought to come.%SPEECH_OFF%Your guest turns out to be an Oathtaker. " + Const.LegendMod.getPronoun(gender, "They") + " scowls at the company, and the camp, and even the sky with an unnerving intensity. The dirt caked on " + Const.LegendMod.getPronoun(gender, "their") + " boots and garb betray familiarity with the road, and the various trophies that adorn " + Const.LegendMod.getPronoun(gender, "them") + " betray a penchant for battle against exotic foes. The terseness of " + Const.LegendMod.getPronoun(gender, "their") + " manner, in turn, betrays little care for the niceties of society.%SPEECH_ON%Captain. Finally. The order bid me confer to you these Oaths, that you and your company might take up arms in our great crusade as well.%SPEECH_OFF%" + Const.LegendMod.getPronoun(gender, "They") + " hands you a bundle of scrolls, blackened by age and stained by blood and sweat and tears and all the fluids men tend to shed in moments of fear.%SPEECH_ON%I myself have been devoted to the undoing of those that would undo us, a task I must return to forthwith, for ever in the recesses of the world does evil spawn.%SPEECH_OFF%You thank the " + Const.LegendMod.getPronoun(gender, "person") + " and add the papers to the Book of Oaths.}";
			}
		}

		if (screen.ID == "OathsJoin") {
			local start = screen.start;

			screen.start = function(_event) {
				start(_event);
				local gender = _event.m.Dude.getGender();
				Text = "[img]gfx/ui/events/event_180.png[/img]{The " + Const.LegendMod.getPronoun(gender, "person") + " ponders your offer for not very long at all, then clasps your hand in an uncomfortably firm handshake.%SPEECH_ON%Aye, as Oathtakers!%SPEECH_OFF% | The Oathtaker doesn't even stop to think before accepting.%SPEECH_ON%Aye, let us bring glory to Young Anselm's name together!%SPEECH_OFF% | " + Const.LegendMod.getPronoun(gender, "They") + " stares at you with an intensity you've grown accustomed to expect from " + Const.LegendMod.getPronoun(gender, "their") + " cult.%SPEECH_ON%So it shall be.%SPEECH_OFF%And then, much more loudly.%SPEECH_ON%And death to the Oathbringers!%SPEECH_OFF%The rest of the company cheer with " + Const.LegendMod.getPronoun(gender, "them") + ", although you suspect some more from surprise at the abruptness of " + Const.LegendMod.getPronoun(gender, "their") + " outburst than from its content. | The Oathtaker doesn't say anything. " + Const.LegendMod.getPronoun(gender, "They") + " just shakes your hand and falls in with the ranks, as though it were the most natural thing " + Const.LegendMod.getPronoun(gender, "they") + " could do. | The " + Const.LegendMod.getPronoun(gender, "person") + " bellows out a hearty laugh.%SPEECH_ON%A fine notion! Very well, captain, as Oathtakers!%SPEECH_OFF% | The " + Const.LegendMod.getPronoun(gender, "person") + " bellows out a hearty laugh.%SPEECH_ON%A fine notion! Very well, captain, for Young Anselm!%SPEECH_OFF% | " + Const.LegendMod.getPronoun(gender, "They") + " strokes " + Const.LegendMod.getPronoun(gender, "their") + " chin thoughtfully for a moment.%SPEECH_ON%I can think of no better company than your own in which to pursue the Oaths and bring steel to the flesh of Oathbringer scum. Very well!%SPEECH_OFF%Well, all right.}";
			}
		}

		if (screen.ID == "OathsArmorReward") {
			local start = screen.start;

			screen.start = function(_event) {
				local rewards = _event.getScaledRewards();

				World.Assets.getStash().makeEmptySlots(rewards.len());

				foreach (reward in rewards) {
					local item;
					if (reward.find("helmet") != null)
						item = Const.World.Common.pickHelmet([ [1, reward.slice(8)] ]);
					else
						item = Const.World.Common.pickArmor([ [1, reward.slice(6)] ]);

					World.Assets.getStash().add(item);
					List.push( { id = 10, icon = "ui/items/" + item.getIcon(), text = "You gain " + Const.Strings.getArticle(item.getName()) + item.getName() } );
				}

				local gender = _event.m.Dude.getGender();
				Text = "[img]gfx/ui/events/event_180.png[/img]{The visitor turns to leave, but stops short.%SPEECH_ON%Oh, I almost forgot. Here, take this. The armor of %randomoathtakername%. I'm sure a member of the order as famous as him needs no introduction. May his shell serve you better than it did him.%SPEECH_OFF%You nod as if you know all about %randomoathtakername% and his exploits and take the armor. The " + Const.LegendMod.getPronoun(gender, "person") + " flashes some Oathtaker sign of solidarity with " + Const.LegendMod.getPronoun(gender, "their") + " hand and you awkwardly mimic it as " + Const.LegendMod.getPronoun(gender, "they") + " turns and leaves. | The " + Const.LegendMod.getPronoun(gender, "person") + " produces a small chest you failed to notice before. You've no idea where " + Const.LegendMod.getPronoun(gender, "they") + " hid the thing or how " + Const.LegendMod.getPronoun(gender, "they") + " lugged it on " + Const.LegendMod.getPronoun(gender, "their") + " own.%SPEECH_ON%One more thing. The order sent you proper armor. It won't do for your men to go oathtaking in whatever recreant garb you'll find in a marketplace.%SPEECH_OFF%You inspect the contents of the chest and it is, indeed, a cut above what you typically get hawked in towns. You turn to thank the " + Const.LegendMod.getPronoun(gender, "person") + " but " + Const.LegendMod.getPronoun(gender, "they") + "'s already striding off, pursuing " + Const.LegendMod.getPronoun(gender, "their") + " next task. | %SPEECH_ON%The Oaths are not the only gift I come bearing. Here.%SPEECH_OFF%He grabs a heavy bundle from his pack and tosses it at you. You stagger a bit from its weight and quickly pass it off to %randombrother%.%SPEECH_ON%Proper armor, forged and sanctified under the auspice of %randomoathtakername% himself. May it serve you well.%SPEECH_OFF% | The " + Const.LegendMod.getPronoun(gender, "person") + " starts, suddenly remembering something.%SPEECH_ON%Oh! I nearly forgot. Here, one more boon, a set of armor. I'd wager you'd be hard pressed to find its like elsewhere.%SPEECH_OFF%You take it and immediately wonder how the " + Const.LegendMod.getPronoun(gender, "person") + " could have forgotten " + Const.LegendMod.getPronoun(gender, "they") + " carried such a heavy load. | %SPEECH_ON%One more thing.%SPEECH_OFF%The Oathtaker produces a heavy package and hands it to you.%SPEECH_ON%The order bade me give you this armor. An Oathtaker without a carapace to protect him from the world's evils is as naked as a sellsword without a weapon, no?%SPEECH_OFF%You have %randombrother% put the package in inventory and see the visitor off.}";
			}
		}
	}

	local scaleBroForOaths = oboe.scaleBroForOaths;
	oboe.scaleBroForOaths = function(dude) {
		scaleBroForOaths(dude);

		local items = dude.getItems();
		local helmet = items.getItemAtSlot(Const.ItemSlot.Head);
		if (helmet != null) {
			if (helmet.getID() == "armor.head.heavy_mail_coif") {
				items.unequip(helmet);
				items.equip(Const.World.Common.pickHelmet([ [1, "heavy_mail_coif"] ]));
			} else if (helmet.getID() == "armor.head.adorned_closed_flat_top_with_mail") {
				items.unequip(helmet);
				items.equip(Const.World.Common.pickHelmet([ [1, "adorned_closed_flat_top_with_mail"] ]));
			} else if (helmet.getID() == "armor.head.adorned_full_helm") {
				items.unequip(helmet);
				items.equip(Const.World.Common.pickHelmet([ [1, "adorned_full_helm"] ]));
			}
		}

		if (items.getItemAtSlot(Const.ItemSlot.Body).getID() == "armor.body.adorned_mail_shirt") {
			items.unequip(items.getItemAtSlot(Const.ItemSlot.Body));
			items.equip(Const.World.Common.pickArmor([ [1, "adorned_mail_shirt"] ]));
		} else if (items.getItemAtSlot(Const.ItemSlot.Body).getID() == "armor.body.adorned_warriors_armor") {
			items.unequip(items.getItemAtSlot(Const.ItemSlot.Body));
			items.equip(Const.World.Common.pickArmor([ [1, "adorned_warriors_armor"] ]));
		} else if (items.getItemAtSlot(Const.ItemSlot.Body).getID() == "armor.body.adorned_heavy_mail_hauberk") {
			items.unequip(items.getItemAtSlot(Const.ItemSlot.Body));
			items.equip(Const.World.Common.pickArmor([ [1, "adorned_heavy_mail_hauberk"] ]));
		}
	}
});

::mods_hookNewObject("events/offplus_oathtakers_events/special/oathtakers_book_copied_event", function(obce) {
	local screen = obce.m.Screens.filter(function(index, screen) {
		return screen.ID == "A";
	})[0];

	screen.Text = "[img]gfx/ui/events/event_15.png[/img]{You're writing in your journal when you hear a commotion in camp. Exiting your tent to investigate, you find the company formed into two opposing groups around the fire. You grab %randombrother% by the collar and demand an explanation.%SPEECH_ON%It's a disaster, sir! There are two Oath books! Two of 'em! There's only supposed to be one! Got the men accusing each other of being Oathbringers and trying to pervert the Oaths!%SPEECH_OFF%You step between the factions and demand to see both books. They hand them over and you flip through them. Able to find no meaningful difference between them, you pick one at random and toss it into the fire.You hold up the remaining book and shout above the ensuing hubbub.%SPEECH_ON%There has only ever been one Book of Oaths, and so shall it remain! Brothers, don't be deceived by treachery! This is surely some Oathbringer plot meant to divide us. Do not give them the satisfaction!%SPEECH_OFF%The company grumble and grouse, but both groups have already decided theirs was the book not cast into flame and forgotten exactly who was in which camp. Morale will be low for some time as the company recovers from this scandal, but better fragile than broken.}";
});

::mods_hookNewObject("events/offplus_oathtakers_events/special/oathtakers_book_missing_event", function(obme) {
	local screen = obme.m.Screens.filter(function(index, screen) {
		return screen.ID == "A";
	})[0];

	screen.Text = "[img]gfx/ui/events/event_15.png[/img]{You step out of your tent to find the company in a furor. Apparently one of them found the Book of Oaths discarded along the side of the road, rather than safely ensconced in inventory. Naturally, they're upset and the transgression already has them pointing fingers at one another for who bears ultimate responsibility.\n\nThinking fast, you interject that it must have been a thief who failed to realize the true value of the book and threw it away. The explanation seems to satisfy the oathtakers and direct their hostility away from each other - and more importantly, you - but the debacle has left them on edge nonetheless. It will be some time before morale recovers fully.}";
});

::mods_hookNewObject("events/offplus_oathtakers_events/special/oathtakers_skull_copied_event", function(osce) {
	local screen = osce.m.Screens.filter(function(index, screen) {
		return screen.ID == "A";
	})[0];

	screen.Text = "[img]gfx/ui/events/event_plus_01.png[/img]{You exit your tent to the sound of the company making a great commotion. You hurry over to the source of the sound and quickly find its cause: in the middle of camp lies not just Young Anselm's skull, but its duplicate. The two are identical, down to the shape and size of the mark on the first Oathtaker's forehead. The only conclusion to draw is that one - or both - are forgeries, and the companies' more faithful are frothing at the mouth.\n\nBefore you can even begin to placate them, the Oathtakers of the company grab one of the skulls and promptly march out of the camp. You think to stop them, but the look in their eyes tells you they'd kill anyone who got in their way.\n\nThe rest of the men are understandably sullen and a dour mood takes over the camp. You glance at the skull that remains, unsure if it's the true artifact or a mere copy, or if either of them were ever real. You gaze into its empty sockets and realize you'll never know for certain.}";
});

::mods_hookNewObject("events/offplus_oathtakers_events/special/oathtakers_skull_missing_event", function(osme) {
	local screen = osme.m.Screens.filter(function(index, screen) {
		return screen.ID == "A";
	})[0];

	screen.Text = "[img]gfx/ui/events/event_plus_01.png[/img]{You exit your tent to take stock of the company and find them ringing a stool in stony silence. Upon the stool sits the skull of Young Anselm, its gaping eye sockets seeming to point at you regardless of where you stand. %randombrother% comes up to you and explains that one of them found the skull on the ground some ways away from camp, rather than safely in inventory. The implications are obvious.\n\nFortunately, the Oathtakers of the company are too cooperative to begin accusing others of heresy, choosing to believe that it was instead some accident that saw their founder's remains tossed aside. Unfortunately, even the least superstitious among them sees this as an ill-omen of immense proportions. Their morale will not recover for some time.}";
});

::mods_hookNewObject("events/events/dlc8/oathbreaker_event", function(oe) {
	foreach(screen in oe.m.Screens) {
		if (screen.ID == "OathtakersJoin") {
			local start = screen.start;

			screen.start = function(_event) {
				start(_event);
				_event.m.Dude.setGender(0);
				_event.m.Dude.getBackground().setGender(0);

				local items = _event.m.Dude.getItems();
				if (items.getItemAtSlot(Const.ItemSlot.Head).getID() == "armor.head.heavy_mail_coif") {
					items.unequip(items.getItemAtSlot(Const.ItemSlot.Head));
					items.equip(Const.World.Common.pickHelmet([ [1, "heavy_mail_coif"] ]));
				} else if (items.getItemAtSlot(Const.ItemSlot.Head).getID() == "armor.head.adorned_closed_flat_top_with_mail") {
					items.unequip(items.getItemAtSlot(Const.ItemSlot.Head));
					items.equip(Const.World.Common.pickHelmet([ [1, "adorned_closed_flat_top_with_mail"] ]));
				} else if (items.getItemAtSlot(Const.ItemSlot.Head).getID() == "armor.head.adorned_full_helm") {
					items.unequip(items.getItemAtSlot(Const.ItemSlot.Head));
					items.equip(Const.World.Common.pickHelmet([ [1, "adorned_full_helm"] ]));
				}

				if (items.getItemAtSlot(Const.ItemSlot.Body).getID() == "armor.body.adorned_mail_shirt") {
					items.unequip(items.getItemAtSlot(Const.ItemSlot.Body));
					items.equip(Const.World.Common.pickArmor([ [1, "adorned_mail_shirt"] ]));
				} else if (items.getItemAtSlot(Const.ItemSlot.Body).getID() == "armor.body.adorned_warriors_armor") {
					items.unequip(items.getItemAtSlot(Const.ItemSlot.Body));
					items.equip(Const.World.Common.pickArmor([ [1, "adorned_warriors_armor"] ]));
				} else if (items.getItemAtSlot(Const.ItemSlot.Body).getID() == "armor.body.adorned_heavy_mail_hauberk") {
					items.unequip(items.getItemAtSlot(Const.ItemSlot.Body));
					items.equip(Const.World.Common.pickArmor([ [1, "adorned_heavy_mail_hauberk"] ]));
				}

				Characters.push(_event.m.Dude.getImagePath());
			}
		}

		if (screen.ID == "OathtakersExpel") {
			local start = screen.start;

			screen.start = function(_event) {
				local item;
				local stash = World.Assets.getStash();

				// Not sure if you can call `setCondition` on a layered item, so I'm leaving it off
				item = Const.World.Common.pickArmor([ [1, "adorned_heavy_mail_hauberk"] ]);
				stash.add(item);
				List.push({ id = 10, icon = "ui/items/" + item.getIcon(), text = "You gain " + Const.Strings.getArticle(item.getName()) + item.getName() });

				item = Const.World.Common.pickHelmet([ [1, "adorned_full_helm"] ]);
				stash.add(item);
				List.push({ id = 10, icon = "ui/items/" + item.getIcon(), text = "You gain " + Const.Strings.getArticle(item.getName()) + item.getName() });

				World.Assets.addMoney(3);
				List.push({ id = 10, icon = "ui/icons/asset_money.png", text = "You gain [color=" + Const.UI.Color.PositiveEventValue + "]3[/color] Crowns" });

				World.Assets.addMoralReputation(-5);

				local brothers = World.getPlayerRoster().getAll();

				foreach(bro in brothers) {
					if (Math.rand(1, 100) <= 33)
						bro.worsenMood(0.5, "Encountered an Oathbreaker and saw him punished");

					if (bro.getBackground().getID() == "background.paladin") {
						if (Math.rand(1, 100) <= 20) {
							bro.getBaseProperties().Bravery += 1;
							List.push({ id = 16, icon = "ui/icons/bravery.png", text = _event.m.Oathtaker.getName() + " gains [color=" + Const.UI.Color.PositiveEventValue + "]+1[/color] Resolve" });
							bro.positiveMood(0.0, "Was compelled to redouble " + Const.LegendMod.getPronoun(bro.getGender(), "their") + " efforts to follow the oaths");
						}
					}

					if(bro.getMoodState() < Const.MoodState.Neutral)
						List.push( { id = 10, icon = Const.MoodStateIcon[bro.getMoodState()], text = bro.getName() + Const.MoodStateEvent[bro.getMoodState()] } );
				}
			}
		}
	}
});