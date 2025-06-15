this.legend_hunting_stollwurms_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		Dude = null,
		IsPlayerAttacking = true,
		MinStrength = 10, // player needs to earn 10% of bonus (not including base 5% bonus) for this contract to be valid
		Perk = ::Legends.Perk.LegendFavouredEnemyLindwurm,
		ValidTypes = this.Const.LegendMod.FavoriteLindwurm,
		LevelSumRequiredForRandomSpawn = 50,
		IsRandomlyAdded = null,
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.legend_hunting_stollwurms";
		this.m.Name = "Hunting Stollwurms (Legendary)";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DifficultyMult = this.Math.rand(145, 175) * 0.01;
		this.m.DescriptionTemplates = [
			"You have to be either brave or foolish to fight a Lindwurm, the old saying goes. Looking at these especially monstrous specimens through your spyglass, you decide to add \'insane or desperate\' to that list.",
			"Stollwurms scales are as hard as iron. Some tribes worship these apex predators as gods.",
			"Blessed are the maker stollwurms, whose passage cleanses the world. You don\'t believe that farkin\' nonsense of course.",
		];
		this.m.IsRandomlyAdded = ::Math.rand(1, 100) <= 5;
	}

	function getBanner()
	{
		return "ui/banners/factions/banner_legend_s";
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 1600 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 10)
		{
			this.m.Payment.Completion = 0.9;
			this.m.Payment.Advance = 0.1;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.m.Flags.set("Bribe", this.Math.rand(300, 600));
		this.m.Flags.set("MerchantsDead", 0);
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Hunt down the Stollwurms around " + this.Contract.m.Home.getName()
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

				if (r <= 10)
				{
					this.Flags.set("IsAnimalActivist", true);
				}
				else if (r <= 25)
				{
					this.Flags.set("IsBeastFight", true);
				}
				else if (r <= 35)
				{
					this.Flags.set("IsMerchantInDistress", true);
				}

				this.Flags.set("StartTime", this.Time.getVirtualTimeF());
				this.Contract.spawnEnemies();
				this.Contract.m.Home.setLastSpawnTimeToNow();
				this.Contract.setScreen("Overview");
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
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive())
				{
					if (this.Flags.get("IsMerchantInDistress"))
					{
						if (this.Flags.get("MerchantsDead") < 5)
						{
							this.Contract.setScreen("MerchantDistressSuccess");
						}
						else
						{
							this.Contract.setScreen("MerchantDistressFailure");
						}
					}
					else
					{
						this.Contract.setScreen("Victory");
					}

					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
				else if (!this.Flags.get("IsBanterShown") && this.Contract.m.Target.isHiddenToPlayer() && this.Math.rand(1, 1000) <= 1 && this.Flags.get("StartTime") + 15.0 <= this.Time.getVirtualTimeF())
				{
					this.Flags.set("IsBanterShown", true);
					this.Contract.setScreen("Banter");
					this.World.Contracts.showActiveContract();
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (this.Flags.get("IsBeastFight"))
				{
					this.Contract.setScreen("BeastFight");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsMerchantInDistress"))
				{
					this.Contract.setScreen("MerchantDistress");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsAnimalActivist"))
				{
					this.Contract.setScreen("AnimalActivist");
					this.World.Contracts.showActiveContract();
				}
				else if (!this.Flags.get("IsEncounterShown"))
				{
					this.Flags.set("IsEncounterShown", true);
					this.Contract.setScreen("Encounter");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (_combatID != "Stollwurms")
				{
					return;
				}

				if (_actor.getType() == this.Const.EntityType.CaravanDonkey || _actor.getType() == this.Const.EntityType.CaravanHand)
				{
					this.Flags.increment("MerchantsDead");
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
					if (this.Flags.get("BribeAccepted") && this.Math.rand(1, 100) <= 40)
					{
						this.Contract.setScreen("Failure");
					}
					else
					{
						this.Contract.setScreen("Success");
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
			Text = "[img]gfx/ui/events/event_31.png[/img]{You enter the keep and are shown down to the cellar. While the room clearly once held food stores, they are reduced to rubbish now, smashed around the room. A huge hole has been smashed in one wall, and %employer% has his head pointed down the tunnel peering into the gloom. You see torchlight further down the tunnel, but a voice from the hole yells out. %SPEECH_ON%It\'s no use sire, the tunnel ends in a collapse.%SPEECH_OFF% %employer% turns back to the room and sees you waiting. %SPEECH_ON%Good, good. Glad to see you tracker. They tell me you have experience hunting wurms and as you can see, I have a wurm problem. A Stollwurm has been terrorising the area, raiding our supplies and taking cattle before disapearing as fast as it arrived. We have tried chasing it down the holes, laying traps and every other trick we can think of. This is no ordinary wurm, it is as quick as lightning and just as deadly. It has killed several of my men, and will require expert tracking to find. Are you up for the challenge?%SPEECH_OFF% }",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{That\'s a mighty big task you\'re asking of us. | I expect to be well compensated to fight an enemy such as this. | I expect you to make me a rich man for this.}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{Sounds more like what you need are heroes and fools. | It\'s not worth the risk. | I don\'t think so.}",
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
			ID = "Banter",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/legend_stollwurm_hole.png[/img]{%randombrother% points out a large burrow, big enough for three cows to walk abreast. The tunnel smells like fresh death and excrement, the stollwurm is no doubt close. | %randombrother% is poking at the edge of a hole. He turns to you with a grim look. %SPEECH_ON%Stollwurm took my great uncle. He was walking across a field and the ground opened up beneath him. The beast appeared directly below him, gobbled him up and left. I\'ve had nightmares about them ever since. I do not like the size of these holes.%SPEECH_OFF% An offputting tale, when even the ground is not an ally. You direct the company to hold firm, those stollwurms cannot be far. | The tracks have the grass flattened in a snaking pattern with holes set to the sides. %randombrother% crouches beside the patterns.%SPEECH_ON%Either a plough with no dig or this be the critters we\'re lookin\' for.%SPEECH_OFF%You nod. The stollwurm cannot be far.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Be on the lookout!",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Encounter",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/legend_stollwurm_hole_full.png[/img]{You are checking the map when %randombrother% calls out. Looking up, you see the stollwurms emerging from a hole in the ground, great sheets of dust streaming off their sides. Their bodies sway low to the ground as they whip their way toward the %companyname%. You draw out your sword and order the men into formation. | The company comes upon a cave lined with boulders at its front. But as you draw near, the rocks uncoil and flip mid-air and legs shoot out their bellies to plant the landings of what are clearly stollwurms. You step back as the beasts wriggle the dust off their backs and snap their maws with guttural croaking. They turn to you, eyes blinking, and begin to lazily come forward as though your mercenaries were but a minor inconvenience to dispatch. You order the company into formation. The monsters, perhaps sensing you are more of a threat, suddenly surge forward, powerfully hissing as their bodies sidewinder over the ground with surprising speed. | The %companyname% step toward a hill with bones crunching under every step. %randombrother% shushes the company and points to the hilltop. Stollwurms are curved about its crest as though to embroider the very earth. Seemingly sensing your stare, the beasts unfurl and come down the slope, some half twisting like children rolling down a hill. Their maws clap and snap, tongues licking the dust out of their eyes, altogether looking like sleepwalking critters more than murderous monsters. But the second their feet step upon the flat earth they seize up and bolt forward, their snaky shapes streaking across the boneyard, powdered bonemeal rooster tailing up in their wake. Drawing your sword, you urgently order the men to formation.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Charge!",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "AnimalActivist",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_17.png[/img]{You find the stollwurms slithering about a dugout in the ground, but before you can go to battle a man interrupts you with a humanly hiss. He looks like he has not shaved in days, has a fat satchel yoked over both shoulders and a bandana bunches up his hair like potted sagebrush. Aside from his haggard looks there is not a weapon on him. You ask what he wants. He speaks hurriedly and in a hushed tone.%SPEECH_ON%You here to kill the stollwurms?%SPEECH_OFF%The nasty snakelike monsters are wriggling around in the distance, seemingly playing with one another like puppies or kittens would. You nod and tell him they\'re killers and you\'ve been paid to slay them all. The man purses his lips.%SPEECH_ON% See that gleam in their coat? That\'s unique to them, and they are the last of their kind. These are rarified stollwurms, sir, and it\'d be a horrid ruin upon the world itself for them to be made wholly nonexistent. How about I give you %bribe% crowns and, uh, you was paid by someone, right? So you take this, too.%SPEECH_OFF%He pulls a great, scratchy stollwurm skinsuit out of his satchel and offers to hand it over.%SPEECH_ON%Tell your employer you\'d found and killed the stollwurms and show them this. They won\'t know the difference. And if you think about doublecrossing me here let me say this, I look a hint of crazy but I\'m actually a barrel of it. And a crazy fark like myself wouldn\'t survive following these giant, wonderful, and beautiful stollwurms around if he didn\'t know a thing or two, got it?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Out of the way, fool. We have a beast to slay.",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				},
				{
					Text = "Very well. I accept your offer.",
					function getResult()
					{
						return "AnimalActivistAccept";
					}

				}
			],
			function start()
			{
				this.Flags.set("IsAnimalActivist", false);
			}

		});
		this.m.Screens.push({
			ID = "AnimalActivistAccept",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_17.png[/img]{The way you see it the stollwurms here are not truly your problem, you were just paid to take care of them. And you could potentially get paid twice if the crazy stollwurm protector\'s skinsuit fools %employer%.\n\nYou take the deal. The fool thanks you and hugs you unexpectedly. He smells awful and his hair has become so matted and thick that tiny little bugs have bored out caves there and can be seen staring at you. A tiny skink scuttles between the stinky stalks and snatches one of the bugs. You throw the man back and wish him luck in whatever the hell he\'s doing. He puts out his thumb and pinky finger and wags the hand.%SPEECH_ON%You, sir, are righteous.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Righteous. Right.",
					function getResult()
					{
						local bribe = this.Flags.get("Bribe");
						this.World.Assets.addMoney(bribe);

						if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
						{
							this.Contract.m.Target.getSprite("selection").Visible = false;
							this.Contract.m.Target.setOnCombatWithPlayerCallback(null);
							this.Contract.m.Target.die();
							this.Contract.m.Target = null;
						}

						this.Flags.set("BribeAccepted", true);
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				local bribe = this.Flags.get("Bribe");
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + bribe + "[/color] Crowns"
				});
			}

		});
		this.m.Screens.push({
			ID = "BeastFight",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/legend_stollwurm.png[/img]{Dust clouds belch from a distant cave entrance. As you draw near, you can hear the hiss of the stollwurms and intermittent growling of something else entirely.%SPEECH_ON%Look, sir!%SPEECH_OFF%%randombrother% points to the rim of the cave dugout. There\'s a group of orcs tackling a stollwurm, one being slung around as it holds onto the tail, another is hand fighting its maw to not get bit. \n\nShaking your head, you draw out your sword and order the men into formation. Looks like this is going to be a proper barnstormer if there ever was one.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I don\'t know if this is good or bad.",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "Stollwurms";
						p.Music = this.Const.Music.BeastsTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Edge;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Random;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.OrcScouts, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "MerchantDistress",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_41.png[/img]{You spot a merchant and his wagon trundling up the road. The rear of the wagon lifts upward and the caravan hand on the back is launched like a ragdoll. A streak of green slips behind the caravan and another goes to the side. The merchant turns and jumps into the wagon as stollwurms start their assault. These are no doubt the creatures you\'ve been looking for. At your command, the %companyname% can rush forward before the caravan is destroyed.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Attack!",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "Stollwurms";
						p.Music = this.Const.Music.BeastsTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Edge;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Random;
						p.Entities.push({
							ID = this.Const.EntityType.CaravanDonkey,
							Variant = 0,
							Row = -1,
							Script = "scripts/entity/tactical/objective/donkey",
							Faction = this.Const.Faction.PlayerAnimals,
							Callback = null
						});
						p.Entities.push({
							ID = this.Const.EntityType.CaravanDonkey,
							Variant = 0,
							Row = -1,
							Script = "scripts/entity/tactical/objective/donkey",
							Faction = this.Const.Faction.PlayerAnimals,
							Callback = null
						});
						p.Entities.push({
							ID = this.Const.EntityType.CaravanHand,
							Variant = 0,
							Row = -1,
							Script = "scripts/entity/tactical/humans/legend_caravan_hand",
							Faction = this.Const.Faction.PlayerAnimals,
							Callback = null
						});
						p.Entities.push({
							ID = this.Const.EntityType.CaravanHand,
							Variant = 0,
							Row = -1,
							Script = "scripts/entity/tactical/humans/legend_caravan_hand",
							Faction = this.Const.Faction.PlayerAnimals,
							Callback = null
						});
						p.Entities.push({
							ID = this.Const.EntityType.CaravanHand,
							Variant = 0,
							Row = -1,
							Script = "scripts/entity/tactical/humans/legend_caravan_hand",
							Faction = this.Const.Faction.PlayerAnimals,
							Callback = null
						});
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				},
				{
					Text = "Fall back!",
					function getResult()
					{
						this.Flags.set("IsMerchantInDistress", false);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "MerchantDistressSuccess",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_41.png[/img]{The battle is over. You have the men skin a few of the stollwurms while you go and talk to the merchant. He bows in thanks and kisses your ringless finger.%SPEECH_ON%Thank you, sir, thank you! Ohhh, my wagon! My goods!%SPEECH_OFF%His eyes twist away to the remains of his caravan. He collapses, his knees in the debris, and shakes his head.%SPEECH_ON%I wish I had anything to pay you with, stranger, but it\'s all gone.%SPEECH_OFF%But then he holds a finger up. He jumps back to his feet and asks if you have a map. You show what you got, and he takes out a quill pen.%SPEECH_ON%Here, I know of a spot that is said to hold great treasure. I don\'t know if that\'s true or not, but the rumor\'s as good as gold if it is!%SPEECH_OFF%Yeah, if. You thank the merchant for his generosity anyway and wish him better luck on his journey ahead. As for the %companyname%, it needs to return to %employer% to get paid.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We should pay a visit to that place one day.",
					function getResult()
					{
						this.Contract.setState("Return");
						local bases = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
						local candidates_location = [];

						foreach( b in bases )
						{
							if (!b.getLoot().isEmpty() && !b.isLocationType(this.Const.World.LocationType.Unique) && !b.getFlags().get("IsEventLocation"))
							{
								candidates_location.push(b);
							}
						}

						if (candidates_location.len() == 0)
						{
							return 0;
						}

						local location = candidates_location[this.Math.rand(0, candidates_location.len() - 1)];
						this.World.uncoverFogOfWar(location.getTile().Pos, 700.0);
						location.getFlags().set("IsEventLocation", true);
						location.setDiscovered(true);
						this.World.getCamera().moveTo(location);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "MerchantDistressFailure",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_60.png[/img]{The battle is over. You have half your men go about skinning the stollwurms to show %employer% when you get back. The other half sift through the remains of the merchant\'s caravan. There is nothing of note to find, not even gold. Anything of value has been smashed to pieces in the fighting. The merchant himself has been torn in half and the legs sit a way away with their pockets turned out and empty, %randombrother% squatting beside the remains. He nods.%SPEECH_ON%Well, that\'s a sorry way to go. Broke and even more broke.%SPEECH_OFF%You nod back and then holler at the men to pack their things. It is time to return to your employer and collect your pay.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "At least we put an end to those beasts.",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Victory",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_130.png[/img]{Fighting the stollwurms was like taking a butterknife and jabbing it into a basket of vipers. They fought like something from another world, hissing and spewing and biting, but they were no match for the %companyname%\'s resolve and skill. You have the men scalp and skin the creatures and ready them for a return to %employer% for a well earned payday. | The stollwurms lay in well earned ruin. Your company goes about poking the corpses at a distance, making sure the bastards are truly dead. A few gargle and flip over, but that\'s about the last of their living issuances. You order the overgrown lizards scalped and skinned. %employer% will be expecting proof, after all. | You crouch beside a stollwurm and take your hand over its skin. The way you figure, the scales are long and sharp enough to cut your fingers off if jammed in between the wedges. You then stand akimbo over the head and stare into its maw, getting a measure of its teeth with your hands and its gullet with the steel of your sword. %randombrother% comes to your side and asks what they\'re to do next. You unsheathe your sword from the stollwurm\'s throat, wipe it clean, and sheathe it proper. You order the men to skin a few of the beasts and ready a return to %employer%. | The battle over, you have the stollwurms skinned and dressed for anything of value. It is not long before the field stinks of the skinks, the overly large lizards being shorn of the scales that once protected them. Their sickly, glistening musculature bared for all to see, a nakedness and vulnerability is wrought upon the once and always monsters. %randombrother% snorts and runs a sleeve beneath his nose. He nods at his handiwork.%SPEECH_ON%Nothing more than a common creature, just a shade larger than it ought to be.%SPEECH_OFF%Damn right. You order the men to collect what they\'ve got and ready a return to %employer%.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We did it.",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_77.png[/img]{You enter %employer%\'s room dragging in some stollwurm flesh. He looks up from his desk, eyes the scales and long sleeve of reptilian skin, glances at you, then glances at his paymaster and gives a steady nod. The paymaster takes a satchel of crowns and hands them over. %employer% returns to his work, addressing you as he writes with a quill.%SPEECH_ON%Good work, sellsword. Reports of the bastards has died off in total, so I wager our money here has been put to good use. Leave the skin. I\'ve a man who can fix up some mean boots with it.%SPEECH_OFF%Did the %companyname% just work to get this fool new boots? You shake your head and make your leave. | %employer% welcomes you and your booty, a long, scratchy, scaly, scraping piece of stollwurm skin. You heave it across the floor where it skitters like a stiff leather jacket. The mayor nods.%SPEECH_ON%Very, very well done, good sir! Most excellent. Your pay, as promised.%SPEECH_OFF%The man hands you a satchel heavy with well earned crowns. | %employer% is found warming himself beside a fire. He turns around in the seat to see the stollwurm flesh you have brought in with you. The mayor nods.%SPEECH_ON%Quite alright work, sellsword. I\'m curious, do the lizard bastards grow their limbs back? I\'ve heard tales of the reptilian sort carrying such tricks.%SPEECH_OFF%You shrug and state each creature was slain with as much scientific curiosity a good sword can muster. %employer% purses his lips.%SPEECH_ON%Ah. Right. Well your pay is in the corner there, as much as agreed upon.%SPEECH_OFF%He returns to the fire, cozying himself up in a blanket and sipping at the lip of a steamy mug. | %employer% found outside and surrounded by raucous peasants. You yell over the crowd and display the stollwurm skin which you\'ve brought. The crowd quiets for a moment, whispers amongst its numbers, then returns to shouting. You purse your lips and elbow your way into the mob and demand the pay which you are owed. %employer% yells at the peons to spread out and let him breathe. While two guards stand close, he hands you a leather satchel.%SPEECH_ON%Good work, sellsword. If it ain\'t all there feel free to come back and kill me. I won\'t mind, not on this damned day.%SPEECH_OFF%As you take the satchel and leave, a peasant jabs his finger at the mayor.%SPEECH_ON%Tellin\' ya, that damned bastard, my supposed \'neighborly neighbor\', stole my birds and if he don\'t return them I\'mma burn his whole farm to the farkin\' ground!%SPEECH_OFF%}",
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
						this.World.Assets.getStash().add(this.new("scripts/items/supplies/goat_cheese_item"));
						this.World.Assets.getStash().add(this.new("scripts/items/supplies/wine_item"));
						this.World.Assets.getStash().add(this.new("scripts/items/supplies/ammo_item"));
						this.World.Assets.getStash().add(this.new("scripts/items/loot/armor_parts_item"));
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Rid the town of stollwurms");
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Hero of the land");
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
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Home, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Failure",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_43.png[/img]{You find %employer% in his room and it is full of guards. Not sure what is going on, you display the stollwurm\'s flesh to the mayor and demand your pay. His fingers clap together before fanning forward like a lumber saw.%SPEECH_ON%I don\'t think that will be happening, sellsword. I don\'t know where you got that goddam skinsuit you\'re carrying, and trust me I can tell it\'s old as shite and not some new flay, but I\'m still getting reports of lizards tearing the hinterlands a new arshole so if you don\'t mind, please kindly leave this town before I sic a whole different predator upon ya.%SPEECH_OFF%Taking a deep breath, you eye the guards. There\'s too many to fight off. %employer% sighs.%SPEECH_ON%If it\'s your honor you\'re thinking to protect, don\'t. I already talked these folks down from ambushing your arse the second you were to walk through that door. I did that out of little respect I have left. Don\'t waste it, hm?%SPEECH_OFF%Fair enough. It is what it is and you\'ve no one else to blame but yourself anyhow. You close the door and take your leave.}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Not entirely surprising.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail * 2);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail * 2, "Tried to swindle the town out of money");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
	}

	function spawnEnemies() {
		local playerTile = this.World.State.getPlayer().getTile();
		local tile = this.getTileToSpawnLocation(playerTile, 6, 12, [
			this.Const.World.TerrainType.Mountains
		]);
		local nearTile = this.getTileToSpawnLocation(playerTile, 4, 7);
		local party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Stollwurm", false, this.Const.World.Spawn.LegendStollwurm, 100 * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		party.getSprite("banner").setBrush("banner_beasts_01");
		party.setDescription("A Stollwurm - a burrowing bipedal dragon resembling a giant snake.");
		party.setAttackableByAI(false);
		party.setFootprintSizeOverride(0.75);
		this.Const.World.Common.addFootprintsFromTo(nearTile, party.getTile(), this.Const.BeastFootprints, 0.75);
		this.m.Target = this.WeakTableRef(party);
		party.getSprite("banner").setBrush("banner_beasts_01");
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local roam = this.new("scripts/ai/world/orders/roam_order");
		roam.setPivot(this.m.Home);
		roam.setMinRange(2);
		roam.setMaxRange(8);
		roam.setAllTerrainAvailable();
		roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
		roam.setTerrain(this.Const.World.TerrainType.Shore, false);
		roam.setTerrain(this.Const.World.TerrainType.Mountains, true);
		c.addOrder(roam);
		return party;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"bribe",
			this.m.Flags.get("Bribe")
		]);
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Target.getTile())]
		]);
	}

	function onHomeSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/ambushed_trade_routes_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Target != null && !this.m.Target.isNull())
			{
				this.m.Target.getSprite("selection").Visible = false;
				this.m.Target.setOnCombatWithPlayerCallback(null);
				this.m.Target.getController().getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(true);
				this.m.Target.getController().getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(true);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}

		if (this.m.Home != null && !this.m.Home.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Home.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(3);
			}
		}
	}

	function onIsValid()
	{
		local sumLevels = 0;
		foreach( bro in this.World.getPlayerRoster().getAll() )
		{
			sumLevels += bro.getLevel();
			if (!bro.getSkills().hasPerk(this.m.Perk))
				continue;

			local stats = this.Const.LegendMod.GetFavoriteEnemyStats(bro, this.m.ValidTypes);
			if (stats.Strength >= this.m.MinStrength)
				return true;
		}

		return this.m.IsRandomlyAdded && sumLevels > this.m.LevelSumRequiredForRandomSpawn;
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
		_out.writeBool(this.m.IsRandomlyAdded);
		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local target = _in.readU32();

		if (target != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
		}
		this.m.IsRandomlyAdded = _in.readBool();
		this.contract.onDeserialize(_in);
	}

});
