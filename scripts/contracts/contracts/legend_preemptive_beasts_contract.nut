this.legend_preemptive_beasts_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		IsPlayerAttacking = true,
		Peddler = null,
		Poacher = null,
		ExpertHunter = null,
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.legend_preemptive_beasts";
		this.m.Name = "Taking Action";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DescriptionTemplates = [
			"Fell beasts have been spotted roaming the hills. The frightened locals are demanding action before attacks occur.",
			"Amidst the rolling hills, fell beasts lurk in the darkness, their eyes glowing like embers in the night.",
			"The hills are alive with the haunting cries of fell beasts, their sinister forms weaving through the moonlight.",
			"Fear grips the hearts of villagers as fell beasts are sighted circling ominously on the mist-covered hills.",
			"Track and exterminate the deadly beasts allegedly prowling the local hills and valleys.",
			"\'Big as an \'orse! Wit sharp teef! Five eyez! Sp\'licky as a jabber!\' - The peasant reports are nonsense, but something is clearly out there.",
		];
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 400 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Hunt down the beasts spotted near " + this.Contract.m.Home.getName()
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
				if (r <= 5 && this.World.Assets.getBusinessReputation() > 500)
				{
					this.Flags.set("IsHumans", true);
				}
				else
				{
					// Use our own settlement-based randomization system because the Vanilla approach was bugged and overly favoured Ghouls
					this.Flags.set(::RoamingBeastsContractWeights.rollEnemyBySettlement(this.Contract.getHome().get()), true);
				}
				this.Contract.spawnEnemies();
				this.Contract.m.Home.setLastSpawnTimeToNow();
				this.Contract.setScreen("Overview");
				this.Flags.set("Cut", this.Contract.beautifyNumber(this.Contract.m.Payment.getOnCompletion() * this.Math.rand(10, 25) * 0.01));
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onTargetAttacked.bindenv(this));
				}
			}

			function update()
			{
				if ( !this.Flags.get("IsPoachersDialogShown"))
				{
					this.Flags.set("IsPoachersDialogShown", true);
					this.Contract.setScreen("Poachers1");
					this.World.Contracts.showActiveContract();
				}

				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive())
				{
					if (this.Flags.get("IsHumans"))
					{
						this.Contract.setScreen("CollectingProof");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsGhouls"))
					{
						this.Contract.setScreen("CollectingGhouls");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsSpiders"))
					{
						this.Contract.setScreen("CollectingSpiders");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setScreen("CollectingPelts");
						this.World.Contracts.showActiveContract();
					}

					this.Contract.setState("Return");
				}
				else if (!this.Flags.get("IsTrackingBeastsShown") && this.Contract.m.Target.isHiddenToPlayer() && this.Math.rand(1, 3000) <= 1)
				{
					this.Flags.set("IsTrackingBeastsShown", true);
					this.Contract.setScreen("TrackingBeasts");
					this.World.Contracts.showActiveContract();
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (this.Flags.get("IsHumans") && !this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);
					local troops = this.Contract.m.Target.getTroops();

					foreach( t in troops )
					{
						t.ID = this.Const.EntityType.BanditRaider;
					}

					this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;
					this.Contract.setScreen("Humans");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
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
				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					if (this.Flags.has("NumPoachers"))
					{
						// check if the guests are still alive
						local survivors = 0;
						local poachers = [];
						for( local i = 0; i < this.Flags.get("NumPoachers"); i++ )
						{
							if(!::MSU.isNull(::Tactical.getEntityByID(this.Flags.get("Poacher" + i))))
							{
								survivors++;
							}
						}

						if (survivors == this.Flags.get("NumPoachers"))
						{
							this.Contract.setScreen("PoacherSurvival1");
						}
						else if (survivors > 0)
						{
							this.Contract.setScreen("PoacherSurvival2");
						}
						else
						{
							this.Contract.setScreen("PoacherSurvival3");
						}
					}
					else
					{
						// Go straight to success screen if we didn't hire the poachers
						if (this.Flags.get("IsHumans"))
						{
							this.Contract.setScreen("Success2");
						}
						else if (this.Flags.get("IsGhouls"))
						{
							this.Contract.setScreen("Success3");
						}
						else if (this.Flags.get("IsSpiders"))
						{
							this.Contract.setScreen("Success4");
						}
						else
						{
							this.Contract.setScreen("Success1");
						}
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
			Text = "[img]gfx/ui/events/event_43.png[/img]{%employer% greets you with a worried expression on %their_employer% face.%SPEECH_ON%I\'m glad you\'re here, sellsword. We\'ve been receiving reports of dangerous beasts appearing around the outskirts of our town.%SPEECH_OFF%You look around you, noticing the townsfolk going about their business completely oblivious to the precarious situation their lives are in.%SPEECH_ON%Thankfully, nothing terrible has happened... yet. With your help, we can make sure that it stays that way.%SPEECH_OFF% | %SPEECH_ON%Oi, sellsword! Come, quickly!%SPEECH_OFF%%employer% beckons to you, %their_employer% voice in hushed and hurried tones. You note the urgency in %their_employer% tone as you follow %them_employer% around an isolated corner. %They_employer% looks around agitatedly, as if to ensure you are alone. Preparing for the worst, you reach for your weapon - a move which immediately alarms %them_employer%.%SPEECH_ON%Stop! What are you doing?%SPEECH_OFF%You reply that you\'d ask the same of them.%SPEECH_ON%I needed to speak with you in private. Now put that thing away before one of us gets hurt!%SPEECH_OFF%You raise an eyebrow as you rest your hand on the hilt of your weapon, wondering almost out loud just who exactly would be hurt. %employer% barely notices.%SPEECH_ON%Dangerous beasts have been spotted outside of town. Most folks in this town are blissfully unaware of it so far, and I would like to keep it that way. I want you to hunt these beasts down before they cause any trouble.%SPEECH_OFF% | You are greeted by %employer%, who cuts to the chase.%SPEECH_ON%A few days ago, some children claimed they heard strange sounds while they were playing near the edge of town. I had my guards investigate, and they came back saying they found monstrous tracks in the vicinity.%SPEECH_OFF%You turn to look at the guards. One of them is lazily leaning into a makeshift polearm in a manner that makes you fear for the safety of their right eye. Another is staring in awe at %randombrother%, dreamily confessing their desire to become a hero like %them_randombrother% someday. You refocus your attention on %employer%.%SPEECH_ON%Frankly, I wouldn\'t trust even my dog\'s life to any of my guards. I want you to head out and kill these beasts before they cause any trouble for us, you hear?%SPEECH_OFF%Before %they_employer% could finish %their_employer% sentence, the guard who was resting against their polearm fell asleep standing, tipping over and stabbing the other guard who was fawning over %randombrother% in their left buttock. The %companyname% will never be left wanting for work in this town, it seems.}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{What\'s this worth to you? | What is %townname% prepared to pay? | Let\'s talk pay.}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{This doesn\'t sound like our kind of work. | I wish you luck, but we\'ll not be part of this.}",
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
			ID = "Humans",
			Title = "Before the attack...",
			Text = "[img]gfx/ui/events/event_07.png[/img]{These aren\'t beasts at all, but men in wolf\'s clothing! Having seen the \'true\' face of this evil, the men are quite relieved that your enemy is one they know all too well. | As you close in on the monsters, you realize that the foul creatures are not beasts at all, but humans in disguise! You know not why they played such a game of dress-up, but they\'re drawing weapons. As far as you\'re concerned, beast or man, they all die the same. | You stumble upon a man removing a wolf head off his shoulders. He glances at you, the disguise still in hand, then quickly puts it back on. You draw your sword.%SPEECH_ON%It\'s a little late to be playing pretend.%SPEECH_OFF%The slash of your weapon knocks the man\'s mask off and he stumbles backward. Before you can run him through, he takes off, sprinting toward a collection of similarly skulking fellow. They draw their weapons at the very sight of you. Whatever reason these idiots were playing dress up, it doesn\'t matter now. | You come across a dead beast with a few arrows stuck in its back. The damage does not seem lethal... and when you tip your sword across the creature\'s mane, the head tips right off, revealing a human beneath.%SPEECH_ON%Didja do that?%SPEECH_OFF%A voice breaks in from ahead. There stand a few men removing their disguises: that of the beasts you were after. The one in the lead raises his voice.%SPEECH_ON%Kill them! Kill them all!%SPEECH_OFF%Nope, these are still beasts, just of a softer sort.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Prepare the attack!",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "TrackingBeasts",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_126.png[/img]{%randombrother% calls out to the party, calling everyone to a halt.%SPEECH_ON%Tracks! I\'ve found some strange-looking tracks!%SPEECH_OFF%The %companyname% gather around %them_randombrother% and attempt to identify the tracks. | You come across some tracks around the outskirts of %townname%. Thankfully, it seems the beasts have not struck yet. You take a closer look and try to make out what the tracks are. | As you scan your surroundings for signs of the beasts, you notice some tracks not too far off. You approach the tracks to take a closer look.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{Be on your guard. It could be anything. | We\'ll find out what these beasts are soon enough. | Whatever these beasts are, they will meet their end soon.}",
					function getResult()
					{
						return 0;
					}
				}
			],
			function start()
			{
				if (this.Flags.has("NumPoachers"))
				{
					local poacher = null;
					for( local i = 0; i < this.Flags.get("NumPoachers"); i++ )
					{
						local p = ::Tactical.getEntityByID(this.Flags.get("Poacher" + i));
						if (!::MSU.isNull(p))
						{
							poacher = p;
							break;
						}
					}
					if (!::MSU.isNull(poacher))
					{
						this.Contract.m.Poacher = ::MSU.asWeakTableRef(poacher);
						this.Options.push({
							Text = "(Poacher) " + poacher.getName() + " can help us.",
							function getResult()
							{
								return "TrackingBeastsPoacher";
							}
						})
					}
				}

				local roster = ::World.getPlayerRoster().getAll();
				local candidates = [];
				foreach (c in roster)
				{
					if(c.getBackground().isBackgroundType(::Const.BackgroundType.ExpertHunter))
					{
						candidates.push(c);
					}
				}
				local expert = ::MSU.Array.rand(candidates);
				if (!::MSU.isNull(expert))
				{
					this.Contract.m.ExpertHunter = ::MSU.asWeakTableRef(expert);
					this.Options.push({
						Text = "(Expert Hunter) " + expert.getName() + " has something to say.",
						function getResult()
						{
							return "TrackingBeastsExpert";
						}
					});
				}
			}
		});
		this.m.Screens.push({
			ID = "TrackingBeastsPoacher",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_126.png[/img]{%poacher% steps forward and takes a quick glance at the tracks.%SPEECH_ON%Aye, these must surely be the %beasts% that I saw the other day. Looking at these tracks, they must have headed to the %direction% of here.%SPEECH_OFF% | You turn to find %poacher%, who coincidentally just returned from a brief scouting trip. %They_poacher% hunches over the tracks, a wave of recognition immediately washing over %their_poacher% face.%SPEECH_ON%%beasts%! These are definitely the ones I just spotted as well. I saw them to the %direction% of here. If we hurry, perhaps we can catch them before they cause any harm.%SPEECH_OFF% | %SPEECH_ON%It\'s %beasts%, I\'m sure of it.%SPEECH_OFF%Before you are able to take a closer look to confirm what %they_poacher% said, %poacher% is already walking off towards the %direction%. You quickly order the %companyname% to move out.}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "{Let\'s get moving then. | Be careful, %beasts% are dangerous. | We\'re not paid by the hour. Get moving! | These %beasts% are in for a nasty surprise.}",
					function getResult()
					{
						return 0;
					}
				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Poacher.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "TrackingBeastsExpert",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_126.png[/img]{%expert% springs forward, and before you can stop %them_expert%, %they_expert% is already on all fours examining the tracks.%SPEECH_ON%Hmmm...%SPEECH_OFF%Wait a minute, is %they_expert% licking a piece of dirt from the tracks?%SPEECH_ON%Ah, yes. These must be %beasts% indeed.%SPEECH_OFF%Before you are able to ask %them_expert% how %they_expert% knows, %they_expert% gets up and points to the %direction%.%SPEECH_ON%They went that way. If we hurry, we can catch them before they hurt anyone.%SPEECH_OFF% | %expert% taps you on the shoulder from behind.%SPEECH_ON%It\'s %beasts%, boss. I saw them while I was scouting ahead.%SPEECH_OFF%You are about to ask when did %they_expert% even leave in the first place, but %they_expert% interrupts you.%SPEECH_ON%There\'s no time to waste. We should head towards the %direction% immediately if we want to make sure they don\'t cause any trouble.%SPEECH_OFF% | %SPEECH_ON%Those are definitely the tracks of %beasts% if I have ever seen them.%SPEECH_OFF%%expert% saunters over to your side and appears to be measuring the tracks with a stick. %They_expert% sniffs the air uncomfortably loudly.%SPEECH_ON%We should head %direction%. They can\'t be far now.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Let\'s go. | Good job. | Keep your eyes peeled.}",
					function getResult()
					{
						return 0;
					}
				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.ExpertHunter.getImagePath());
				this.Contract.m.ExpertHunter.improveMood(::Const.MoodState.Eager - ::Math.minf(this.Contract.m.ExpertHunter.getMood(), ::Const.MoodState.Eager), "Experienced the thrill of the hunt");
				if (this.Contract.m.ExpertHunter.getMoodState() >= ::Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = ::Const.MoodStateIcon[this.Contract.m.ExpertHunter.getMoodState()],
						text = this.Contract.m.ExpertHunter.getName() + ::Const.MoodStateEvent[this.Contract.m.ExpertHunter.getMoodState()]
					});
				}
			}
		});


		this.m.Screens.push({
			ID = "CollectingPelts",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_56.png[/img]{The beasts slain, you order the men to take their pelts as evidence. Your employer, %employer%, should be most happy to see them. | Having killed the foul creatures, you begin skinning and scalping them. Gruesome creatures require gruesome evidence. Your employer, %employer%, might not believe your work here otherwise. | With the battle over, you have the men start collecting pelts to take back to %employer%, your employer. | Your employer, %employer%, might not believe what happened here without evidence. You order the men to begin taking pelts, trophies, scalps, whatever might show off your victory here.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Let\'s be done with this, we have crowns to collect.",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "CollectingProof",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_22.png[/img]{Your mercenaries take the fools\' disguises lest your employer, %employer%, not believe your doings here. | Your employer might not believe what was going on here. You order everyone to collect the disguises. %randombrother%, stripping a mask off one of the slain, starts to wonder.%SPEECH_ON%So they dressed themselves up as the sort of thing to attract us, and now they\'re all dead. I hope they didn\'t think it a game.%SPEECH_OFF%%randombrother2% cleans %their_randombrother2% blade in the folds of one of the disguises.%SPEECH_ON%Well, if it were a game, I sure enjoyed playing it.%SPEECH_OFF% | %randombrother% nods at the slain.%SPEECH_ON%It\'s mighty likely that %employer% wouldn\'t believe a group of brigands were dressing up as beasts.%SPEECH_OFF%Agreeing, you order everyone to begin collecting the masks and disguises as evidence. | You\'ll need evidence to show your employer, %employer%. These weren\'t the beasts you were looking for, but they do carry a lot of disguises that your employer would probably be most interested in seeing. One of your mercenaries wonders aloud.%SPEECH_ON%So what were they playing dress up for?%SPEECH_OFF%%randombrother2% folds some of the disguises over %their_randombrother2% arm as he goes about collecting them.%SPEECH_ON%Suicide by ceremony? Their dance and fun got our attention, after all.%SPEECH_OFF%%They_randombrother2% picks up one of the disguises only for the head of the dead to get slinged up with it. The sellsword laughs as %they_randombrother2% kicks the dead man\'s head out.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Back to %townname%!",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "CollectingGhouls",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_131.png[/img]{The fight over, you walk to a dead Nachzehrer and take a knee. Were it not for a gate of ill-shapen teeth, you could easily fit your head into the beast\'s oversized maw. Instead of admiring the dental failures at hand, you instead take out a knife and saw its head off, ripping through a very tough outer layer of skin before, surprisingly, easily cutting through the muscles and tendons. You raise the head up and order the %companyname% follow suit. %employer% will be expecting some proof, after all. | The Nachzehrers\'s dead body looks more rock than beast as it lays flat and unmoving. Flies are already coupling inside its mouth, sowing life on the frothy remains of death. You order %randombrother% to take its head, for %employer% will be expecting proof. | Dead Nachzehrers are scattered about. You take a knee beside one and look at its mouth. Whatever was in its lungs is still issuing forth, a wheeze burping out. Putting a cloth to your nose, you use the other hand to chop away at its neck with a blade, cutting off the head and holding it up. You order a few brothers to follow suit for %employer% will be expecting proof. | A dead Nachzehrer is an interesting specimen to behold. You can\'t help but wonder where it falls on the natural spectrum. Shaped like crude men, muscled like some beastly thing, and its head is gnarled with features born out of a wildman\'s nightmares. You order the %companyname% to start collecting the heads of the foul things for %employer% will surely be wanting proof.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Back to %townname%!",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "CollectingSpiders",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_123.png[/img]{You order your men to scour the field and collect as many parts as they can of the spiders. A few make the mistake of touching the hairs on the webknechts\' legs, leaving them scratching quickly forming rashes. | The spiders litter the field like they would the corner of an attic. In death, they look like giant gloves stiffly clasped together. You have the men wrench the legs apart to harvest evidence of the bestial remains. | The mercenaries scour the field, hacking and sawing at the spiders\' stiff remains to take back to %employer%. Even in death, the webknechts are ghastly, looking only a moment away from flinching back to life and wrapping themselves around the nearest breathing animal. Their horrifying features and surreal size does not stop some sellswords from dancing around, clicking their tongues and hissing, and all around preying upon the phobias of those less inclined to go near the damned things.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Back to %townname%!",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_04.png[/img]{You return to %employer% and lay one of the pelts clear across %their_employer% desk. Its limp claws rap against the side of the oak. The %person_employer% lifts one, then lets it fall again.%SPEECH_ON%I see you\'ve found those beasts we were looking for.%SPEECH_OFF%You tell %them_employer% of the battle. %They_employer% seems most pleased, taking a small wooden chest out from %their_employer% bookshelf and handing it over.%SPEECH_ON%%reward_completion% crowns, as agreed upon. The people of %townname% deserve the reprieve you have given them from such horrors.%SPEECH_OFF% | When you step in %employer%\'s room he recoils almost instantly.%SPEECH_ON%What in the hells of the gods is in your hand, sellsword?%SPEECH_OFF%You hold up the nape of a pelt. Black blood ropes out from the neck and splatters the floor.%SPEECH_ON%One of the beasts you were looking for. If you need evidence of the rest, I got those waiting outside...%SPEECH_OFF%The man holds his hand up, staying you.%SPEECH_ON%One is sufficient for my belief. Very good work, sellsword. Your pay will be with %randomname%, a councilman you probably passed in the halls. He\'s got the ugly mug on him and he\'ll be carrying the %reward_completion% crowns, as promised.%SPEECH_OFF%The man takes another look at the beast then slowly shakes his head.%SPEECH_ON%May the dead and their survivors find peace in the passing of those foul creatures.%SPEECH_OFF% | %employer% welcomes your return with a goblet of wine.%SPEECH_ON%Drink up, beast-slayer.%SPEECH_OFF%You\'re curious as to how he already knows of your success. He waves off your curiosity.%SPEECH_ON%I\'ve many eyes and ears in this land - not spies, of course, but the common folk has a big mouth. I should know, I am one! You did well on this one, sellsword, so have a sip. It\'s mighty fine wine.%SPEECH_OFF%It\'s alright. The reward of %reward_completion% crowns you walk out with is far better, though. %employer% stops you.%SPEECH_ON%Just so you know, mercenary, those beasts killed some good men and women out there. Those people might be scared of you, being the sellsword that you are, but they are eternally grateful all the same.%SPEECH_OFF%You weigh the crowns. Quite grateful, yes... | %employer% takes a few steps back.%SPEECH_ON%Ah, uh, I see you\'ve killed the beasts. That\'s a mighty fine pelt you got there.%SPEECH_OFF%You drop what you\'ve brought: a thick, heavy mane of beastly origin collapsing into a pile of fur and flesh. The man, almost too scared to get close, tosses you a satchel.%SPEECH_ON%%reward_completion% crowns, as agreed upon. I will go to the people and tell them of your success. Finally, we can be at peace.%SPEECH_OFF% | %employer%\'s sitting at his table, legs up over a corner. His eyes are staring at the ceiling, the corners of his face pinched with withered folds. He looks at you.%SPEECH_ON%Welcome back. I\'ve been getting word of your doings... of your battles with the monsters.%SPEECH_OFF%You nod, looking around for your reward. The man shows you the door.%SPEECH_ON%%randomname%, a fellow councilman of %townname%, has your payment outside. %reward_completion% crowns as agreed upon. And the people of %townname%, fear you though they may, are blessed all the same by your arrival here. Thank you, mercenary.%SPEECH_OFF% | %employer%\'s feeding one of his dogs when you return. The mutt drops its bone to sniff at what you\'ve brought. The man points at the pelt.%SPEECH_ON%What kind of foul thing is that?%SPEECH_OFF%You shrug and toss it onto his table. The dog pokes its nose at one of the claws, growls, then begins to lick it. %employer% smiles briefly, but then goes to his bookshelf, picking up a wooden chest and handing it to you.%SPEECH_ON%%reward_completion% crowns, was it? You should know that you\'ve brought peace to the people of %townname%.%SPEECH_OFF%You nod.%SPEECH_ON%Does their happiness also come in crowns?%SPEECH_OFF%%employer% frowns at your greedy humor.%SPEECH_ON%No, it does not. Have a good day, mercenary.%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "A successful hunt.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Rid the town of direwolves");
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
		this.m.Screens.push({
			ID = "Success2",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_04.png[/img]{%employer% welcomes your return.%SPEECH_ON%I\'ve already heard the, I suppose, splendid news. I can believe it, though. A bunch of brigands playing dress up. Wolves in... wolf clothing?%SPEECH_OFF%%They_employer% grins at you, expecting a laugh at his cheesy joke. You shrug. %They_employer% shrugs, too.%SPEECH_ON%Ah, well. Your payment, %reward_completion% crowns, is waiting for you outside. I will tell the people of %townname% that the monsters they fear are but men.%SPEECH_OFF% | You return with the costumes of the foolish brigands. %employer% tilts the disguises left to right.%SPEECH_ON%Interesting. They\'re very well done. I\'d almost say the brigands were clever here.%SPEECH_OFF%%They_employer% picks up one of the masks and looks just about ready to try it on, then pauses as though %they_employer% shouldn\'t do this with an audience. %They_employer% puts it back down and smiles at you.%SPEECH_ON%Well, anyway, sellsword... good work. You\'ll have %reward_completion% crowns waiting for you outside with one of %townname%\'s councilmen. %They_employer%\'ll be looking out for you. Now, the people of %townname% can bury our dead and finally be at peace.%SPEECH_OFF% | %employer% reels in laughter at your reveal.%SPEECH_ON%Men? It was only men?%SPEECH_OFF%You nod, but try and get the man back on track.%SPEECH_ON%They killed a lot of peasants and they were still a dangerous lot.%SPEECH_OFF%Your employer nods.%SPEECH_ON%Of course, of course! I didn\'t mean to belittle anything or anyone. Don\'t dare assume things of me, sellsword, those are my friends and neighbors dying out there! Anyway, you did what I asked of you and for that I am very grateful.%SPEECH_OFF%%They_employer% hands over a satchel of crowns. You count %reward_completion% inside before making your leave. The %person_employer% hollers out to you.%SPEECH_ON%Surely you understand trying to find humor in this horrible world, right? Because it is I who went to the funerals of all those slain. I will not go into the grave with a frown on my face, no matter how hard this damned place tries to force it on me.%SPEECH_OFF% | You show %employer% the evidence of the mischievous brigands. %They_employer% picks through the lumps of disguises, rubbing crusty blood off his fingers.%SPEECH_ON%That is the blood of men alright. Are you sure that they weren\'t just having fun playing pretend and the real monsters are still out there?%SPEECH_OFF%You purse your lips and explain that they attacked you with very not-pretend weapons. %employer% nods, seemingly understanding, though a little suspicious.%SPEECH_ON%Well, I suppose I could just wait and see if the monsters return. If they do, well, a man betrayed makes for a mighty fine monster in and of itself, wouldn\'t you agree?%SPEECH_OFF%You just tell the man to pay you and wait and see if he should be so untrusting. %They_employer% nods, giving you %reward_completion% crowns and seeing you off.%SPEECH_ON%I truly do hope you are telling the truth, mercenary. %townname% could use a reprieve from the horrors that is constantly lashing out from this damned world.%SPEECH_OFF% | %employer% runs a finger along the edge of a disguise.%SPEECH_ON%The fur is soft to the touch. Very real...%SPEECH_OFF%%They_employer% looks up at you.%SPEECH_ON%I have to wonder if they killed the original monsters, and then... decided to wear their pelts? Why, though? Do you think they were cursed?%SPEECH_OFF%You shrug and answer.%SPEECH_ON%All I can say is that they had the guise of monsters, and the cruelty of them as well. They attacked us and paid for it. Have any of your locals spotted any creatures in awhile?%SPEECH_OFF%The man brings out a satchel of %reward_completion% crowns and slides it over to you.%SPEECH_ON%No, they haven\'t. In fact, they\'re starting to venture out again. I don\'t mean down the roads, but leaving the safety of their front doors is a big step for many! You\'ve definitely brought us peace, sellsword, and for that we thank you.%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Beast, men... what matters is the crowns.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Rid the town of brigands masquerading as direwolves");
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
		this.m.Screens.push({
			ID = "Success3",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_04.png[/img]{You find %employer% resting on %their_employer% laurels. %They_employer% stands and pulls %their_employer% pants up, a servant quickly retrieving a bucket from whence %they_employer% was sitting. The poor servant quickly rushes out of the room. %employer% points at the Nachzehrer head dangling from your hand.%SPEECH_ON%That is absolutely disgusting. %randomname%, give the %companyname% their pay. %reward% crowns, was it?%SPEECH_OFF% | You place the Nachzehrer head onto %employer%\'s desk. For some reason, fluids still issue from its neck, dribbling down the side of the oak and no doubt staining it. The %person_employer% leans back, tenting %their_employer% fingers on %their_employer% belly.%SPEECH_ON%Nachzehrers? And what else, ghosts?%SPEECH_OFF%The %person_employer% snickers to %themselves_employer%.%SPEECH_ON%Nothing is too difficult for you, sellsword.%SPEECH_OFF%%They_employer% snaps %their_employer% fingers and a servant comes up, handing you a satchel of %reward% crowns. | Between the battle and walking to %employer%\'s place, the maw of the Nachzehrer became filled with flies, its tongue replaced by a formless, throbbing black ball that\'s more buzz than bite. %employer% takes one look at it and puts a cloth to %their_employer% mouth.%SPEECH_ON%Yes, I get it, take it away, please.%SPEECH_OFF%%They_employer% waves one of %their_employer% guards over and you are handed a satchel of %reward% crowns. | A steely eyed %employer% leans forward to get a good look at the Nachzehrer head you\'ve brought in.%SPEECH_ON%That is quite the sight, mercenary. I\'m happy you have brought it to me.%SPEECH_OFF%%They_employer% leans back.%SPEECH_ON%Leave it on my desk. Maybe I can scare the children with it. The little gits are getting too used to fineries methinks.%SPEECH_OFF%%They_employer% snaps his fingers and a servant comes to give you %reward% crowns. | You bring the Nachzehrer head to %employer% who stares at it for a long time.%SPEECH_ON%That reminds me of someone. I can\'t quite put my finger on it, and I\'m not sure I should. Excuse me, sellsword, I borrow your time without paying for it. Servant, give the %companyname% their money!%SPEECH_OFF%You are rewarded as promised. | %employer% takes the Nachzehrer head and holds it up. A few mewling cats seemingly appear out of nowhere, circling beneath it like buzzards would overhead. %They_employer% throws it out the window and the felines go running.%SPEECH_ON%Good work, sellsword. %reward% crowns, as promised.%SPEECH_OFF% | You put a Nachzehrer head on %employer%\'s table. %They_employer% looks up from a dinner plate, glances at the head, then at you.%SPEECH_ON%I was eating, sellsword.%SPEECH_OFF%The silverware clatters as the disgusted %person_employer% shoves the plate aside. A servant whisks the food away, probably to try and eat it himself. %employer% takes a satchel out and puts it on the table.%SPEECH_ON%%reward_completion% crowns as was promised.%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "A successful hunt.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Rid the town of nachzehrers");
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
		this.m.Screens.push({
			ID = "Success4",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_04.png[/img]{You enter %employer%\'s office carrying the dead spider on your back. The %person_employer% screams and %their_employer% chair squalls as it flings back across the floor. %They_employer% jumps to %their_employer% feet and draws a butterknife off %their_employer% desk. You throw the dead webknecht from your shoulder and it clatters on its back. The townsman slowly comes forward. %They_employer% sheathes the butterknife in a loaf of bread and shakes %their_employer% head.%SPEECH_ON%By the old gods, you nearly gave me a heart attack.%SPEECH_OFF%Nodding, you tell the %person_employer% it required more than a big boot to squash these beasts. %They_employer% nods back.%SPEECH_ON%Of course, sellsword, of course! Your payment of %reward_completion% crowns is right there in the corner. And, please, take that ungodly thing with you when you leave.%SPEECH_OFF% | Cats hiss and flee the second you step into %employer%\'s room. A few dogs, always the sort for a mystery, run about your legs and sniff the spider carcass, their noses crinkling and pulling away but always coming back for more. The townsman is writing notes and %they_employer% can hardly believe %their_employer% eyes. %They_employer% sets %their_employer% quill pen down.%SPEECH_ON%Is that a giant spider?%SPEECH_OFF%You nod. %They_employer% smiles and picks %their_employer% quill pen back up.%SPEECH_ON%Perhaps I should have suggested you bring a very big shoe. Your payment of %reward_completion% crowns is there in the satchel. Go on, take it. It\'s all there. And you can leave the corpse. I\'d like to get a closer look at the creature.%SPEECH_OFF% | %employer% is hosting a birthday party when you enter %their_employer% room with a giant dead spider and fling the corpse across the floor. Its bristly hairs hiss as they scratch across the stone and its eight legs scuttle upside down like some furniture of horror and it strays sideways and pops off the corner of a bookshelf and flips onto its toes and prongs there as though ready to pounce. Chaos breaks out as everyone screams and runs out the door or bails from the nearest open window, a litter of colorful confetti playfully twirling in their wake. The townsman stands alone amongst the emptied space and purses %their_employer% lips.%SPEECH_ON%Truly, sellsword, was that necessary?%SPEECH_OFF%You nod and tell %them_employer% that hiring you was necessary and that paying you will still be very necessary. The %person_employer% shakes %their_employer% head and gestures with a fake donkey tail to the corner of the room.%SPEECH_ON%Your satchel\'s over there with %reward_completion% crowns, as agreed upon. Now get that awful thing out of here and tell those fine folks the reveries need not be over.%SPEECH_OFF% | You don\'t think you can fit the spider corpse into %employer%\'s room, so instead you slap it against %their_employer% window from the outside. You hear a horrified scream and the clatter of falling furniture. A moment later the adjacent window is thrown open. The townsman leans out.%SPEECH_ON%Oh very rich, sellsword, very rich! May the old gods serve you a thousand years of idle time for that one!%SPEECH_OFF%Nodding, you ask about your pay. %They_employer% begrudgingly tosses you a satchel.%SPEECH_ON%%reward_completion% crowns is in there. Now take that awful thing and go!%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "A successful hunt.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Rid the town of webknechts");
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
		this.m.Screens.push({
			ID = "Poachers1",
			Title = "At %townname%",
			Text = "[img]gfx/ui/events/event_10.png[/img]{As you leave, a pair of poachers approach. They claim to have spotted the beasts recently, and offer to join your hunt in exchange for a share of %cut% crowns paid in advance.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Deal.",
					function getResult()
					{
						return "Poachers2";
					}

				},
				{
					Text = "Leave it to the professionals.",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				local brothers = ::World.getPlayerRoster().getAll();
				local peddlerBackgrounds = ["background.peddler","background.legend_trader","background.legend_commander_trader"];
				foreach( bro in brothers )
				{
					if (peddlerBackgrounds.find(bro.getBackground().getID()) != null)
					{
						this.Contract.m.Peddler = ::MSU.asWeakTableRef(bro);
						// this.Contract.m.Peddler = bro;
						break;
					}
				}
				if (!::MSU.isNull(this.Contract.m.Peddler))
				{
					Options.push({
						Text = "%peddler% has a business proposal",
						function getResult()
						{
							return "Peddler1";
						}
					})
				}
			}
		});
		this.m.Screens.push({
			ID = "Poachers2",
			Title = "At %townname%",
			Text = "[img]gfx/ui/events/event_10.png[/img]{The poachers grin as you hand over the crowns. They join your party}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "This better be worth it.",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				// Pay their price
				this.World.Assets.addMoney(this.Flags.get("Cut") * -1);

				// Add 2 poachers to the guest roster
				local numPoachers = 2;
				for( local i = 0; i != numPoachers; i = ++i )
				{
					local poacher = this.World.getGuestRoster().create("scripts/entity/tactical/humans/legend_poacher_guest"); // Test character based off of legend_peasant_poacher stats & perks
					poacher.setFaction(1);
					poacher.setPlaceInFormation(19 + i);
					poacher.assignRandomEquipment();
					this.Flags.set("Poacher" + i, poacher.getID());
				}
				this.Flags.set("NumPoachers", numPoachers);

				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You lose [color=" + ::Const.UI.Color.NegativeEventValue + "]" + this.Flags.get("Cut") + "[/color] Crowns"
				});

				local poachers = [];
				for( local i = 0; i < this.Flags.get("NumPoachers"); i++ )
				{
					poachers.push(::Tactical.getEntityByID(this.Flags.get("Poacher" + i)).getName());
				}
				this.List.push({
					id = 11,
					icon = "ui/icons/asset_brothers.png",
					text = ::Const.LegendMod.Language.arrayToText(poachers, "and", ::Const.UI.Color.getHighlightDarkBackgroundValue()) + " temporarily join your party",
				});
			}
		});

		// Peddler business proposal
		this.m.Screens.push({
			ID = "Peddler1",
			Title = "A business proposal",
			Text = "[img]gfx/ui/events/event_92.png[/img]{%peddler% clears %their_peddler% throat as %they_peddler% steps forward in front of the poachers.%SPEECH_ON%Excuse me? This is a once-in-a-lifetime opportunity to experience the adventurous life of a mercenary! Surely YOU should be paying US for this opportunity?%SPEECH_OFF% | %peddler% leaps forward like a starving dog unable to contain itself. Gesticulating wildly, %they_peddler% launches into an impossibly rehearsed spiel on how this is an incredibly rare opportunity to embark on a \"Mercenary Experience\" for a jaw-droppingly low price of %cut% crowns. | Practically quivering with excitement, %peddler% plants %their_peddler% face uncomfortably close to one of the poachers\' own, spittle flying all over their face as %they_peddler% touts an \"all-inclusive package deal\" to experience mercenary work, the likes of which are hitherto unheard of in all the land.\n\nIt appears %peddler% has gone farking mad and is attempting to convince the poachers that they should be paying YOU instead.}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "{How about it? | Deal?}",
					function getResult()
					{
						local r = ::Math.rand(1,100);
						r = ::Math.min(100, r + (this.Contract.m.Peddler.getLevel() * 5));
						if (r > 90)
						{
							// Poachers pay you upfront
							this.Flags.set("PeddlerPayUpfront",true);
							return "Peddler2";
						}
						else if (r > 70)
						{
							// Poachers will pay you when the contract is successful
							this.Flags.set("PeddlerPayLater",true);
							return "Peddler2";
						}
						else if (r > 25)
						{
							// Poachers will join you for free
							this.Flags.set("PeddlerFree",true);
							return "Peddler2";
						}
						else
						{
							// Poachers will insist on payment
							return "Peddler3";
						}
					}
				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Peddler.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "Peddler2",
			Title = "A business proposal",
			Text = "[img]gfx/ui/events/event_10.png[/img]",
			Image = "",
			Characters = [],
			List = [],
			Options = [],
			function start()
			{
				this.Characters.push(this.Contract.m.Peddler.getImagePath());

				if (this.Flags.get("PeddlerPayUpfront"))
				{
					this.Text += "{Say what you want about %peddler%, but %they_peddler% somehow managed to pull it off. You quickly pick the coins off the outstretched palms of the very confused-looking poachers before they change their minds. | As the befuddled-looking poachers hand over their precious crowns, you wonder why %peddler% even needed to turn to a life of mercenary work. | To the astonishment of everyone except %peddler%, the poachers hand over a bag of crowns and eagerly fall in line with the %companyname%.}";
					// Profit
					this.World.Assets.addMoney(this.Flags.get("Cut"));
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Flags.get("Cut") + "[/color] Crowns"
					});

					this.Contract.m.Peddler.improveMood(::Const.MoodState.Euphoric - ::Math.minf(this.Contract.m.Peddler.getMood(), ::Const.MoodState.Euphoric), "Bamboozled some poachers");
					if (this.Contract.m.Peddler.getMoodState() >= ::Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = ::Const.MoodStateIcon[this.Contract.m.Peddler.getMoodState()],
							text = this.Contract.m.Peddler.getName() + ::Const.MoodStateEvent[this.Contract.m.Peddler.getMoodState()]
						});
					}

					this.Options = [
						{
							Text = "{Welcome to the experience of a lifetime. | I\'m beginning to question who the real danger is...}",
							function getResult()
							{
								return 0;
							}
						}
					]
				}
				else if (this.Flags.get("PeddlerPayLater"))
				{
					this.Text += "{The poachers look to each other as they consider %peddler%\'s offer. Out of the corner of your eye you see %peddler% licking %their_peddler% lips in anticipation. They eventually come to a decision.%SPEECH_ON%Fine, we will pay you, but only after the contract is completed, so you better make sure we make it back safely!%SPEECH_OFF%}";

					this.Contract.m.Peddler.improveMood(::Const.MoodState.Eager - ::Math.minf(this.Contract.m.Peddler.getMood(), ::Const.MoodState.Eager), "Bamboozled some poachers");
					if (this.Contract.m.Peddler.getMoodState() >= ::Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = ::Const.MoodStateIcon[this.Contract.m.Peddler.getMoodState()],
							text = this.Contract.m.Peddler.getName() + ::Const.MoodStateEvent[this.Contract.m.Peddler.getMoodState()]
						});
					}

					this.Options = [
						{
							Text = "{No promises. | Watch your step.}",
							function getResult()
							{
								return 0;
							}
						}
					]
				}
				else if (this.Flags.get("PeddlerFree"))
				{
					this.Text += "{You rub your temples as the poachers end up haggling with %peddler%. After an eternity and no shortage of groans from various members of the company, %peddler% walks back over cheerfully and announces that they have arrived at a suitable compromise - the poachers will join your hunt for free.\n\nYou turn to the poachers and are met with faces of sheer exhaustion and weariness.}";

					this.Contract.m.Peddler.improveMood(::Const.MoodState.Eager - ::Math.minf(this.Contract.m.Peddler.getMood(), ::Const.MoodState.Eager), "Bamboozled some poachers");
					if (this.Contract.m.Peddler.getMoodState() >= ::Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = ::Const.MoodStateIcon[this.Contract.m.Peddler.getMoodState()],
							text = this.Contract.m.Peddler.getName() + ::Const.MoodStateEvent[this.Contract.m.Peddler.getMoodState()]
						});
					}

					this.Options = [
						{
							Text = "{How did we end up here? | I\'m beginning to question who the real danger is... | Remember, you approached us first.}",
							function getResult()
							{
								return 0;
							}
						}
					]
				}

				// Add 2 poachers to the guest roster
				local numPoachers = 2;
				for( local i = 0; i != numPoachers; i = ++i )
				{
					local poacher = this.World.getGuestRoster().create("scripts/entity/tactical/humans/legend_poacher_guest"); // Test character based off of legend_peasant_poacher stats & perks
					poacher.setFaction(1);
					poacher.setPlaceInFormation(19 + i);
					poacher.assignRandomEquipment();
					this.Flags.set("Poacher" + i, poacher.getID());
				}
				this.Flags.set("NumPoachers", numPoachers);
				local poachers = [];
				for( local i = 0; i < this.Flags.get("NumPoachers"); i++ )
				{
					poachers.push(::Tactical.getEntityByID(this.Flags.get("Poacher" + i)).getName());
				}
				this.List.push({
					id = 11,
					icon = "ui/icons/asset_brothers.png",
					text = ::Const.LegendMod.Language.arrayToText(poachers, "and", ::Const.UI.Color.getHighlightDarkBackgroundValue()) + " temporarily " + ::Const.LegendMod.Language.pluralize(poachers.len(), "joins", "join") + " your party",
				});

			}
		});
		this.m.Screens.push({
			ID = "Peddler3",
			Title = "A business proposal",
			Text = "[img]gfx/ui/events/event_10.png[/img]{Despite the best efforts of %peddler%, the poachers shake their heads and insist on being paid %cut% crowns for their services. | Remarkably, the poachers were able to resist the onslaught of words and gestures from %peddler%.%SPEECH_ON%You\'ll have to pay us %cut% crowns if you want us to risk our lives like that%SPEECH_OFF%You realize they\'re not talking about the beasts.}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "Very well.",
					function getResult()
					{
						return "Poachers2";
					}
				},
				{
					Text = "Forget it.",
					function getResult()
					{
						return 0;
					}
				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Peddler.getImagePath());
			}
		});

		// All Poachers Survived
		this.m.Screens.push({
			ID = "PoacherSurvival1",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_10.png[/img]{The poachers give you a slight nod before returning to their homes.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Pleasure working with you.",
					function getResult()
					{
						if (this.Flags.get("IsHumans"))
						{
							return "Success2";
						}
						else if (this.Flags.get("IsGhouls"))
						{
							return "Success3";
						}
						else if (this.Flags.get("IsSpiders"))
						{
							return "Success4";
						}
						else
						{
							return "Success1";
						}
					}
				}
			],
			function start()
			{
				if (this.Flags.get("PeddlerPayLater"))
				{
					this.Text = "[img]gfx/ui/events/event_10.png[/img]{The poachers excitedly recount to each other the adventure they\'d had, happily handing over a bag of crowns to you before parting ways.}"
					this.World.Assets.addMoney(this.Flags.get("Cut"));
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Flags.get("Cut") + "[/color] Crowns"
					});
				}

				if (this.Math.rand(1, 100) <= 50)
				{
					this.Text += "{%SPEECH_ON%We'll be sure to let the town know of the good work you\'ve done.%SPEECH_OFF%}";
					this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/legend_word_of_mouth_situation"), 3, this.Contract.m.Home, this.List);
				}

				local poachers = [];
				for( local i = 0; i < this.Flags.get("NumPoachers"); i++ )
				{
					poachers.push(::Tactical.getEntityByID(this.Flags.get("Poacher" + i)).getName());
				}
				this.List.push({
					id = 11,
					icon = "ui/icons/asset_brothers_bw.png",
					text = ::Const.LegendMod.Language.arrayToText(poachers, "and", ::Const.UI.Color.getHighlightDarkBackgroundValue()) + ::Const.LegendMod.Language.pluralize(poachers.len()," leaves", " leave") + " your party",
				});
			}
		});
		// Not all Poachers Survived
		this.m.Screens.push({
			ID = "PoacherSurvival2",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_10.png[/img]{Not all of the poachers who joined your hunt made it back alive, and as you part ways, you wonder if there was more you could\'ve done.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Mercenary work is dangerous.",
					function getResult()
					{
						if (this.Flags.get("IsHumans"))
						{
							return "Success2";
						}
						else if (this.Flags.get("IsGhouls"))
						{
							return "Success3";
						}
						else if (this.Flags.get("IsSpiders"))
						{
							return "Success4";
						}
						else
						{
							return "Success1";
						}
					}
				}
			],
			function start()
			{
				local poachers = [];
				for( local i = 0; i < this.Flags.get("NumPoachers"); i++ )
				{
					local p = ::Tactical.getEntityByID(this.Flags.get("Poacher" + i));
					if (!::MSU.isNull(p)) poachers.push(p.getName());
				}

				if (this.Flags.get("PeddlerPayLater"))
				{
					this.Text = "[img]gfx/ui/events/event_10.png[/img]{" + format("The remaining %s %s over their share of the payment promised for the \"once-in-a-lifetime\" experience. For some, the experience did live up to its name.",::Const.LegendMod.Language.pluralize(poachers.len(),"poacher", "poachers"),::Const.LegendMod.Language.pluralize(poachers.len(),"hands", "hand")) + "}"
					this.World.Assets.addMoney(::Math.ceil(this.Flags.get("Cut") * 1.0 * poachers.len() / this.Flags.get("NumPoachers")));
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Flags.get("Cut") + "[/color] Crowns"
					});
				}


				this.List.push({
					id = 11,
					icon = "ui/icons/asset_brothers_bw.png",
					text = ::Const.LegendMod.Language.arrayToText(poachers, "and", ::Const.UI.Color.getHighlightDarkBackgroundValue()) + ::Const.LegendMod.Language.pluralize(poachers.len()," leaves", " leave") + " your party",
				});
			}
		});
		// None of the Poachers survived
		this.m.Screens.push({
			ID = "PoacherSurvival3",
			Title = "On your return...",
			Text = "{[img]gfx/ui/events/event_10.png[/img]The townsfolk notice the conspicuous absence of the poachers who left with you. You feel the judgement of their stares.\n\nYou count yourself lucky to endure merely the stares of the living rather than the dead, which might have been the case had you not been successful. | [img]gfx/ui/events/event_20.png[/img]The townsfolk barely notice your return - far too engrossed in their own business. Hopefully they do not notice that the poachers have not returned either. | [img]gfx/ui/events/event_20.png[/img]You turn to bid farewell to the poachers who joined you, completely forgetting the gruesome end they met in battle. You remind yourself that you should quit while you\'re ahead... someday.'}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Whoops.",
					function getResult()
					{
						if (this.Flags.get("IsHumans"))
						{
							return "Success2";
						}
						else if (this.Flags.get("IsGhouls"))
						{
							return "Success3";
						}
						else if (this.Flags.get("IsSpiders"))
						{
							return "Success4";
						}
						else
						{
							return "Success1";
						}
					}
				}
			],
			function start()
			{
			}
		});

	}

	function spawnEnemies() {
		local playerTile = this.World.State.getPlayer().getTile();
		local tile = this.getTileToSpawnLocation(playerTile, 5, 10);
		local party;

		if (this.m.Flags.get("IsHumans"))
		{
			party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).spawnEntity(tile, "Direwolves", false, this.Const.World.Spawn.BanditsDisguisedAsDirewolves, 100 * this.getDifficultyMult() * this.getScaledDifficultyMult());
			party.setDescription("A pack of ferocious direwolves on the hunt for prey.");
			party.setFootprintType(this.Const.World.FootprintsType.Direwolves);
			this.Const.World.Common.addFootprintsFromTo(this.m.Home.getTile(), party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Direwolves, 0.75);
		}
		else if (this.m.Flags.get("IsGhouls"))
		{
			party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Nachzehrers", false, this.Const.World.Spawn.Ghouls, 110 * this.getDifficultyMult() * this.getScaledDifficultyMult());
			party.setDescription("A flock of scavenging nachzehrers.");
			party.setFootprintType(this.Const.World.FootprintsType.Ghouls);
			this.Const.World.Common.addFootprintsFromTo(this.m.Home.getTile(), party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Ghouls, 0.75);
		}
		else if (this.m.Flags.get("IsSpiders"))
		{
			party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Webknechts", false, this.Const.World.Spawn.Spiders, 110 * this.getDifficultyMult() * this.getScaledDifficultyMult());
			party.setDescription("A swarm of webknechts skittering about.");
			party.setFootprintType(this.Const.World.FootprintsType.Spiders);
			this.Const.World.Common.addFootprintsFromTo(this.m.Home.getTile(), party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Spiders, 0.75);
		}
		else
		{
			party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Direwolves", false, this.Const.World.Spawn.Direwolves, 110 * this.getDifficultyMult() * this.getScaledDifficultyMult());
			party.setDescription("A pack of ferocious direwolves on the hunt for prey.");
			party.setFootprintType(this.Const.World.FootprintsType.Direwolves);
			this.Const.World.Common.addFootprintsFromTo(this.m.Home.getTile(), party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Direwolves, 0.75);
		}

		party.setAttackableByAI(false);
		party.setFootprintSizeOverride(0.75);
		this.m.Target = this.WeakTableRef(party);
		party.getSprite("banner").setBrush("banner_beasts_01");
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local roam = this.new("scripts/ai/world/orders/roam_order");
		roam.setPivot(this.m.Home);
		roam.setMinRange(2);
		roam.setMaxRange(8);
		roam.setAllTerrainAvailable();
		roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
		roam.setTerrain(this.Const.World.TerrainType.Shore, false);
		roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
		c.addOrder(roam);
		return party;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : ::Const.UI.getColorized(::Const.Strings.Direction8[::World.State.getPlayer().getTile().getDirection8To(this.m.Target.getTile())], ::Const.UI.Color.getHighlightDarkBackgroundValue())
		]);
		_vars.push([ // Will store the cut that the optional characters ask for.
			"cut",
			::Const.UI.getColorized(this.m.Flags.get("Cut"), ::Const.UI.Color.getHighlightDarkBackgroundValue()),
		]);

		if (!::MSU.isNull(this.m.Peddler))
		{
			_vars.push([
				"peddler",
				::Const.UI.getColorized(this.m.Peddler.getName(), ::Const.UI.Color.getHighlightDarkBackgroundValue()),
			]);
			::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Peddler.getGender(), "peddler");
		}

		if (!::MSU.isNull(this.m.Poacher))
		{
			_vars.push([
				"poacher",
				::Const.UI.getColorized(this.m.Poacher.getName(), ::Const.UI.Color.getHighlightDarkBackgroundValue()),
			]);
			::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Poacher.getGender(), "poacher");
		}

		if (!::MSU.isNull(this.m.ExpertHunter))
		{
			_vars.push([
				"expert",
				::Const.UI.getColorized(this.m.ExpertHunter.getName(), ::Const.UI.Color.getHighlightDarkBackgroundValue()),
			]);
			::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.ExpertHunter.getGender(), "expert");
		}

		local beasts;
		if (this.m.Flags.get("IsHumans"))
		{
			beasts = "Direwolves";
		}
		else if (this.m.Flags.get("IsGhouls"))
		{
			beasts = "Ghouls";
		}
		else if (this.m.Flags.get("IsSpiders"))
		{
			beasts = "Spiders";
		}
		else
		{
			beasts = "Direwolves";
		}
		_vars.push([
			"beasts",
			::Const.UI.getColorized(beasts, ::Const.UI.Color.getHighlightDarkBackgroundValue()),
		])
	}

	function onHomeSet()
	{
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Target != null && !this.m.Target.isNull())
			{
				this.m.Target.getSprite("selection").Visible = false;
				this.m.Target.setOnCombatWithPlayerCallback(null);
			}

			this.m.Home.getSprite("selection").Visible = false;

			this.World.getGuestRoster().clear();
			this.m.Peddler = null;
			this.m.Poacher = null;
			this.m.ExpertHunter = null;
		}
	}

	function onIsValid()
	{
		return true;
	}

	function onSerialize( _out )
	{
		if (this.m.Target != null && !this.m.Target.isNull())
		{
			_out.writeU32(this.m.Target.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local target = _in.readU32();

		if (target != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
		}

		this.contract.onDeserialize(_in);
	}

});

