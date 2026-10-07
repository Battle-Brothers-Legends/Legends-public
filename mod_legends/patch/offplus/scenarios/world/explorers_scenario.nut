::mods_hookExactClass("scenarios/world/explorers_scenario", function(es) {
	local create = ::mods_getMember(es, "create");
	local onSpawnAssets = ::mods_getMember(es, "onSpawnAssets");

	::mods_override(es, "create", function() {
		create();

		setRosterReputationTiers(Const.Roster.createReputationTiers(m.StartingBusinessReputation));
	});

	::mods_override(es, "onSpawnAssets", function() {
		onSpawnAssets();

		local bros = World.getPlayerRoster().getAll();

		// Legends veteran level perk points, literally worse than the Pillager Rot
		bros[0].setVeteranPerks(2);
		bros[1].setVeteranPerks(2);
		bros[2].setVeteranPerks(2);

		bros[0].getBackground().m.RawDescription = "%name% spent %their% life in the wilds, isolated from civilization. %They% might be there still, were it not for the veins in %their% arms turning black one day, and a fateful encounter with two escaped prisoners who shared a similar condition.";
		bros[0].getBackground().buildDescription(true);

		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Body));

		local armor = Const.World.Common.pickArmor([ [1, "ragged_surcoat"] ]);
		armor.setUpgrade(new("scripts/items/legend_armor/armor_upgrades/legend_direwolf_pelt_upgrade"));
		items.equip(armor);

		bros[1].getBackground().m.RawDescription = "%name% was once an ambitious %noble% with a bright future in the courts ahead of %them%. Then one morning %they% awoke coughing up blackened blood, and the court physician informed %them% - at a distance - of the Pillager Rot. Most of %their% allies abandoned %them% outright. The rest were turned away by rumors that %they% contracted the malady during a highly illegal tryst with a stable of whores, or from pagan rituals undertaken with heretical cultists. Cast out and left with only %their% sword and what %they% could carry with %them%, %they% now seeks to find a cure at any cost and reclaim the life that was stolen from %them%.";
		bros[1].getBackground().buildDescription(true);

		bros[1].m.MoodChanges = [];
		bros[1].m.Mood = 3;

		bros[1].worsenMood(0.5, "Misses the power and comfort of " + Const.LegendMod.getPronoun(bros[1].getGender(), "their") + " life in court");
		bros[1].improveMood(1.5, "Excited to have a lead to follow");

		items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Head));

		items.equip(Const.World.Common.pickArmor([ [1, "padded_surcoat"] ]));
		items.equip(Const.World.Common.pickHelmet([ [1, "greatsword_hat"] ]));

		// Messengers can only be male in Legends v19, but they can still get assigned a Gender of 1.
		bros[2].getBackground().setGender(0);
		bros[2].setGender(0);
		bros[2].getBackground().m.RawDescription = "Once an innkeeper, %name% found %themselves% forced into the courier's vocation when %they% contracted the Rot. A stoic %person%, %they% took the change in stride, deciding it provided a good opportunity to explore the world and perhaps find a cure in far-flung places. You met %them% when you were both imprisoned by the fleshmen in the Wellspring of Blood, and together the two of you managed to escape. %They%'s been traveling with you ever since.";
		bros[2].getBackground().buildDescription(true);

		bros[2].m.MoodChanges = [];
		bros[2].m.Mood = 3;

		bros[2].worsenMood(0.5, "Still scarred by " + Const.LegendMod.getPronoun(bros[2].getGender(), "their") + " experiences at the Wellspring of Blood");
		bros[2].improveMood(1.5, "Happy to be exploring the wilderness again");

		items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Head));

		items.equip(Const.World.Common.pickArmor([ [1, "leather_tunic"] ]));
		items.equip(Const.World.Common.pickHelmet([ [1, "hood"] ]));
	});
});

::mods_hookNewObject("events/offplus_explorers_events/scenario/explorers_intro_event", function(eie) {
	local screen = eie.m.Screens.filter(function(index, screen) {
		return screen.ID == "A";
	})[0];

	local brothers = World.getPlayerRoster().getAll();
	screen.Text = "[img]gfx/ui/events/event_133.png[/img]{You nestle closer to the feeble campfire, trying not to remember more comfortable days long gone. You glance at %disowned%, sure the disgraced noble is doing much the same, and %wildman%, wholly unsure what runs through the wild" + Const.LegendMod.getPronoun(brothers[0].getGender(), "person") + "'s mind. The three of you sit there, dour as all victims of the PIllager Rot are, until your fourth and final companion, %messenger%, comes in from the gloom. " + Const.LegendMod.getPronoun(brothers[2].getGender(), "They") + " waves a sheaf of parchment at you.%SPEECH_ON%Was all the usual hogwash, 'cept this. The expedition notes of Arnold of Stohlfeste, some noble that went on a punitive crusade into the frontier after the Battle of Many Names. Whole thing ended in failure, of course, but see on this page here where he describes a tree with human faces standing in a pool of water. Their camp was raided before he could get a closer look, and afterwards he couldn't find it again.%SPEECH_OFF%%disowned% reads the passage briefly.%SPEECH_ON%That's the third account of this thing we've seen. Maybe it is truly the fountain of youth, maybe not, but it surely exists and it surely can't be any worse than getting corralled into leper colonies or chased out of healing houses. I say we find it ourselves!%SPEECH_OFF%The others agree. Mounting an expedition into the wilderness is no mean feat, however. You'll need supplies, crowns, and most importantly fighters. You make up your mind.%SPEECH_ON%We'll form a mercenary company. Plenty'll risk getting the Rot for the promise of exploring the unknown, and for enough crowns. We'll gather warriors and supplies and conquer the whole damned wilds if that's what it takes!%SPEECH_OFF%}";
});

::mods_hookNewObject("events/offplus_explorers_events/events/bros_contract_rot_event", function(bcre) {
	local screen = bcre.m.Screens.filter(function(index, screen) {
		return screen.ID == "A";
	})[0];

	screen.Text = "[img]gfx/ui/events/event_18.png[/img]{You meander through camp to take stock of the company, and to your dismay find that the Rot has taken firmer hold of the %companyname%. %randombrother% is vomiting %their% guts out in a corner, black bile spewing onto the ground, and a number of the others have had a truly depressing variety of new rashes, maladies, and ailments manifest. The company is understandably glum. | %randombrother% enters your tent, stifling a cough as %they% does.%SPEECH_ON%Sir, you should come take a look at this.%SPEECH_OFF%Around the camp mercenaries are wailing and groaning, scratching their throats and retching and generally existing in a state of newfound misery. It seems the Rot has claimed more victims. | It seems the Pillager Rot has lived up to its name once again, having picked the %companyname%'s camp as the target for its latest raid. You find the company incapacitated to varying degrees, doubled over and scratching themselves furiously and drenched in sweat, and mysterious black boils have broken out on %randombrother%'s skin. Some of them are definitely regretting the choices that led them here, and mood in the camp is generally dour. | You find %randombrother% wheezing uncontrollably. %They% looks at you, attempting to form a sentence, but can't get the words out. Giving up, %they% points you to a nearby tent where you find several of the others are writhing on the ground, nursing ailments and plagues that came over them in the night. Your fears are confirmed when you see blackened veins pulsate under the skin of one; the Rot has come for the %companyname% again.}";
});

::mods_hookNewObject("events/offplus_explorers_events/events/explorers_anatomist_joins_event", function(eie) {
	foreach(screen in eie.m.Screens) {
		if (screen.ID == "A") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);
				_event.m.Dude.getBackground().m.RawDescription = "%name% joined you, %they% claims, to better study the Pillager Rot up close. The %person% has a tendency both to unnerve and to get on the nerves of the rest of the company, but when all's said and done you can't fault the %person%'s bravery or %their% dedication to %their% craft. Few would risk contracting the Rot, knowing it like %name% does.";
				_event.m.Dude.getBackground().buildDescription(true);
				local gender = _event.m.Dude.getGender();
				Text = "[img]gfx/ui/events/event_184.png[/img]{A peculiar " + Const.LegendMod.getPronoun(gender, "person") + " a bit up the road calls out to you and shambles in your direction. Scrolls and potions and journals practically spill out of " + Const.LegendMod.getPronoun(gender, "their") + " pockets, and one would almost think " + Const.LegendMod.getPronoun(gender, "them") + " some sort of scalpel monger, so many adorn " + Const.LegendMod.getPronoun(gender, "their") + " packs and bags. Slightly out of breath from " + Const.LegendMod.getPronoun(gender, "their") + " ambling, " + Const.LegendMod.getPronoun(gender, "they") + " addresses you directly.%SPEECH_ON%Ah, you must be the captain of the %companyname%. I have been seeking you out for some time. You are the mercenary company afflicted by the malady colloquially known as the Pillager Rot, yes?%SPEECH_OFF%You grunt a confirmation, but put a hand on your sword. You're in no mood for another lecture on how the Rot is righteous punishment for some imagined transgression - or whatever other theories the imagination puts forth. The " + Const.LegendMod.getPronoun(gender, "person") + " either doesn't notice or doesn't care.%SPEECH_ON%Excellent, excellent. My name is %anatomist%, an anatomist. Most of my colleagues remain locked away in their laboratories, but the most hardy - like myself - are more resourceful in our studies. I myself have some experience as a barber surgeon, and if I say so myself I'm rather good with a scalpel, well any blade really, even thrown-%SPEECH_OFF%You interrupt and tell " + Const.LegendMod.getPronoun(gender, "them") + " to cut to the chase. " + Const.LegendMod.getPronoun(gender, "They") + " awkwardly coughs.%SPEECH_ON%I wish to study you. The Rot is a dread disease because it is so poorly understood, and it is exceedingly difficult to find live specimens-er, carriers, yes, carriers, in the halls of academia. No qualified researcher has yet taken up the mantle of field work, either, and so the affliction remains firmly in the realm of superstition and fantasy. I wish to change that. If you allow me to examine you and your men, I'm prepared to offer you what care I can and even fight for you, provided of course I am given a fair wage, board, proper research space, materials...%SPEECH_OFF%You tune out the growing list of material requirements and consider the offer.}";
			};
		}

		if (screen.ID == "B") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);
				local gender = _event.m.Dude.getGender();
				Text = "[img]gfx/ui/events/event_184.png[/img]{You interrupt the " + Const.LegendMod.getPronoun(gender, "person") + " and explain that if " + Const.LegendMod.getPronoun(gender, "they") + " travels with you it's almost guaranteed " + Const.LegendMod.getPronoun(gender, "they") + "'ll take on the Rot too. " + Const.LegendMod.getPronoun(gender, "They") + " looks you square in the eye.%SPEECH_ON%Field work comes with risk, that is why most avoid it - and precisely why it is so important. I'm prepared for what is to come, Captain.%SPEECH_OFF%You shrug and offer your hand to welcome " + Const.LegendMod.getPronoun(gender, "them") + " aboard. " + Const.LegendMod.getPronoun(gender, "They") + " shakes it without hesitation.}";
			};
		}
	}
});

::mods_hookNewObject("events/offplus_explorers_events/events/bros_contract_rot_event", function(bcre) {
	local screen = bcre.m.Screens.filter(function(index, screen) {
		return screen.ID == "A";
	})[0];

	screen.Text = "[img]gfx/ui/events/event_18.png[/img]{You meander through camp to take stock of the company, and to your dismay find that the Rot has taken firmer hold of the %companyname%. %randombrother% is vomiting %their% guts out in a corner, black bile spewing onto the ground, and a number of the others have had a truly depressing variety of new rashes, maladies, and ailments manifest. The company is understandably glum. | %randombrother% enters your tent, stifling a cough as %they% does.%SPEECH_ON%Sir, you should come take a look at this.%SPEECH_OFF%Around the camp mercenaries are wailing and groaning, scratching their throats and retching and generally existing in a state of newfound misery. It seems the Rot has claimed more victims. | It seems the Pillager Rot has lived up to its name once again, having picked the %companyname%'s camp as the target for its latest raid. You find the company incapacitated to varying degrees, doubled over and scratching themselves furiously and drenched in sweat, and mysterious black boils have broken out on %randombrother%'s skin. Some of them are definitely regretting the choices that led them here, and mood in the camp is generally dour. | You find %randombrother% wheezing uncontrollably. %They% looks at you, attempting to form a sentence, but can't get the words out. Giving up, %they% points you to a nearby tent where you find several of the others are writhing on the ground, nursing ailments and plagues that came over them in the night. Your fears are confirmed when you see blackened veins pulsate under the skin of one; the Rot has come for the %companyname% again.}";
});

::mods_hookNewObject("events/offplus_explorers_events/events/explorers_paladin_mob_event", function(epme) {
	foreach(screen in epme.m.Screens) {
		if (screen.ID == "FakeOathbringer") {
			local start = screen.start;
			screen.start = function(_event) {
				local potential_armor_loot = [ "adorned_warriors_armor" ];
				local potential_helmet_loot = [ "adorned_closed_flat_top_with_mail", "adorned_full_helm" ];

				local item = Const.World.Common.pickArmor(potential_armor_loot[Math.rand(0, potential_armor_loot.len() - 1)]);
				List.push({ id = 10, icon = "ui/items/" + item.getIcon(), text = "You gain " + item.getName() });
				World.Assets.getStash().add(item);

				local item = Const.World.Common.pickHelmet(potential_helmet_loot[Math.rand(0, potential_helmet_loot.len() - 1)]);
				item.setCondition(Math.max(1, item.getConditionMax() * 0.75));
				List.push({ id = 10, icon = "ui/items/" + item.getIcon(), text = "You gain " + item.getName() });
				World.Assets.getStash().add(item);
			};
		}

		if (screen.ID == "Oathtaker") {
			local start = screen.start;
			screen.start = function(_event) {
				local gender = _event.m.Oathtaker.getGender();
				Text = "[img]gfx/ui/events/event_180.png[/img]{You put your hands on your hips, hock a gob of spit at the zealot's feet, and stand your ground.%SPEECH_ON%Well? Bring him out. I'm ready to be smote.%SPEECH_OFF%The man's crazed grin widens, and he wordlessly motions his champion forward from the crowd. A huge man clad head-to-toe in trophy-adorned armor steps forward, his weapons held at the ready.%SPEECH_ON%And Young Anselm said, 'Suffer not the plague in y-%SPEECH_OFF%The man is cut off mid-sentence by a high-pitched, inhuman scream as a blur you vaguely recognize to be %oathtaker% the oathtaker dashes forward. " + Const.LegendMod.getPronoun(gender, "They") + " is upon the very-surprised Oathbringer in an instant, and in another instant " + Const.LegendMod.getPronoun(gender, "they") + " has caved the man's head in and is madly pulverizing it into a squelching red mist.\n\nThe mob, even more perturbed than you are, backs away slowly before scattering like the wind. You and %randombrother% manage to pull the screaming Oathtaker off the body before " + Const.LegendMod.getPronoun(gender, "they") + " can fully destroy it, and by the time " + Const.LegendMod.getPronoun(gender, "they") + "'s calmed down it seems whatever fire stirred in the laity has died down. There are no signs of life in the village beyond nervous glances peeking out from boarded up windows. An almost normal reception for a mercenary company, if one ignores the ruined body on the street. You tell the men to try to salvage the Oathbringer's armor and continue on your way.}";

				_event.m.Oathtaker.getBaseProperties().Initiative += 4;
				_event.m.Oathtaker.getSkills().update();

				List.push( { id = 16, icon = "ui/icons/initiative.png", text = _event.m.Oathtaker.getName() + " gains [color=" + Const.UI.Color.PositiveEventValue + "]+4[/color] Initiative" } );

				local potential_loot = [ "adorned_mail_shirt", "adorned_warriors_armor" ];

				local item = Const.World.Common.pickArmor("scripts/items/" + potential_loot[Math.rand(0, potential_loot.len() - 1)]);
				item.setCondition(Math.max(1, item.getConditionMax() * 0.5));
				List.push({ id = 10, icon = "ui/items/" + item.getIcon(), text = "You gain " + item.getName() });
				World.Assets.getStash().add(item);

				Characters.push(_event.m.Oathtaker.getImagePath());
			};
		}

		if (screen.ID == "Monk") {
			local start = screen.start;
			screen.start = function(_event) {
				local gender = _event.m.Dude.getGender();
				Text = "[img]gfx/ui/events/event_180.png[/img]{%monk% the monk steps forward and asks the peasant's muscle to do the same. A large " + Const.LegendMod.getPronoun(gender, "person") + " clad in fantastic looking armor comes forth.%SPEECH_ON%I apologize, mercenaries, but I have taken an Oath to protect the troubled, as these villagers are, and on Young Anselm's honor I cannot renege my duty. Please, leave in peace.%SPEECH_OFF%%monk% nods thoughtfully and counters the Oathtaker.%SPEECH_ON%A noble duty, to be sure. Consider, however, that if the Old Gods truly wished us gone, they could see it done without mortal intervention. No, I believe that this disease which afflicts us is a challenge, a test of our faith, for all things happen under their intent. Our meeting must be no different. We seek a cure to our condition, and the elimination of the Rot would safeguard more than just these villagers. Why not join us? Surely a follower of Young Anselm would find this a worthy goal?%SPEECH_OFF%The " + Const.LegendMod.getPronoun(gender, "person") + " thinks about it for not very long at all and claps %monk% on the back.%SPEECH_ON%A fine point, friend! I believe I shall join you on this quest of yours! An auspicious turn of events indeed!%SPEECH_OFF%}"

				_event.m.Dude.getBackground().m.RawDescription = "You met %name% in a small, backwards village where a local clergyman tried to use the Oathtaker to scare the %companyname% off. Hearing of your quest, %they% instead decided to join the company. The %person% gives endless sermons about Young Anselm's virtues and some sort of 'Oath of Illness', which wears a little thin, but you've no complaints about %their% skills as a fighter.";
				_event.m.Dude.getBackground().buildDescription(true);
			};
		}

		if (screen.ID == "MonkRejectRecruit") {
			local start = screen.start;
			screen.start = function(_event) {
				local gender = _event.m.Dude.getGender();
				Text = "[img]gfx/ui/events/event_180.png[/img]{You inform the " + Const.LegendMod.getPronoun(gender, "person") + " of your decision and there's an awkward pause before %monk% interjects again.%SPEECH_ON%It wouldn't do for you to catch our affliction as well, you see. We can cover more ground if we split up.%SPEECH_OFF%This seems to satisfy the Oathtaker's honor and " + Const.LegendMod.getPronoun(gender, "they") + " nods eagerly in agreement before promptly leaving. The mob awkwardly stands there, unsure what to do. The leader coughs nervously.%SPEECH_ON%Er, uh, this is clearly a sign from the gods that your condition has a purpose. We, er, of course welcome those touched by such divine provenance.%SPEECH_OFF%The man quickly walks away, glancing over his shoulder to check if you're following. Without their leader, the rest of the mob quickly disperses.}"
			};
		}

		if (screen.ID == "Raider") {
			local start = screen.start;
			screen.start = function(_event) {
				local gender = _event.m.Raider.getGender();
				Text = "[img]gfx/ui/events/event_64.png[/img]{%raider% the raider steps forward and spits at the monk.%SPEECH_ON%What fools. Aye, we've the Rot, but it doesn't stop us from fighting. We'll be fine. But you, you lot are living closer to death than we are. When the men and beasts in the hills come for you, and some farker puts an axehead in your back or a wolf tears out your lungs, remember how you drove away the sellswords that could have killed them. You can be sure word'll spread fast of a village too good to hire protection.%SPEECH_OFF%The " + Const.LegendMod.getPronoun(gender, "person") + " stalks out of the village, and you and the rest of the company follow suit. The mob hurls jeers and insults at your backs, but you can tell the raider's words struck a nerve. At the edge of town one of the local guildmasters sidles up to you furtively, a pouch of crowns jangling in his hands.%SPEECH_ON%Your " + Const.LegendMod.getPronoun(gender, "person") + " has the right of it, as you and I both know. Give me some time to dispell that zealot's notions from their heads. We have no feud with sellswords, regardless of their...condition, so long as they're reliable and get the job done. You're a business man, I'm sure you understand. Here, a show of good faith. Give me time!%SPEECH_OFF%The man practically shoves the pouch into your hands before dashing off. %randombrother% looks at you and shrugs.}"
			};
		}
	}
});