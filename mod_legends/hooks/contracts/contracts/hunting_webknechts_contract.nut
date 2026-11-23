::mods_hookExactClass("contracts/contracts/hunting_webknechts_contract", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Name = "Scuttling Horrors";
		this.m.DescriptionTemplates = [
			"Townsfolk are reporting a swarm of skittering monstrosities is nearby, taking children and dogs and the like.",
			"Spiders. Fark, you hate Spiders.",
			"The forest is alive with danger, as horrifyingly large spiders weave deadly traps among the trees.",
			"Venturing into the forest means facing the silent menace of web spiders, whose intricate webs ensnare the unwary.",
			"Life in the village is currently overshadowed by the spider threat, as the arachnids weave their deadly webs among the houses and fields.",
			"In the quiet of night, spiders descend upon the village, spinning their deadly traps and creeping into homes.",
			"The village is besieged by monstrous spiders, their scuttling numbers apparently growing with each passing day.",
			"The forest is home to a new danger: webknechts, whose silky threads are stretching across the trees like a lethal net.",
		];
	}

	local createScreens = o.createScreens;
	o.createScreens = function () {
		createScreens();
		::Legends.Screens.hook(this, "Task", function (_screen) {
			_screen.Title = "Scuttling Horrors";
			_screen.Text = "[img]gfx/ui/events/event_43.png[/img]{%employer% waves you into %their_employer% room. You notice that there are pitchfork-armed men keeping vigilant watch by means of grimly staring out %their_employer% windows, though one of these fellows is clearly asleep against the wall. You ask the settlement\'s mayor what it is %they_employer% wants. %They_employer% gets to the point.%SPEECH_ON%Townsfolk in the hinterland are reporting monstrosities taking children and dogs and the like. Now I don\'t mean to give leeway to paranoia and superstition, but it sounds an awful lot like these reports are talking about spiders. Webknechts as my father would call \'em, and if it\'s true then it is likely they\'ve a nest in these parts and I need you to find and destroy it. Are you interested, sellsword?%SPEECH_OFF% | You find %employer% stretching a cobweb between two forks. %They_employer% turns one of the utensils and wraps the webbing around a twine. Sighing, %they_employer% finally looks at you.%SPEECH_ON%I\'ve little mind to bring sellswords to these parts, but I\'m at my wit\'s end here. Enormous spiders are afoot, stealing livestock, pets. One lady reported her infant taken from the crib, all there being a pit of webbing where it slept. I need these horrid creatures taken care of, their nest destroyed. With proper incentive, would you be interested?%SPEECH_OFF% | You come to %employer% and your shadow alone startles the %person_employer%. %They_employer% sits up straight at %their_employer% desk and nods.%SPEECH_ON%Ah, I got the fits. No mind to your being here, sellsword, though you\'re scary enough, but word around these parts is that large spiders are afoot. I\'ve reason to believe the stories, being that I\'d gone to a farmstead and seen the large webbings and the devoured livestock. I need a man privy to absolute violence, speaking to you here, and I need such a man to find the nest of monsters and put them to an end. Are you interested?%SPEECH_OFF%}";
		});
		::Legends.Screens.hook(this, "Banter", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_25.png[/img]{You stumble across a dead cow with its flesh sucked to its very bones, yet its hide does not carry any sign of being sundried. %randombrother% crouches and runs %their_randombrother% finger among a number of puncture wounds. %They_randombrother% nods.%SPEECH_ON%The work of a webknecht, no doubt to it. I\'d say they poisoned it and then fed upon its paralyzed body. And a fresh corpse means they\'re close...%SPEECH_OFF% | You find a webbed corpse leaning against a lone tree. You slash the filaments away. A child\'s body slips out and crumples to the ground. Its face is tight to the bone, a pallid skull with the eyeballs peeking from deep in the sockets. The tongue is equally receded and there\'s hardly a nose at all. %randombrother% spits and nods.%SPEECH_ON%Alright. We\'re close. Rather, they\'re close. If it\'s solace to you folks, the boy died prior to this here state of being. Webknechts bring poison with their puncturing and no kid would stand to survive it long.%SPEECH_OFF%Well that\'s good. Time for the men to find these monsters. | You find a lad hiding beneath an upturned wheelbarrow. He refuses to come out, his tiny head staring out from the shelter like a pearl from a clamshell. You ask what he\'s doing. He frantically explains that he\'s hiding from the spiders and that you should go.%SPEECH_ON%Getcher own barrow. This here\'s mine.%SPEECH_OFF% Brandishing your sword, you tell him that it\'s the spiders you\'re looking for. The boy stares at you. He nods.%SPEECH_ON%That\'s a right goddam bad idea, sir. And no, I ain\'t a clue where\'d they gone to. I was here with a caravan and do you see a caravan? No that\'s right you damn don\'t cause they all spider salad now, so git before they see you speaking to me!%SPEECH_OFF%The barrow clatters closed. You\'ve no mind to lift it back up, though you do give it a good kick as you depart.}";
		});
		::Legends.Screens.hook(this, "OldArmor", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_123.png[/img]{With the webknechts dispatched you have the company briefly search the creatures\' nest, though the mercenaries are ordered to never wander alone. You muck about as well, %randombrother% at your side. Together, you spot a tree that\'s remarkably untouched by the webs. As you circle around, you find a knight\'s corpse leaning against its trunk. His hand rests atop a broken sword\'s pommel, the other hand is missing altogether, nothing but sleeve at the wrist with the mutilated arm couched at his belly. The corpse rests in a nest of its own making, a thicket of what look like spoiled rhubarb stalks and decayed carapaces, the broken bodies caverned and smelling of poison. %randombrother% nods.%SPEECH_ON%That\'s a right shame. I\'d wager he would have made a sound addition to the %companyname%, whoever he was.%SPEECH_OFF%Indeed, it has all the look of a great fighter\'s end. You\'ve mind to bury him, but you\'ve no time. You tell %randombrother% to fetch what %they_randombrother% can from the corpse and to ready a return to %employer%.}";
			_screen.start <- function () {
				local item = this.Const.World.Common.pickArmor([
					[1, ::Legends.Armor.Standard.decayed_reinforced_mail_hauberk],
					[1, ::Legends.Armor.Standard.decayed_coat_of_scales],
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					imageOverlayPath = item.getIconOverlay(),
					text = "You gain a " + item.makeName()
				});
			}
		});
		::Legends.Screens.hook(this, "Survivor", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_123.png[/img]{The battle over, you find a %person_dude% dangling by webbing attached to %their_dude% feet. Half of %their_dude% body is bound in the filaments and more dangle from %their_dude% hip like a shredded dress. Seems the spiders deserted %them_dude% upon the %companyname%\'s arrival. %They_dude% smiles at the sight of you.%SPEECH_ON%Hey there. Mercenaries ain\'t ya? Yeah I see it. You\'ve no mind being here lest it was coin that brought ya, and you fought like bastards that\'d been bet on. Absolute savages.%SPEECH_OFF%You ask the %person_dude% what you\'ll get for cutting %them_dude% down. %They_dude% turns %their_dude% head up, %their_dude% whole body then starting to swing about and at times twist %them_dude% away from you entirely. %They_dude% speaks, either to you or to whichever direction %they're_dude% facing.%SPEECH_ON%Aye, good question! Well, you may not see it here and now, but I\'m a sellsword m\'self, and wouldn\'t you know that my company and its captain all been done stringed up and consumed whole by them spiders! Cut me down and I\'ve nowhere else better to go than your company. That is, if you\'d have me.%SPEECH_OFF%You have the %person_dude% cut free and debate what to do before returning to %employer%.}";
			_screen.start = function () {
				this.Contract.m.Dude = ::World.getTemporaryRoster().create("scripts/entity/tactical/player");
				this.Contract.m.Dude.setStartValuesEx(["retired_soldier_background"]);

				if (!this.Contract.m.Dude.getSkills().hasTrait(::Legends.Trait.FearBeasts)	&& !this.Contract.m.Dude.getSkills().hasTrait(::Legends.Trait.HateBeasts)) {
					::Legends.Traits.remove(this.Contract.m.Dude, ::Legends.Trait.Fearless);
					::Legends.Traits.grant(this.Contract.m.Dude, ::Legends.Trait.FearBeasts);
				}

				this.Contract.m.Dude.getBackground().m.RawDescription = "You found %name% dangling from a tree, the sellsword the last survivor of a mercenary band sent to kill webknechts. %They% joined the company after you rescued %them%.";
				this.Contract.m.Dude.getBackground().buildDescription(true);
				this.Contract.m.Dude.worsenMood(0.5, "Lost %their% previous company to webknechts");
				this.Contract.m.Dude.worsenMood(0.5, "Almost consumed alive by webknechts");

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null) {
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
				}

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null) {
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
				}

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null) {
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).setArmor(this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).getArmor() * 0.33);
				}

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body) != null) {
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body).setArmor(this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body).getArmor() * 0.33);
				}

				this.Characters.push(this.Contract.m.Dude.getImagePath());
			}
		});
		::Legends.Screens.hook(this, "Success", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_85.png[/img]{%employer% meets you at the town entrance and there\'s a crowd of folks beside %them_employer%. %They_employer% welcomes you warmly, stating %they_employer% had a scout following you who saw the whole battle unfold. After %they_employer% hands you your reward, the townsfolk come forward one by one, many of them reluctant to stare a sellsword in the eyes, but they offer a few gifts as thanks for relieving them of the webknecht horrors. | You have to track down %employer%, ultimately finding the %person_employer% in a stable livery with a peasant girl. %They_employer% saws upward from the hay, startling the horses which whinny and stamp their feet. Half-dressed, the %person_employer% states %they_employer% already has your pay and forks it over. Eyeing you eyeing the girl, %they_employer% then starts to grab whatever\'s in reach, including from the saddlebags of stabled mounts, and hands them over.%SPEECH_ON%The, uh, townsfolk also sought to pitch in. You know, as thanks.%SPEECH_OFF%Right. For further \'thanks\' you ask if %they_employer%\'ll give you whatever\'s in a nearby satchel. | %employer% welcomes you back with a great clap and rub of %their_employer% hands, as though you\'d just brought in a turkey and not the horrifying evidence of your victory. After paying you the agreed reward, you hear some surprising news. The mayor states that the estate of a lost townsman could not be properly divvied up and, as further thanks, you\'re free to take what\'s left of it.}";
		});
	}
});
