::mods_hookExactClass("contracts/contracts/drive_away_bandits_contract", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Name = "Brigand Stronghold";
		this.m.DescriptionTemplates = [
			"A brigand stronghold is nearby, attracting all manner of thieves, vagrants and murderers.",
			"A delightful group of companions have set-up in a nearby ruin. They attack all who travel the road.",
			"Tensions are starting to rise as a nearby brigand stronghold grows in power.",
			"Every soul in a brigand stronghold knows the value of a sharp blade and a quick wit. Be wary.",
			"In a brigand stronghold, fear reigns supreme and trust is a rare commodity.",
			"Survival is harsh in a brigand gang, where every day brings new dangers. Today, that danger is you.",
			"Brigand raiders have been humiliating the region. You are being hired to eradicate them.",
			"\'Steal from the rich, give to the poor.\' An interesting idea for sure, until the rich inevitably hire a sellsword company to kill you.",
			"Obliterate the stronghold, earn your pay.",
			"Crush the stronghold, claim your bounty. What could go wrong?",
		];
	}

	local createStates = o.createStates;
	o.createStates = function () {
		createStates();
		foreach (s in this.m.States) {
			if (s.ID == "Running") {
				s.onDestinationAttacked = function (_dest, _isPlayerAttacking = true) {
					if (this.Flags.get("IsRobberBaronPresent")) {
						if (!this.Flags.get("IsAttackDialogTriggered")) {
							this.Flags.set("IsAttackDialogTriggered", true);
							this.Contract.setScreen("AttackRobberBaron");
							this.World.Contracts.showActiveContract();
						} else if (!this.Flags.get("IsRobberBaronDead")) {
							local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
							properties.Music = this.Const.Music.BanditTracks;
							properties.Entities.push({
								ID = this.Const.EntityType.BanditLeader,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/enemies/bandit_leader",
								Faction = _dest.getFaction(),
								Callback = this.onRobberBaronPlaced.bindenv(this)
							});
							properties.EnemyBanners.push(this.Contract.m.Destination.getBanner());
							this.World.Contracts.startScriptedCombat(properties, true, true, true);
						}
					} else {
						this.World.Contracts.showCombatDialog();
					}
				}
			}
		}
	}

	local createScreens = o.createScreens;
	o.createScreens = function () {
		createScreens();
		::Legends.Screens.hook(this, "Task", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_20.png[/img]{%employer% angrily shakes %their_employer% head.%SPEECH_ON%Brigands have been tearing up these parts for far too long! I sent a lad, %randomname%\'s son, to go find them. And you know what? Only %their_employer% head came back. Of course, the idiot brigands sent one of their own to deliver it. We captured and interrogated him... so now we know where they\'re at.%SPEECH_OFF%The %person_employer% leans back, pedaling %their_employer% thumbs over one another in thought.%SPEECH_ON%I do not have the men, but I do have the crowns - what say I slip some your way, and you slip a sword theirs?%SPEECH_OFF% | %employer% pours %themselves_employer% a drink, stares at the cup, and pours %themselves_employer% some more. %They_employer% seems to drain it in one gulp before belching %their_employer% news.%SPEECH_ON%Brigands killed %randomname% and his whole family. Can you believe that? I know you don\'t know who they are, but they were a well-liked family in these parts. I\'m sure you can already imagine, but I want these brigands done with. I spent half my men just finding their camp, now I\'m ready to spend ha... some of my crowns for you to go kill them. Are you interested?%SPEECH_OFF% | %employer% is looking out a window, dancing a finger along the rim of a drink as %they_employer% weighs %their_employer% thoughts.%SPEECH_ON%Brigands have been taking off with precious livestock. They come in the night, the brigands I mean, and cut the bells to make off all quiet like. I\'m sure livestock aren\'t important to you, but one calf, one cow, one bull? That\'s a fortune to some people around these parts.\n\nSo the other day I have a lad follow the animal tracks out of town and now he\'s told me exactly where those brigands are. As I\'m sure you could guess, I don\'t have the men to spare to take these vagabonds on, but crowns... crowns I am not short on. If I were to cross your palms with copper, would you be willing to cross these brigands with steel?%SPEECH_OFF% | %employer% sighs as if %they're_employer% tired of all these troubles, as though %they're_employer% about to start a conversation %they're_employer% already had many times before.%SPEECH_ON%%randomname%, a man of some import here, states that brigands made a pass on his daughters. Now he\'s worried what they\'ll do the next time. Luckily, that man is of some wealth and could easily track these brigands down. If I were to pay you a decent sum, how earnestly could you drive one of them swords of yours through a brigand or two?%SPEECH_OFF% | %employer% takes a seat in a chair big enough to be comfortable for two. %They_employer% bandies a mug back and forth.%SPEECH_ON%Brigands have been harrying us for weeks now and just yesterday they tried to set fire to a pub. Can you believe that? Who sets fire to such a thing? Luckily we put it out just in time, but things are getting bad around here. If they threaten our precious drink, what will they do next? Luckily, we managed to find where these vagrants are hiding. So... yes I see your look. It\'s a simple task, sellsword: we want you to go kill every last brigand there. Are you willing to work with us?%SPEECH_OFF% | As you settle into the room, %employer% finishes a goblet of cobra wine and heaves the cup out a window. You hear the din of it clattering hollow far, far away. %They_employer% turns to you.%SPEECH_ON%While walking the roads, brigands swarmed my wagon and made off with all my goods! They left me my life, which is fine, but the gall of what they did keeps me up at night. I see their sneering faces... hear their laughter... I believe it was a message, to go after me, because I refused to pay their \'tolls\'. Well, now I am ready to pay a toll - to you, sellsword. If you go and slaughter these vagabonds, I\'ll pay a tidy toll indeed. What say you?%SPEECH_OFF% | As you begin to take a seat, %employer% throws a scroll at you. It unfurls just as you catch it. You begin to read, but %employer% starts in with the news anyway.%SPEECH_ON%Traders from %randomtown% have all agreed to no longer patronize %townname% until our little brigand problem is done away with. The history of it is pretty simple, as I\'m sure you\'re aware of the brigands\' methods, but these damn vagabonds have been harrying the roads, pillaging caravans and killing merchants.\n\nI know exactly where they are, I just need a man of guts and in need of glory - or gold! - to go and kill them. So what say you, mercenary? Name a price and we can talk.%SPEECH_OFF% | %employer% is shaking when you greet %them_employer%. %They're_employer% practically frothing with anger - or maybe %they're_employer% just really drunk.%SPEECH_ON%Citizens of this fine town are starving. Why? Because brigands keep sneaking in during the night to raid the granaries! And if we catch them, they burn the buildings down! Now we can\'t defend ourselves by sitting back... Now... I want to defend myself by killing them all.%SPEECH_OFF%The man teeters for a moment, as if about to spill %themselves_employer% across %their_employer% desk. %They_employer% steadies before continuing.%SPEECH_ON%I want you to go kill these vagrants, obviously. All you have to do is be interested and... -hic-... name your price.%SPEECH_OFF% | %employer% looks solemnly at the ground. %They_employer% unfurls a scroll, showing you a face.%SPEECH_ON%This is %randomname%, a brigand at large who we captured the other day. He once lead an outfit of vagrants that used to harry and raid our town day and night. Problem is, he\'s not really the head of a snake, but one head of a hydra. Kill one criminal head, another takes its place. So what\'s the answer? Why, kill them ALL of course. And that\'s exactly what I want you to do, sellsword. Are you interested?%SPEECH_OFF% | %employer% turns to you as you look for somewhere to sit.%SPEECH_ON%Hoy, mercenary, how long has it been since you\'ve slaked your sword with the blood of evil, cruel men?%SPEECH_OFF%%They_employer% drops the sarcasm and you figure you\'ll be standing now.%SPEECH_ON%We here at %townname% are having a bit of a tiff with some local brigands. Local to us, that is, with their little rat\'s hole not far from here. Obviously, I think the answer to this issue is to hire some finely armed men such as your little company of goodfellas. So, does that pique your interest, mercenary, or do I need to find sturdier men for this task?%SPEECH_OFF%}";
		});
		::Legends.Screens.hook(this, "Survivors1", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_22.png[/img]{With the battle drawing to a close, a few enemies drop to their knees and beg for mercy. %randombrother% looks to you for what to do next. | After the battle, your men round-up what brigands remain. The survivors beg for their lives. One looks more like a kid than a man, but he is the quietest of them all. | Realizing their defeat, the few last standing brigands drop their weapons and ask for mercy. You now wonder what they would do were the shoe on the other foot. | The battle\'s over, but decisions are still yet to be made: a few brigands survived the battle. %randombrother% stands over one, %their_randombrother% sword to the prisoner\'s neck, and %they_randombrother% asks you what you wish to do.}";
		});
		::Legends.Screens.hook(this, "Survivors2", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_22.png[/img]{Altruism is for the naive. You have the prisoners slaughtered. | You recall how many times brigands slew hapless merchants. The thought is barely out of your mind when you give the order to have the prisoners executed. They pipe up a brief protest, but it is cut short by swords and spears. | You turn away.%SPEECH_ON%Through their necks. Make it quick.%SPEECH_OFF%The mercenaries follow the order and you soon here the gargling of dying men. It is not quick at all. | You shake your head \'no\'. The prisoners cry out, but the men are already upon them, hacking and slashing and stabbing. The lucky ones are decapitated before they can even realize the immediacy of their own demise. Those with some fight in them suffer to the very end. | Mercy requires time. Time to look over your shoulder. Time to wonder if it was the right decision. You\'ve no time. You\'ve no mercy. The prisoners are executed and that takes little time at all.} \n\n [img]gfx/ui/icons/asset_moral_reputation.png[/img] The company\'s Moral reputation decreases slightly";
		});
		::Legends.Screens.hook(this, "Survivors3", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_22.png[/img]{There\'s been enough killing and dying today. You let the prisoners go, taking their arms and armor before sending them off. | Clemency for thieves and brigands doesn\'t come often, so when you let the prisoners go they practically kiss your feet as though they were attached to a god. | You think for a time, then nod.%SPEECH_ON%Mercy it is. Take their equipment and cut them loose.%SPEECH_OFF%The prisoners are let go, leaving behind what arms and armor they had with them. | You have the brigands strip to their skivvies - if they even have them - then let the men go. %randombrother% rummages through what equipment is left behind as you watch a group of half-naked men hurry away.} \n\n [img]gfx/ui/icons/asset_moral_reputation.png[/img] The company\'s Moral reputation increases slightly";
		});
		::Legends.Screens.hook(this, "Volunteer1", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_22.png[/img]{Just as the battle ends and things begin to quiet, you hear a %person_dude% shouting. You move toward the noise to find a prisoner of the brigands. %They're_dude% got ropes over %their_dude% mouth and hands which you quickly undo. As he catches %their_dude% breath, %they_dude% meekly asks if maybe %they_dude% could join your outfit. | You find a prisoner tied up in the brigands\' camp. Freeing %them_dude%, %they_dude% explains that %they_dude% is from %randomtown%, and was kidnapped by the vagabonds just a few days ago. %They_dude% asks if maybe %they_dude% could join your band of mercenaries. | Rummaging what\'s left of the brigands\' camp, you discover a prisoner of theirs. Freeing %them_dude%, the %person_dude% sits up and explains that the brigands kidnapped %them_dude% as %they_dude% was traveling to %randomtown% in seek of work. You wonder if maybe %they_dude% could work for you instead... | A %person_dude% is left behind after the battle. %They're_dude% not a brigand, but in fact a prisoner of theirs. When you ask who %they_dude% is, %they_dude% mentions that %they_dude% is from %randomtown% and that %they're_dude% looking for work. You ask if %they_dude% can wield a sword. %They_dude% nods.}";
		});
		::Legends.Screens.hook(this, "Volunteer2", function (_screen) {
			_screen.start = function () {
				this.Characters.push(this.Contract.m.Dude.getImagePath());
				this.World.getPlayerRoster().add(this.Contract.m.Dude);
				this.Contract.m.Dude.onHired();
			}
			_screen.Options[0].getResult = function () {
				this.World.getTemporaryRoster().clear();
				this.Contract.m.Dude = null;
				return 0;
			}
			_screen.Text = "[img]gfx/ui/events/event_22.png[/img]{The %person_dude% joins your ranks, immersing %themselves_dude% in a crowd of brothers who seem to take to %them_dude% warmly enough for a group of paid killers. The newly hired states %they're_dude% good with all weapons, but you figure you\'ll be the one to decide what %they're_dude% best with. | The prisoner grins from ear to ear as you wave %them_dude% in. A few brothers ask what weapons they should give %them_dude%, but you shrug and figure you\'ll see to yourself what to arm the %person_dude% with.}";
		});
		::Legends.Screens.hook(this, "Volunteer3", function (_screen) {
			_screen.start = function () {
				this.Characters.push(this.Contract.m.Dude.getImagePath());
			}
			_screen.Options[0].getResult <- function () {
				this.World.getTemporaryRoster().clear();
				this.Contract.m.Dude = null;
				return 0;
			}
			_screen.Text = "[img]gfx/ui/events/event_22.png[/img]{You shake your head no. The %person_dude% frowns.%SPEECH_ON%Are you sure? I\'m pretty good with...%SPEECH_OFF%You cut %them_dude% off.%SPEECH_ON%I\'m sure. Now enjoy your newfound freedom, stranger.%SPEECH_OFF% | You appraise the %person_dude% and figure %they're_dude% not fit for the life of a sellsword.%SPEECH_ON%We appreciate the offer, stranger, but the mercenary life is a dangerous one. Go home to your family, your work, your home.%SPEECH_OFF% | You\'ve enough men to see you through, although you find yourself tempted to replace %randombrother% just to see the %person_randombrother%\'s reaction to a demotion. Instead, you offer the prisoner a handshake and send %them_dude% on %their_dude% way. Although disappointed, %they_dude% does thank you for freeing %them_dude%.}";
		});
		::Legends.Screens.hook(this, "Success1", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_04.png[/img]{You return to %townname% and talk to %employer%. The details of your journey are simple: you killed the brigands. %They_employer% nods, smiling tersely before handing over your payment as agreed upon.%SPEECH_ON%Good work, men. Those brigands were giving us plenty of trouble.%SPEECH_OFF% | %employer% opens the door for you as you get to %their_employer% home. %They're_employer% got a satchel in hand and holds it up.%SPEECH_ON%I take it by your return that the brigands are dead?%SPEECH_OFF%You nod. The %person_employer% heaves the satchel your way. You tell %them_employer% you could be lying. %employer% shrugs.%SPEECH_ON%Could be, but word travels fast for those who bite the hands that feed. Good work, sellsword. Unless you\'re lying of course, then I\'ll come find you.%SPEECH_OFF% | %employer% grins as you enter %their_employer% room and lay a sacked head on %their_employer% desk.%SPEECH_ON%You need not stain my fineries to show you\'ve completed the task, sellsword. I\'ve already gotten news of your success - the birds in these lands do travel fast, don\'t they? Your payment is in the corner.%SPEECH_OFF% | As you finish your report, %employer% wipes %their_employer% forehead with a handkerchief.%SPEECH_ON%Really, they\'re all dead then? Boy... you have no idea how much you\'ve lifted off my shoulders, sellsword. No idea at all! Your crowns, as promised.%SPEECH_OFF%%They_employer% sets a satchel on %their_employer% desk and you quickly take it. All is there, as promised. | %employer% sips %their_employer% goblet and nods.%SPEECH_ON%You know, I don\'t take kindly to your sort, but you did a good job, mercenary. %randomname% reported to me, before you even got here, that all the brigands had been slain. It was some mighty fine work by the way he describes it. And, well...%SPEECH_OFF%%They_employer% heaves a satchel onto the desk.%SPEECH_ON%Here\'s some mighty fine pay, as promised.%SPEECH_OFF% | %employer% leans back in %their_employer% chair, folding %their_employer% hands over %their_employer% lap.%SPEECH_ON%Sellswords don\'t sit right with many folks, I suppose on the account of y\'all killing and destroying whole villages on a shortchanged whim, but I\'ll admit you\'ve done good.%SPEECH_OFF%%They_employer% nods to a corner of the room where a wooden chest lays unopened.%SPEECH_ON%It\'s all there, but I won\'t be offended if you need to count it.%SPEECH_OFF%You do count it, and it is indeed all there. | %employer%\'s desk is blanketed in dirtied and unfurled scrolls. %They_employer%\'s smiling warmly over them as if %they're_employer% crooning over a pile of treasure.%SPEECH_ON%Trade deals! Trade deals everywhere! Happy farmers! Happy families! Everyone\'s happy! Ah, it\'s good to be me. And, of course, it\'s good to be you, sellsword, because your pockets just got a little bit heavier!%SPEECH_OFF%The %person_employer% tosses a small purse your way, then another and another.%SPEECH_ON%I would\'ve paid with a larger satchel, but I just like doing that.%SPEECH_OFF%%They_employer% cheekily tosses another purse which you casually catch with the sort of unamused aplomb of a man who still has fresh blood on his sword.}";
		});
		::Legends.Screens.hook(this, "Success2", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_04.png[/img]{You throw the criminal\'s head on %employer%\'s table. With a grin, you point at it.%SPEECH_ON%That\'s %robberbaron%.%SPEECH_OFF%%employer% stands up and unveils the burlap sack covering the trophy. %They_employer% nods.%SPEECH_ON%Aye, that\'s him alright. I guess you\'ll be getting extra for that.%SPEECH_OFF%You\'re paid a tidy sum of %reward% crowns for killing the brigands as well as destroying the leadership of many nearby syndicates. | %employer% leans back as you enter %their_employer% room, carrying a head by its hair. Luckily, it is not dripping.%SPEECH_ON%This here is %robberbaron%. Or should I say was?%SPEECH_OFF%Slowly standing, %employer% takes a cursory look.%SPEECH_ON%\'Was\' works... So, not only did you destroy the brigands\' rat hole, but you\'ve brought me the head of their leader. That is some mighty fine work, sellsword, and you\'ll be getting extra for this.%SPEECH_OFF%The %person_employer% forks over a satchel of %original_reward% crowns and then takes a purse off %their_employer% own self and pitches it toward you. | You hold %robberbaron%\'s head up, its sloped gaze turning to the ropes of bloodied hair. A slow smile etches across %employer%\'s face.%SPEECH_ON%You know what you\'ve done, sellsword? Do you know how much relief you\'ve brought to these parts just by removing that man\'s head from his shoulders? You\'ll be getting more than what you bargained for! %original_reward% crowns for the original task and...%SPEECH_OFF%The %person_employer% slides a chunky purse across %their_employer% table.%SPEECH_ON%A little something for that... extra weight you\'ve been carrying around.%SPEECH_OFF%}";
		});
	}

	o.onSerialize = function (_out) {
		//_out.writeI32(0);

		if (this.m.Destination != null && !this.m.Destination.isNull()) {
			_out.writeU32(this.m.Destination.getID());
		} else {
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	o.onDeserialize = function (_in) {
		//_in.readI32();
		local destination = _in.readU32();

		if (destination != 0) {
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}

		this.contract.onDeserialize(_in);
	}
});
