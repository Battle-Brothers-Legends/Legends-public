::mods_hookExactClass("contracts/contracts/restore_location_contract", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.DescriptionTemplates = [
			"The townsfolk of %s are looking to rebuild the %s, ideally with some heartless sellswords to deal with any trouble.",
			"%s seeks to reclaim the %s. Mercenary assistance will be needed to secure the site.",
			"Help %s expel vagrants and thieves from the %s, so the area can be rebuilt.",
			"Rebuilding efforts in %s are ready to get underway, there is just the matter of site security to attend to first.",
			"%s wishes to rebuild the fire-gutted ruins of the %s. First the area must be made safe.",
			"Squatters, thieves and all kinds of miscreants love to lurk in ruins. Drive them out so %s can rebuild.",
			"With the danger now passed, it is time for %s to reclaim and rebuild the %s.",
			"The nobility of %s will not tolerate such unsightly ruins on the city outskirts. Help reclaim the %s.",
		];
	}

	// Ran when we actually add the contract
	o.formatDescription <- function () {
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);
		local count = 0, find = r.find("%");

		while (find != null) {
			find = r.find("%", find + 1);
			++count;
		}

		switch (count) {
			case 2:
				r = format(r, ::Const.UI.getColorized(this.m.Location.getSettlement().getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()), ::Const.UI.getColorized(this.m.Location.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));
				break;
			case 1:
				r = format(r, ::Const.UI.getColorized(::World.FactionManager.getFaction(this.getFaction()).getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));
				break;
		}

		this.m.Description = r;
	}

	local createStates = o.createStates;
	o.createStates = function () {
		createStates();
		foreach (s in this.m.States) {
			if (s.ID == "Escort") {
				local start = s.start;
				s.start <- function () {
					start();
					if (!this.World.State.isPaused()) {
						this.World.setSpeedMult(this.Const.World.SpeedSettings.EscortMult);
					}

					this.World.State.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.EscortMult;
				}
				s.update <- function () {
					if (this.Contract.m.Caravan == null
						|| this.Contract.m.Caravan.isNull()
						|| !this.Contract.m.Caravan.isAlive()
						|| this.Contract.m.Caravan.getTroops().len() == 0)
					{
						this.Contract.setScreen("Failure1");
						this.World.Contracts.showActiveContract();
						return;
					}

					if (!this.Contract.m.IsEscortUpdated) {
						this.World.State.setEscortedEntity(this.Contract.m.Caravan);
						this.Contract.m.IsEscortUpdated = true;
					}

					this.World.State.setCampingAllowed(false);
					this.World.State.getPlayer().setPos(this.Contract.m.Caravan.getPos());
					this.World.State.getPlayer().setVisible(false);
					this.World.Assets.setUseProvisions(false);
					this.World.getCamera().moveTo(this.World.State.getPlayer());

					// from vanilla
					// if (!this.World.State.isPaused())
					// {
					// 	this.World.setSpeedMult(this.Const.World.SpeedSettings.EscortMult);
					// }

					// this.World.State.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.EscortMult;

					if (this.Flags.get("IsFleeing")) {
						this.Contract.setScreen("Failure1");
						this.World.Contracts.showActiveContract();
						return;
					} else if (this.Contract.isPlayerAt(this.Contract.m.Location)) {
						this.Contract.setScreen("RebuildingLocation");
						this.World.Contracts.showActiveContract();
					}
				}
			}
		}
	}

	local createScreens = o.createScreens;
	o.createScreens = function () {
		createScreens();
		local event = this;
		::Legends.Screens.hook(this, "Task", function (_screen) {
			_screen.Title = event.m.Name;
			_screen.Text = "[img]gfx/ui/events/event_20.png[/img]{%employer% offers some bread and beer, and seems happy to avail himself. After some smalltalk on how you like %townname%, %they_employer% gets to the point.%SPEECH_ON%This region has been prosperous before, but many of our assets have been pillaged, burned or taken over by brigands. We need you to go to the %location% outside of %townname% and clear it of any occupants so that we can safely send materials there and have our craftsmen rebuild what we once had.%SPEECH_OFF%%They_employer% leans over the table and looks firmly at you.%SPEECH_ON%Are you willing to assist us in this endeavor?%SPEECH_OFF% | %employer% takes a bite of an apple then tosses the rest to you. Catching it, you look at the %person_employer%, not entirely sure what to do with it. When %they_employer% says nothing, you take a bite and toss it back, thanking %them_employer%.%SPEECH_ON%No problem, sellsword. Today\'s a decent day, although, obviously, I need something from you. The %location% outside of %townname% is, I believe, host to a group of brigands. All I need you to do is go there and clear them out so that I can restore the place to its former, crimeless glory. Does that suit your... interests?%SPEECH_OFF% | %employer% sighs as %they_employer% drops a scroll from %their_employer% fingers as though its news weighted it so heavily.%SPEECH_ON%We\'re not getting enough crowns from %townname%, and I believe it\'s because brigands may have taken over the %location%. That\'s not entirely confirmed... I really should follow the news of my people better, but you know how it is.%SPEECH_OFF%You shrug.%SPEECH_ON%Anyway, I want you to go there, find the problem, and then report back to me for further instruction. Sounds simple enough, right?%SPEECH_OFF% | Leaning forward in %their_employer% chair, %employer% points to a map %they're_employer% got sprawled out across %their_employer% desk.%SPEECH_ON%The %location% outside of %townname% has been destroyed by brigands. Now, sellsword, I need your services to take the territory back and help me restore it to its former glory or whatever it is I tell the peasants these days. Are you interested?%SPEECH_OFF% | %employer% sighs, %their_employer% breath leaving %them_employer% one way, and %their_employer% body sinking into %their_employer% chair the other.%SPEECH_ON%I used to visit the %location% when I was a kid. It was such a prosperous place, but now it lay in ruin thanks to some vagabonds. Obviously, I\'m not talking to you just to reminisce. I need you to go there and take it back! Kill those brigands and then report back to me immediately. Does this simple task interest you?%SPEECH_OFF% | %employer% kicks %their_employer% feet up on %their_employer% desk, knocking an empty goblet over.%SPEECH_ON%The peasants are at it again. Bugging me. They say the %location% outside of %townname% has been destroyed. I don\'t ordinarily take the fools at their word, but a few of my councilmen seem to have confirmed the news. So now I gotta do something about it.%SPEECH_OFF%%They_employer% swings a finger at you, smiling as %they_employer% does it.%SPEECH_ON%That\'s where you come in. Go to the %location%, kill those unruly vagabonds, then report back to me. How\'s that sound to you?%SPEECH_OFF%}";
		});
		::Legends.Screens.hook(this, "Empty", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_71.png[/img]{Arriving at the %location%, you have the men fan out and slowly creep into the area. You march in yourself, carefully weaving your way toward the buildings whose windows whistle as a spurting wind comes through. Investigating further, there doesn\'t appear to be anyone here. Not even evidence that they\'d just left, either. You gather your men and head back to inform %employer%. | %location% is surprisingly empty. You mosey about one of the homes, picking up dusted cups and flipping over straw beds, but find neither insect nor man. The place has been wholly abandoned. You head back to tell %employer% of the news. | A deerscare nods and tips at the edge of %location%, its wooden chiming the only thing around that seems to be alive. If anyone was living here, they left a long time ago. Buildings stand empty. Hollowed out. You can tell just by looking at them that no one is inside. The old gods themselves could destroy this place and not a single person would know or care. Sad. Best let %employer% know of the \'good\' news. | %location%\'s abandoned, just as you figured, but there is not a bandit or vagabond in sight. You can\'t blame them for not wanting the place: even though there\'s few buildings around, everything about them make you on edge. Old, frail... haunted? As though they were home to immeasurable crimes. Maybe %employer%\'s workers will tear them down and start anew. | Not a bandit is to be found at %location%. Half the buildings are destroyed while the other half stand empty and abandoned. A few of %employer%\'s workers could probably get this place into shape so you\'d best go inform %them_employer%. | You find a weathervane stuck in the mud and a cow carcass beside it. A pig pen is layered with fresh green grass. One of the buildings has been verdantly painted by a crawl of vines. The cemetery\'s markings are tilted and some flat on the ground. You find a shovel and a hole beside it. Water\'s filled the unused grave and there blue birds are bathing. You wonder if this place would be best left as is, but it\'s not your place to wonder. You head back to inform %employer% on the state of things. | You enter the %location% and have the men fan out and start searching the buildings. Not one to leave an investigation entirely to a bunch of sellswords, you enter a nearby home. The door peels open and almost immediately your foot kicks through a pile of pots and pans left on the earthen floor. Trudging in, you spot a few dead mice in the corner of the place, their skeletons still in a state of scurrying, and adjacent to them is a dead cat. There\'s a bird nest in the rafters. Yellowed eggs wink their shelled hoods, but you have yet to see much less hear a bird.\n\n%randombrother% comes in through the door and says nothing has been found. If brigands were here, they left long ago. You tell the mercenary to gather the men as it is time to report your findings to %employer%.}";
		});
		::Legends.Screens.hook(this, "Spiders", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_110.png[/img]{The white limply twisting in the wind from the abodes of %location% looks like smoke, but the buildings are untouched. As you near the dwellings, pairs upon pairs of red eyes flare in the dark of their windows. The webknechts scuttle forth, their spiny legs clattering on the slats of wood and scratching the corrugated rooftops, the mass of black bodies fluttering out the window frame like the flakes of a smoldered dandelion. | You find %location% deserted, but there\'s a silky white film frosting every corner of the place, tendrils of it twisting limply in the wind. %randombrother% touches a tip of one and it stretches back with %their_randombrother% arm and %they_randombrother% has to cut %themselves_randombrother% free. Looking back ahead, you see the webknechts rushing toward you, their spiny legs scissoring as they cross ground with frightening speed, their mandibles clattering with hunger.}";
		});
		::Legends.Screens.hook(this, "Refugees1", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_59.png[/img]{The %location% is full of people, alright, but they aren\'t brigands. Refugees clutter the place like moving trash looking for somewhere to rest. The disgusting men and women and even children walk meekly around the premise, altogether too weak to pay mind to the mercenary band before them. %randombrother% comes to your side and asks what should be done.\n\n If they are left to stay, %employer% won\'t be very happy and you\'ll probably not be seeing any pay. On the other hand... just look at the miserable lot. They deserve a rest from whatever troubles drove them here. | You take the spyglass from your eye and shake your head. The %location% is filled - or perhaps infested - with refugees. Better than brigands, you suppose, but still an issue. %employer% won\'t be very happy about them, you know that much. On the other hand, the people down there... ragged... looking more bone than flesh... tired... they don\'t deserve to be put out on the road again, do they? | %randombrother% turns and spits. %They're_randombrother% got %their_randombrother% fists to %their_randombrother% hips and shakes %their_randombrother% head.%SPEECH_ON%Goddammit.%SPEECH_OFF%Standing before you and the rest of the company is a motley group of refugees. Twenty, thirty maybe. Mostly men. You figure the rest of the group, the women and the children, are hiding in the hinterlands for now. The tired lot seems too exhausted to really communicate with you. They just exchange glances and the occasional, subservient shrug.\n\n A brother speaks to one side of you.%SPEECH_ON%We gotta kick them out if we want %employer%\'s money...%SPEECH_OFF%But then another brother pipes in from your other side...%SPEECH_ON%Yeah, but look at these people. Can we really send them back out into the world? Let \'em stay, I say.%SPEECH_OFF% | Refugees have taken to the %location%, presumably survivors from some wayward war. They\'ve scoured the area for resources and now seem rather entrenched. You know %employer% won\'t be happy about their presence - they don\'t seem particularly local. %randombrother% comes to your side and nods toward the ragged band of tired strangers.%SPEECH_ON%I could take a few men and drive them out, sir. It\'d be real easy.%SPEECH_OFF% | There\'s not a bandit in sight. Instead, you\'ve come to find a large group of refugees has occupied the %location%. A throng of tired souls has taken to the place quite well: they\'ve got a few stewpots cooking over crackling fires and seem rather happy about their new \'home.\' But %employer% will not be happy about their being there. Not at all. You don\'t want to believe it, but the cold truth here is that if you want to get paid these people have got to go.}";
		});
		::Legends.Screens.hook(this, "Refugees2", function (_screen) {
			_screen.Options[0].Text = "Get lost, you rabble! (Decrease Moral Reputation)";
		});
		::Legends.Screens.hook(this, "Refugees3", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_59.png[/img]{You leave the refugees where they are. Might as well not return to %employer% because %they_employer% won\'t be happy about this at all. | The men, women, and children look like they\'ve had enough of getting pushed around. You decide to leave them be. | These people have had enough of this world. You don\'t think they\'d survive another trip out into the wilds and decide to leave them where they\'ve settled. | The haggard and harried people don\'t deserve to be booted from this place. You figure to leave \'em be. They\'ll turn it into a workable area soon enough, although %employer% won\'t be happy not having %their_employer% own people in the area. | %employer% wants %their_employer% own people settled here, but you figure these folks got to it first. That, and they don\'t look like they could live any longer being put out into the wild.}";
			_screen.Options[0].Text = "We\'ll find work elsewhere... (Increase Moral Reputation)";
		});
		::Legends.Screens.hook(this, "Success1", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_98.png[/img]{%employer% glances at you as enter.%SPEECH_ON%So is it clear?%SPEECH_OFF%You nod. %employer% gets up and gives you instructions: you\'re to take a troop of builders back to the %location% so that they can rebuild it. | %employer% listens to your report and nods.%SPEECH_ON%I have a group of men going back to the %location% so that they can rebuild it. I need you to escort them. Got it? Good.%SPEECH_OFF% | Rolling up some scrolls, %employer% gives you your next instruction.%SPEECH_ON%I\'ve got a gang of men going back there to rebuild the place. A lot of crowns are involved here, so I need you to make sure those men get there in one piece. After that, come back and get your pay.%SPEECH_OFF% | %employer% sits back after listening to your report. %They're_employer% sipping a goblet of cobra wine.%SPEECH_ON%News?%SPEECH_OFF%You tell %them_employer% that the area has been cleared out. The %person_employer% swigs the rest of the drink in one go and sets the cup down.%SPEECH_ON%Good... good. Now take a gang of my workers back there to help rebuild. Once they are finished, come back for your payday.%SPEECH_OFF% | %employer% sits back as you enter.%SPEECH_ON%I take it by your return that the %location% has been cleared, yes?%SPEECH_OFF%You confirm what the %person_employer% wants to hear. %They_employer% seems happy, though your job is not yet finished: %employer% wants you to take a gang of workers back to the area to help rebuild and resettle it. Once they\'re there safe and sound, return to %them_employer% for payment.}";
		});
		::Legends.Screens.hook(this, "Success2", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_63.png[/img]{%employer% welcomes your return with a satchel heavy with crowns. %They_employer% waves you off, hardly even thanking you for your work. Although, screw %them_employer% and screw the formalities. A bag of crowns is thanks enough. | You enter %employer%\'s abode and %they_employer% waves you in. One of %their_employer% men hands you a large satchel of crowns. You look at the %person_employer%.%SPEECH_ON%How did you know they made it?%SPEECH_OFF%%employer% smiles sheepishly.%SPEECH_ON%I have many eyes and ears in these parts. Even the birds talk to me...%SPEECH_OFF%That explanation\'s good enough. | Returning to %employer%, you explain that the %location% is well underway to restoration. %They_employer% thanks you.%SPEECH_ON%Well, would you look at that? A mercenary who keeps %their_employer% word and gets %their_employer% work done. A rarity. Here is your pay.%SPEECH_OFF%One of %their_employer% men hands you a burlap sack heavy and sharpened by crowns. %employer% tips a hand.%SPEECH_ON%Be seeing you, sellsword.%SPEECH_OFF% | %employer% is in %their_employer% study when you return. %They_employer% shows a scroll to you and asks if you know what it is. You shrug.%SPEECH_ON%I\'m not a learned man. Not of the written word, anyway.%SPEECH_OFF%%employer% returns the shrug.%SPEECH_ON%What a shame. But you are a man of the spoken word. You\'ve owned up to your promises and, believe me, that is rare to see. Your pay is in the corner.%SPEECH_OFF%The pay is right where %they_employer% says it is. You spend little time dawdling on ceremony and take it and make your leave. | %employer% sits back, seemingly smug with %themselves_employer%.%SPEECH_ON%I know how to pick \'em. Sellswords, that is. Most of my compatriots hire folks like you, but it goes tits up because they don\'t know how to spot a good man from the wag of a dead dog\'s tail. But you... I knew you were good on your word the second I saw you. Your pay, mercenary...%SPEECH_OFF%%They_employer% slams a satchel of crowns on %their_employer% desk.%SPEECH_ON%It\'s all there, but I understand if you want to count it.%SPEECH_OFF%You do count it - and it\'s all there.}";
		});
	}
});
