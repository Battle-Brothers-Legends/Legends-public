this.legend_camp_discover_location_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Location = null,
		LastHelpTime = 0.0
	},
	function create()
	{
		this.contract.create();
		this.m.DifficultyMult = this.Math.rand(75, 105) * 0.01;
		this.m.Type = "contract.legend_camp_discover_location";
		this.m.Name = "Camp Find Location";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		if (this.m.Home == null)
		{
			this.setHome(::World.Camp);
		}

		this.contract.start();
	}

	function setup()
	{
		local locations = clone this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
		locations.extend(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getSettlements());
		local lowestDistance = 9000;
		local best;
		local myTile = this.m.Home.getTile();

		foreach( b in locations )
		{
			if (b.isLocationType(this.Const.World.LocationType.Unique))
				continue;

			if (b.isDiscovered())
				continue;

			local region = this.World.State.getRegion(b.getTile().Region);

			if (!region.Center.IsDiscovered)
				continue;

			if (region.Discovered < 0.25)
				this.World.State.updateRegionDiscovery(region);

			if (region.Discovered < 0.25)
				continue;

			local d = myTile.getDistanceTo(b.getTile());

			if (d > 20)
				continue;

			if (d + this.Math.rand(0, 5) < lowestDistance)
			{
				lowestDistance = d;
				best = b;
			}
		}

		if (best == null)
		{
			this.m.IsValid = false;
			return;
		}

		this.m.Location = this.WeakTableRef(best);
		this.m.Flags.set("Region", this.World.State.getTileRegion(this.m.Location.getTile()).Name);
		this.m.Flags.set("Location", this.m.Location.getName());
		this.m.DifficultyMult = this.Math.rand(70, 85) * 0.01;
		this.m.Payment.Pool = this.Math.max(300, 100 + (this.World.Assets.isExplorationMode() ? 100 : 0) + lowestDistance * 15.0 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentLightMult());

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.m.Flags.set("Bribe", this.beautifyNumber(this.m.Payment.Pool * (this.Math.rand(110, 150) * 0.01)));
		this.m.Flags.set("HintBribe", this.beautifyNumber(this.m.Payment.Pool * 0.1));
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Find %location% %distance% to the %direction% and somewhere around the region of %region%"
				];

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance)
				{
					this.Contract.setScreen("Intro");
				}
				else
				{
					this.Contract.setScreen("Task");
				}
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = this.Math.rand(1, 100);

				if (r <= 15)
				{
					this.Flags.set("IsAnotherParty", true);
					this.Flags.set("IsShowingAnotherParty", true);
				}

				this.Contract.m.LastHelpTime = this.Time.getVirtualTimeF() + this.Math.rand(10, 40);
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Find %location% to the %direction% and around the region of %region%"
				];

				if (this.Contract.m.Location != null && !this.Contract.m.Location.isNull())
				{
					this.Contract.m.Location.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Flags.get("IsShowingAnotherParty"))
				{
					this.Flags.set("IsShowingAnotherParty", false);
					this.Contract.setScreen("AnotherParty1");
					this.World.Contracts.showActiveContract();
				}

				if (this.TempFlags.get("IsDialogTriggered"))
				{
					return;
				}

				if (this.Contract.m.Location.isDiscovered())
				{
					if (this.Flags.get("IsTrap"))
					{
						this.TempFlags.set("IsDialogTriggered", true);
						this.Contract.setScreen("Trap");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setScreen("FoundIt");
						this.World.Contracts.showActiveContract();
					}
				}
				else
				{
					local parties = this.World.getAllEntitiesAtPos(this.World.State.getPlayer().getPos(), 400.0);

					foreach( party in parties )
					{
						if (!party.isAlliedWithPlayer)
						{
							return;
						}
					}

					if (this.Time.getVirtualTimeF() >= this.Contract.m.LastHelpTime + 70.0)
					{
						this.Contract.m.LastHelpTime = this.Time.getVirtualTimeF() + this.Math.rand(0, 30);
						local r = this.Math.rand(1, 100);

						if (r <= 50)
						{
							this.Contract.setScreen("SurprisingHelpAltruists");
						}
						else
						{
							this.Contract.setScreen("SurprisingHelpOpportunists1");
						}

						this.World.Contracts.showActiveContract();
					}
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "DiscoverLocation")
				{
					this.Contract.setState("Return");
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "DiscoverLocation")
				{
					this.Contract.setState("Return");
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Return to " + this.Contract.m.Home.getName()
				];

				if (this.Contract.m.Location != null && !this.Contract.m.Location.isNull())
				{
					this.Contract.m.Location.getSprite("selection").Visible = false;
				}

				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					if (this.Flags.get("IsAnotherParty"))
					{
						this.Contract.setScreen("AnotherParty2");
					}
					else
					{
						this.Contract.setScreen("Success1");
					}

					this.World.Contracts.showActiveContract();
				}
			}

		});
	}

	function createScreens()
	{
		this.importScreens(this.Const.Contracts.NegotiationDefault);
		this.importScreens(this.Const.Contracts.Overview);
		this.m.Screens.push({
			ID = "Task",
			Title = "Negotiations",
			Text = "[img]gfx/ui/events/event_45.png[/img]{%employer% is looking at a poorly drawn map, then looks up at you as though you\'re the one responsible for making it.%SPEECH_ON%Look, mercenary, this is a strange thing to task you with, but you seem to have a good head on your shoulders. See this dark spot here? Would you be willing to venture that way and try and find the %location%? It\'s somewhere at or around the region of %region%.%SPEECH_OFF% | You step into %employer%\'s room and he shoves a map into your face.%SPEECH_ON%{Sellsword! Time for you to go exploring! See this uncharted spot, %direction% of here in the region of %region%? That\'s where I need you to go in search of the %location%. Do you accept or not? | Alright, this might seem strange, but I need a place by the name of the %location% located and charted. Our maps are incomplete in regards to this spot which, at the very least, I believe is at or near the region of %region% %direction% of here. Go, find it, and come back with the coordinates and you will be properly rewarded. | There are parts of this world man still has yet to find and chart into his maps. I\'m looking for %location% %direction% of here at or near the region of %region%. That\'s about all I know of it, but I do know it exists. So you go and find it for me and you\'ll be properly rewarded. | I need a place found, sellsword. It lies %direction% of here at or near to the region of %region%. The laymen call it %location%, but whatever it is, I need to know WHERE it is, understand? Find it and you will be paid handsomely. | I\'m in need of a soldier and explorer, sellsword, and I think you\'re just the man to be both in one. Now, before you accuse me of being cheap by not hiring both vocations, let\'s just say I have plenty of crowns for you to earn in doing this for me. What is it, hm? Well, I know of a place by the name of %location%, but I know not where it is other than it resides %direction% of here in the strip of land called %region%. Find it, draw its place on the map, and you\'ll get the pay of both a soldier and an explorer!}%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{What does it pay? | For the right price we\'ll find it.}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{Not interested. | Our travels will not take us there for a while. | This is not the kind of work we\'re looking for.}",
					function getResult()
					{
						this.World.Contracts.removeContract(this.Contract);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "FoundIt",
			Title = "At %location%",
			Text = "[img]gfx/ui/events/event_57.png[/img]{You sight %location% in the glass of your scope and mark it on your maps. Easy enough. Time to return to %employer%. | Well, it\'s already time to return to %employer% as %location% was easier to find than you figured. Marking it on your map, you pause and chuckle and shake your head. What luck. | %location% comes into view and it\'s immediately reborn upon your map to the best of your illustrative capabilities. %randombrother% asks if that\'s all there is to do. You nod. A rough go or an easy one, %employer% will be waiting to pay you all the same.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Time to head back.",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Trap",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_07.png[/img]The %location% has been spotted - and so has the %companyname%. The supposed \'altruist\' who had given you the directions is standing there, except now he has a band of hardy and unfriendly men with him.%SPEECH_ON%{Well, looks like you can follow directions after all. Setting an ambush is pretty easy when you tell the idiot where to meet ya. Anyway, kill them all! | Hey there, sellsword. Strange seeing you here. Oh wait, no it isn\'t. Kill them all! | Damn, took you long enough! What, you can\'t follow simple instructions on how to walk into your own graves? Foolish, sellsword, and annoyingly dumb. Well, let\'s get this over with. Kill them all.}%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "To Arms!",
					function getResult()
					{
						local tile = this.World.State.getPlayer().getTile();
						local p = this.Const.Tactical.CombatInfo.getClone();
						p.Music = this.Const.Music.BanditTracks;
						p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[tile.TacticalType];
						p.Tile = tile;
						p.CombatID = "DiscoverLocation";
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.BanditRaiders, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						this.World.Contracts.startScriptedCombat(p, false, false, false);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SurprisingHelpAltruists",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_76.png[/img]{Waving his hand rather friendly-like, a man approaches. You respond by unsheathing your sword halfway. He laughs.%SPEECH_ON%So many are interested in the %location%, so I can\'t fault you for being so defensive. Look, I\'ll tell you exactly where it\'s at. Just %distance% to the %direction% of here, %terrain%.%SPEECH_OFF%He heads off, cackling with laughter.%SPEECH_ON%I dunno if I\'ve done good or ill, and that\'s just the sort of fun I like!%SPEECH_OFF% | A group of world-weary explorers! They seize up in the middle of the road, half covered in mud and half in leaves and all in unintentional camouflage. One rubs his forehead, eyeing you carefully before a smile widens.%SPEECH_ON%Eh, I know a searcher when I see one. You\'re looking for the %location%, aintcha? Well yer in luck, we was just coming from there! Here, give me your map and I\'ll show you just where it is. You see, %terrain% %distance% to the %direction% of where we are now.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Much appreciated.",
					function getResult()
					{
						if (this.Math.rand(1, 100) <= 20 && this.Contract.getDifficultyMult() > 0.95)
						{
							this.Flags.set("IsTrap", true);
						}

						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SurprisingHelpOpportunists1",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_76.png[/img]{The stranger is a lone man who keeps his distance, one foot on the path, the other inching toward escape.%SPEECH_ON%Hey there.%SPEECH_OFF%He glances across your men, slowly smiling as though he can sense our being lost.%SPEECH_ON%Searching for the %location% are ya? Hmm, yeah. Well I\'ll tell you what, hand me %hint_bribe% crowns and I\'ll tell you exactly where it is! Come after me with yer swords and I\'ll be gone quicker than you can blink!%SPEECH_OFF% | You watch as the stranger comes into the light of the path, shielding his eyes so as to keep much of his face hidden.%SPEECH_ON%You look like the sort to be in search of something, but you know not where it be! The %location% is tricky like that. Good thing I know where it is. Good thing you, too, can know where it is by sliding %hint_bribe% crowns my way. I\'m the fastest sprinter you ever did see, so don\'t try and wring it out of me with one of them shiny swords you got.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Fine, here\'s the crowns. Now speak.",
					function getResult()
					{
						return "SurprisingHelpOpportunists2";
					}

				},
				{
					Text = "No need, we\'ll find it on our own.",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SurprisingHelpOpportunists2",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_76.png[/img]You accept the man\'s offer and he dishes out the details as promised.%SPEECH_ON%You see, it\'s there, of course, %terrain% %distance% to the %direction% of where we are now. Easy.%SPEECH_OFF%He whistles as he walks off, no doubt a very easy payday for him.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Got it.",
					function getResult()
					{
						this.World.Assets.addMoney(-this.Flags.get("HintBribe"));
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You lose [color=" + this.Const.UI.Color.NegativeEventValue + "]" + this.Flags.get("HintBribe") + "[/color] Crowns"
				});
			}

		});
		this.m.Screens.push({
			ID = "AnotherParty1",
			Title = "At %townname%",
			Text = "[img]gfx/ui/events/event_51.png[/img]{As you and the %companyname% prepare their journey, %randombrother% states that there is a man who wishes to speak to you directly. You nod and have him led to you. He\'s a glum, small man who states that the \'rulers\' of %townname% have no interest in the %location% other than ones of greed. Of course that\'s the case, so what\'s the problem? The man nods.%SPEECH_ON%Look, I\'ve some folks who are interested in keeping the %location% hidden away for good. If you find it, well, talk to me first. We\'ll make you a pretty penny.%SPEECH_OFF% | While the %companyname% readies its trip to find the %location%, a man sidles up next to you. He hands you a note and departs without saying a word. The scroll reads: LEAVE THE %locationC% WHERE IT BE. IF YOU FIND IT, TALK TO US. OUR CROWNS FOR YOUR SILENCE. THE RULERS OF %townnameC% NEED NOT KNOW NOTHIN\'! | A man approaches the company. Behind him you spy a couple of poor families staring on. You\'re not sure if he\'s their ambassador or not, but either way he comes right for you with a proposition spoken low and quiet.%SPEECH_ON%Listen here, sellsword. If you go out and find the %location%, come to us first. The rulers of %townname% need not bring their greed and lust for power to that place. Leave it to us, alright? We\'ll pay you well.%SPEECH_OFF%Before you can say a word, he straightens up and continues on. When you look back down the road those families are no longer around.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "I\'ll think about it.",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "AnotherParty2",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_51.png[/img]{As you head toward %townname%, a stranger comes out to the path. He\'s the man you talked to before, but this time he has a satchel in hand.%SPEECH_ON%{You\'ve no reason to tell the rulers of this town where the %location% is. Leave its secrets to us, you\'ve no idea what heirlooms and history we have there. For your silence, we\'re willing to give you this as payment, %bribe% crowns. Please, sir, accept. | Look, sellsword, I know you speak one language and that is the language of money. Take this satchel as a token of our appreciation - if you stay silent. You needn\'t tell the rulers of %townname% where the %location% is. That place belongs to our families. Those petty rulers will only ruin it with their greed and power-seeking. So, what say you, will you take this? There are %bribe% crowns in there. All you gotta do is take it and not talk.}%SPEECH_OFF% | Entering %townname%, you\'re headed off by a familiar face: the man who had greeted you just before you had departed in the first place. But this time he has a satchel with him.%SPEECH_ON%{%bribe% crowns for your silence. Tell the rulers of this town absolutely nothing and it\'s yours. They need not know about our deal, they just need not know where this place is. It\'s important to us, with history beyond measure, and all they\'ll do is raid and pillage it. Please, accept. | Take this, it\'s %bribe% crowns. That\'s how much we\'re prepared to give you for your silence. The rulers of %townname% will take your information and use it to pillage the %location%, because they know of our own familial relations to it and, well, we\'ve long since fallen out of favor around here. We\'ve little left so, please, let us keep our heirlooms and old home.}%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "I don\'t think so. Only our employer will learn where it is.",
					function getResult()
					{
						return "AnotherParty3";
					}

				},
				{
					Text = "We have a deal. You and no one else will learn where it is.",
					function getResult()
					{
						return "AnotherParty4";
					}

				},
				{
					Text = "Why get paid only once if we can get paid twice?",
					function getResult()
					{
						return "AnotherParty5";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "AnotherParty3",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_51.png[/img]{After telling the man no, he falls to his knees and cries out, much to the amusement of the %companyname%. He wails on about how you\'ve left the historic past of his family in the hands of lechers and usurers. You tell him that you don\'t care. | Telling the man that you\'ve no interest in betraying your original employer sets him off. He tries to attack you, launching forward to glom onto you with angry hands. %randombrother% pushes him away and threatens to kill him with a blade. The man backs off. He sits beside the path, head between his knees, sobbing. One of the men gives him a handkerchief as they pass by. | You tell the man no. He begs. You tell him no again. He begs some more. You suddenly realize you\'ve done with this with a woman or two. It really isn\'t a good look. You tell him as much, but the emotion of the moment is too much for him. He starts to wail, going on about how his family name will be ruined by the greedy bastards that run %townname%. You tell him that his supposed family name would be spared if, perhaps, he was the one running this town. This does not clear his tears.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Out of the way.",
					function getResult()
					{
						return "Success1";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "AnotherParty4",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_51.png[/img]{You agree to sell the man the details of your expedition. He\'s overly joyous about the whole affair, but %employer% is not. Apparently, a little child saw this exchange and reported your betrayal to the head of %townname%. Your reputation here has, no doubt, been a little hurt. | Well, on one hand you spared this man\'s supposed familial home from destruction at the hands of those who run %townname%. On the other, those who run %townname% quickly heard of what you\'d done. You should have paid more mind to a small town\'s population to double as rumormills extraordinaire.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Well, %employer% should have just payed us more.",
					function getResult()
					{
						this.World.Assets.addMoney(this.Flags.get("Bribe"));
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "Sold the location of " + this.Flags.get("Location") + " to another party");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Flags.get("Bribe") + "[/color] Crowns"
				});
			}

		});
		this.m.Screens.push({
			ID = "AnotherParty5",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_04.png[/img]You tell the man that you\'ll keep the location of his familial home a secret. While he celebrates, you go and tell %employer% where the %location% is. Getting paid by both sides makes for a pretty sweet gig. Catching hate from both not so much, but what did they expect in dealing with a sellsword?",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Those people will never learn.",
					function getResult()
					{
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.Assets.addMoney(this.Flags.get("Bribe"));
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail * 2);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail * 1.5, "Gave information to a competitor");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] Crowns"
				});
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Flags.get("Bribe") + "[/color] Crowns"
				});
			}

		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_20.png[/img]{%employer% welcomes you back. You hand over your recently illustrated map and he pores over it, swatting the spotted mark with the back of his hand.%SPEECH_ON%Of course that\'s where it is!%SPEECH_OFF%He smirks and pays you what you\'re owed. | You come to %employer%\'s room, a fresh map in hand. He takes it from you and looks it over.%SPEECH_ON%Well then. I\'d mind to think this was a spot too easy, but an agreement is an agreement.%SPEECH_OFF%He hands you a satchel weighed with precisely what is owed. | You report to %employer%, telling him of %location%\'s location. He nods and scribbles, copying the notes from your map. Curious, you ask how he knows you\'re not lying. The man sets down in a chair and leans back, clasping his hands over his belly.%SPEECH_ON%I invested in a tracker who kept close to your company. He made it here before you did and you\'ve but confirmed what I already know. Hope you don\'t mind the measures taken.%SPEECH_OFF%Nodding, you think it a wise move and take your pay and go.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Crowns well deserved.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Hired to find the " + this.Flags.get("Location"));
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] Crowns"
				});
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		local distance = this.m.Location != null && !this.m.Location.isNull() ? this.World.State.getPlayer().getTile().getDistanceTo(this.m.Location.getTile()) : 0;
		distance = this.Const.Strings.Distance[this.Math.min(this.Const.Strings.Distance.len() - 1, distance / 30.0 * (this.Const.Strings.Distance.len() - 1))];
		_vars.push([
			"region",
			this.m.Flags.get("Region")
		]);
		_vars.push([
			"location",
			this.m.Flags.get("Location")
		]);
		_vars.push([
			"locationC",
			this.m.Flags.get("Location").toupper()
		]);
		_vars.push([
			"townnameC",
			this.m.Home.getName().toupper()
		]);
		_vars.push([
			"direction",
			this.m.Location == null || this.m.Location.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Location.getTile())]
		]);
		_vars.push([
			"terrain",
			this.m.Location != null && !this.m.Location.isNull() ? this.Const.Strings.Terrain[this.m.Location.getTile().Type] : ""
		]);
		_vars.push([
			"distance",
			distance
		]);
		_vars.push([
			"bribe",
			this.m.Flags.get("Bribe")
		]);
		_vars.push([
			"hint_bribe",
			this.m.Flags.get("HintBribe")
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Location != null && !this.m.Location.isNull())
			{
				this.m.Location.getSprite("selection").Visible = false;
			}

			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (this.m.Location == null || this.m.Location.isNull() || !this.m.Location.isAlive() || this.m.Location.isDiscovered())
		{
			return false;
		}

		return true;
	}

	function onIsTileUsed( _tile )
	{
		if (this.m.Location != null && !this.m.Location.isNull() && _tile.ID == this.m.Location.getTile().ID)
		{
			return true;
		}

		return false;
	}

	function onSerialize( _out )
	{
		if (this.m.Location != null && !this.m.Location.isNull())
		{
			_out.writeU32(this.m.Location.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local location = _in.readU32();

		if (location != 0)
		{
			this.m.Location = this.WeakTableRef(this.World.getEntityByID(location));
		}

		this.contract.onDeserialize(_in);
	}

});

