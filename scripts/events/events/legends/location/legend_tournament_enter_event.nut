this.legend_tournament_enter_event <- this.inherit("scripts/events/event", {
	m = {
		Veteran = null,
		IsActive = false
	},
	function create()
	{
		this.logInfo("Creating tournament event");
		this.m.ID = "event.location.legend_tournament_enter";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 100;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_tournament.png[/img]{ You approach a large metal door set into a huge defensive wall. There is clearly only one way in. A guard calls down from the battlements %SPEECH_ON%Here for the tournament? Never heard of you. Prove yourselves in the southern arena before you tread these hallowed grounds.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We must head to the arena.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/legend_tournament_castle.png[/img]{ You approach a large metal door set into a huge defensive wall. There is clearly only one way in. A guard calls down from the battlements gesturing towards your arena veteran %SPEECH_ON%Hail %veteran%! I heard of your performance in the arena, but who are these welps with you? Your party will need at least three veterans before we can let you in to the grand tournament. Teach them your ways and come back, we look forward to seeing you in the tourney. %SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We must return to the arena.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/legend_tournament.png[/img]{ You approach the huge defensive wall, the metal door opens without a guard in sight. As you pass through the gates a round of trumpets call out, and a voice echoes. %SPEECH_ON%Welcome %companyname% to the grand tournament!%SPEECH_OFF% A scattered round of applause follows the announcement and you head into the entrance hall.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "The welcome we deserve.",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/legend_tournament_artemesia.png[/img]{On the other side of the hall a door opens and a confident woman strides up to you. The trumpets sound again and a voice announces Artemisia, marshal of the grand tournament. She carries herself with the bearing of a fighter, wearing well made chainmail, a well worn scabbard and a welcoming smile. %SPEECH_ON%Good to see the renowned %companyname%, I am glad to see you have joined us among the ranks of the greatest fighters. Have you come for bragging rights, or coin? No matter, you shall find both here%SPEECH_OFF% She leads you to a window that looks down on a large grassy arena where rich patrons watch on as warriors are sparring with one another. %SPEECH_ON%We have three events to compete in today, a Show Match against a specific foe of your choosing, The Gauntlet against endless waves of humans, or The Grand Melee against a mix of all foes. Would you like to compete today? %SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Tell me of the Grand Melee.",
					function getResult( _event )
					{
						return "E";
					}

				},
				{
					Text = "Tell me of the Gauntlet.",
					function getResult( _event )
					{
						return "H";
					}

				},
				{
					Text = "I\'m interested in a Show Match.",
					function getResult( _event )
					{
						return "I";
					}

				},
				{
					Text = "Actually, I\'m not....",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "D2",
			Text = "[img]gfx/ui/events/legend_tournament_artemesia.png[/img]{You return to the main hall and find Artemesia talking with a ground of foreign fighters while they watch a bout of the Grand Melee through the viewing windows.  She sees you return, asks her leave from the fighters and greets you with a smile. %SPEECH_ON% So the %companyname% is not satisfied with mere Show Matches. I thought I saw a spark of something more in you. Which will it be, the Grand Melee or the Gauntlet?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Tell me of the Grand Melee.",
					function getResult( _event )
					{
						return "E";
					}

				},
				{
					Text = "Tell me of the Gauntlet.",
					function getResult( _event )
					{
						return "H";
					}

				},
				{
					Text = "Sorry, I am looking for the way out.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/legend_tournament.png[/img]{Artemisia smiles and excitedly recites the rules of the Grand Melee %SPEECH_ON%These are the mandated rules of the Grand Melee, \n\n 1. Your company will fight round after round, against both humans and beasts of all kinds, without combat rules.  \n\n 2. The prize begins at 1000 crowns. With each battle, the difficulty will increase and the prize will double. \n\n 3. You may keep any loot you find after the battle.%SPEECH_OFF%She smiles again, with genuine interest. %SPEECH_ON%This is the most glorious of the tournament events and I am delighted to personally watch your performance.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "The Grand Melee is for us, let\'s begin at once",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.GrandMelee, false);
						_event.registerToShowAfterCombat("F", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "Tell me of the Gauntlet instead",
					function getResult( _event )
					{
						return "H";
					}

				},
				{
					Text = "What can you tell me of the Show Matches",
					function getResult( _event )
					{
						return "J";
					}

				},
				{
					Text = "Actually, I\'m not...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/legend_tournament.png[/img]{After the battle you fall back to a private antechamber off the main tourney grounds. Artemisia congratulates you on a round well fought and offers you a choice to keep going with the Melee or take your prize.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Another round",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.GrandMelee, false);
						_event.registerToShowAfterCombat("F", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "That is enough",
					function getResult( _event )
					{
						return "G";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "F2",
			Text = "[img]gfx/ui/events/legend_tournament.png[/img]{After the battle you are led to the warrior hall where you are congratulated by the other warriors. A tournament official congratulates you on a round well fought and offers you a choice to keep going with the Gauntlet or take your prize}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Another round",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.GrandGauntlet, true);
						_event.registerToShowAfterCombat("F2", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "That is enough",
					function getResult( _event )
					{
						return "G2";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_04.png[/img]{Having completed the Melee you are led as champions from the field. Artemisia personally brings you a chest full of your rewards and walks you out to the door. %SPEECH_ON%What an excellent performance, I do hope we see you again soon! Take your rest well weary warrior, you have earned your place in these halls.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Fare well",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local round = this.World.Flags.get("LegendTournamentRound");
				round += 1;
				local payment = 1000 * round ;
				this.World.Assets.addMoney(payment);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = payment + " crowns as reward"
				});
				this.World.Flags.set("LegendTournamentRound", round);
			}

		});
		this.m.Screens.push({
			ID = "G2",
			Text = "[img]gfx/ui/events/event_04.png[/img]{Having completed the Gauntlet you are led through the main hall. Artemisia throws you a bag of coins. %SPEECH_ON%Well fought! I hope we see you in the tournament again, though I imagine you need some rest after that performance. %SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Fare well",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local round = this.World.Flags.get("LegendTournamentRound");
				round += 1;
				local payment = 500 * round;
				this.World.Assets.addMoney(payment);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = payment + " crowns as reward"
				});
				this.World.Flags.set("LegendTournamentRound", round);
			}

		});
		this.m.Screens.push({
			ID = "G3",
			Text = "[img]gfx/ui/events/event_04.png[/img]{The attendant guides you to a tournament official who checks a large ledger of fight results.  %SPEECH_ON% Ah yes, here you are. The %companyname%, took part in a small Show Match. Here is your reward.%SPEECH_OFF% The official hands a pouch to you, and the attendant leads you back out through the main door of the tournament.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Fare well",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local round = this.World.Flags.get("LegendTournamentRound");
				round += 1;
				local payment = 250 * round;

				this.World.Assets.addMoney(payment);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = payment + " crowns as reward"
				});
				this.World.Flags.set("LegendTournamentRound", round);
			}

		});
		this.m.Screens.push({
			ID = "H",
			Text = "[img]gfx/ui/events/legend_tournament.png[/img]{Artemisia sighs a little before repeating a speech she has clearly given many times %SPEECH_ON%The rules of the Gauntlet are simple, \n\n One — fight as many battles in a row as you can. \n\n Two — you will fight a mix of human competitors from across the lands without combat rules. \n\n Three — the prize begins at 250 crowns, each battle the difficulty will increase and the prize will double.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Lets begin the Gauntlet",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.GrandGauntlet, true);
						_event.registerToShowAfterCombat("F2", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "Tell me of the Grand Melee instead.",
					function getResult( _event )
					{
						return "E";
					}

				},
				{
					Text = "Perhaps just a Show Match.",
					function getResult( _event )
					{
						return "I";
					}

				},
				{
					Text = "Actually, I\'m not...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "I",
			Text = "[img]gfx/ui/events/legend_tournament.png[/img]{Artemisia nods at your choice, though you detect some disapointment. %SPEECH_ON%Show Matches are our most basic format, \n\n 1. Fight as many battles in a row as you can.  \n\n  2. Each round you choose what kind of enemy you\'ll fight against \n\n 3. The prize begins at 100 crowns, each battle the difficulty will increase and the prize will double. \n\n 4. No looting.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Sounds easy, I\'m in",
					function getResult( _event )
					{
						return "J";
					}

				},
				{
					Text = "Sounds too predictable, tell me of the Gauntlet instead.",
					function getResult( _event )
					{
						return "H";
					}

				},
				{
					Text = "Sounds far too boring, tell me of the Grand Melee instead.",
					function getResult( _event )
					{
						return "E";
					}

				},
				{
					Text = "I think we might need to leave and prepare.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "J",
			Text = "[img]gfx/ui/events/legend_tournament.png[/img]{Artemisia leads you to one of the smaller tournament fields, she seems distracted or perhaps a little bored.%SPEECH_ON%Good luck with your show, I must return to the Grand Melee, I will leave you in the capable hands of an attendent.%SPEECH_OFF% She turns quickly and heads back to the grand hall towards the cheering crowds. An attendant had been standing so still by the wall you had not noticed them, they step forward with the neutral expression of one long wearied by a repeatitive task and asks very matter of factly.%SPEECH_ON%Which enemy would you like to fight?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let me pick.",
					function getResult( _event )
					{
						return "J2";
					}

				},
				{
					Text = "Just choose for me.",
					function getResult( _event )
					{
						local SpawnGroups = [
							this.Const.World.Spawn.Noble,
							this.Const.World.Spawn.BanditBoss,
							this.Const.World.Spawn.Barbarians,
							this.Const.World.Spawn.Southern,
							this.Const.World.Spawn.NomadRaiders,
							this.Const.World.Spawn.Mercenaries,
							this.Const.World.Spawn.Militia,
							this.Const.World.Spawn.GoblinBoss,
							this.Const.World.Spawn.OrcBoss,
							this.Const.World.Spawn.Ghouls,
							this.Const.World.Spawn.LegendHexeLeader,
							this.Const.World.Spawn.LegendRockUnhold,
							this.Const.World.Spawn.LegendSkinGhouls,
							this.Const.World.Spawn.LegendWhiteDirewolf,
							this.Const.World.Spawn.LegendRedbackSpider,
							this.Const.World.Spawn.LegendDemonAlp,
							this.Const.World.Spawn.LegendStollwurm,
							this.Const.World.Spawn.LegendGreenwoodSchrat,
							this.Const.World.Spawn.SandGolems,
							this.Const.World.Spawn.Serpents,
							this.Const.World.Spawn.Hyenas,
							this.Const.World.Spawn.UndeadArmy,
							this.Const.World.Spawn.Vampires,
							this.Const.World.Spawn.Mummies,
							this.Const.World.Spawn.Zombies,
							this.Const.World.Spawn.Ghosts,
							this.Const.World.Spawn.Necromancer,
							this.Const.World.Spawn.BountyHunters,
							this.Const.World.Spawn.GreenskinHorde
						];
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), SpawnGroups[this.Math.rand(0, SpawnGroups.len() - 1)], true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "I\'d prefer to return to Artemisia.",
					function getResult( _event )
					{
						return "D2";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "J2",
			Text = "[img]gfx/ui/events/legend_tournament.png[/img]{The attendant is unphased by your decision and merely repeats %SPEECH_ON%Which enemy would you like to fight?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Greenskins",
					function getResult( _event )
					{
						return "K";
					}

				},
				{
					Text = "The Undead",
					function getResult( _event )
					{
						return "L";
					}

				},
				{
					Text = "Beasts",
					function getResult( _event )
					{
						return "M";
					}

				},
				{
					Text = "Humans",
					function getResult( _event )
					{
						return "N";
					}

				},
				{
					Text = "I\'d prefer to return to Artemisia",
					function getResult( _event )
					{
						return "D2";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "J3",
			Text = "[img]gfx/ui/events/legend_tournament.png[/img]{After the match you are led back to a small room, the attendant asks if you\'d like another Show Match or receive your reward.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let me pick",
					function getResult( _event )
					{
						return "K";
					}

				},
				{
					Text = "Just choose for me",
					function getResult( _event )
					{
						local SpawnGroups = [
							this.Const.World.Spawn.Noble,
							this.Const.World.Spawn.BanditBoss,
							this.Const.World.Spawn.Barbarians,
							this.Const.World.Spawn.Southern,
							this.Const.World.Spawn.NomadRaiders,
							this.Const.World.Spawn.Mercenaries,
							this.Const.World.Spawn.Militia,
							this.Const.World.Spawn.GoblinBoss,
							this.Const.World.Spawn.OrcBoss,
							this.Const.World.Spawn.Ghouls,
							this.Const.World.Spawn.LegendHexeLeader,
							this.Const.World.Spawn.LegendRockUnhold,
							this.Const.World.Spawn.LegendSkinGhouls,
							this.Const.World.Spawn.LegendWhiteDirewolf,
							this.Const.World.Spawn.LegendRedbackSpider,
							this.Const.World.Spawn.LegendDemonAlp,
							this.Const.World.Spawn.LegendStollwurm,
							this.Const.World.Spawn.LegendGreenwoodSchrat,
							this.Const.World.Spawn.SandGolems,
							this.Const.World.Spawn.Serpents,
							this.Const.World.Spawn.Hyenas,
							this.Const.World.Spawn.UndeadArmy,
							this.Const.World.Spawn.Vampires,
							this.Const.World.Spawn.Mummies,
							this.Const.World.Spawn.Zombies,
							this.Const.World.Spawn.Ghosts,
							this.Const.World.Spawn.Necromancer,
							this.Const.World.Spawn.BountyHunters,
							this.Const.World.Spawn.GreenskinHorde
						];
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), SpawnGroups[this.Math.rand(0, SpawnGroups.len() - 1)], true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "We\'re done here",
					function getResult( _event )
					{
						return "G2";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "K",
			Text = "[img]gfx/ui/events/legend_tournament.png[/img]{The attendant appears unmoved by your choice. %SPEECH_ON%Very good, any preference to the kind of Greenskins?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Goblins",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.GoblinBoss, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "Berserkers",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.BerserkersOnly, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "Warriors",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.OrcBoss, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "You decide, any will do",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.GreenskinHorde, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "On second thought, perhaps not Greenskins",
					function getResult( _event )
					{
						return "J2";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "L",
			Text = "[img]gfx/ui/events/legend_tournament.png[/img]{The attendant does not react to your ghoulish request. %SPEECH_ON%Very good, any preference to the kind of abomination?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Ancient Legions",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.UndeadArmy, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "Wiedergangers",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.Necromancer, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "The Embalmed",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.Mummies, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "You decide, any will do",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.UndeadScourge, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "Perhaps not the undead",
					function getResult( _event )
					{
						return "J2";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "M",
			Text = "[img]gfx/ui/events/legend_tournament.png[/img]{The attendant does not skip a beat. %SPEECH_ON%Very well, what kind of of beast?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "An unhold",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.LegendRockUnhold, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "A spider",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.LegendRedbackSpider, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "A wolf",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.LegendWhiteDirewolf, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "A wyrm",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.LegendStollwurm, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "You decide, any will do",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.LegendHexeLeader, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "Perhaps not a beast",
					function getResult( _event )
					{
						return "J2";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "N",
			Text = "[img]gfx/ui/events/legend_tournament.png[/img]{The attendant barely moves. %SPEECH_ON%Not a problem, any preference to which humans you fight?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Civilised folk",
					function getResult( _event )
					{
						return "O";
					}

				},
				{
					Text = "Outlaws",
					function getResult( _event )
					{
						return "P";
					}

				},
				{
					Text = "You decide",
					function getResult( _event )
					{
						local SpawnGroups = [
							this.Const.World.Spawn.Noble,
							this.Const.World.Spawn.Southern,
							this.Const.World.Spawn.Mercenaries,
							this.Const.World.Spawn.Militia,
							this.Const.World.Spawn.BountyHunters
						];
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), SpawnGroups[this.Math.rand(0, SpawnGroups.len() - 1)], true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "On second thought, perhaps something else",
					function getResult( _event )
					{
						return "J2";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "O",
			Text = "[img]gfx/ui/events/legend_tournament.png[/img]{The attendant barely moves %SPEECH_ON%Not a problem, any preference to which humans you fight?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A Noble House",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.Noble, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "A City State",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.Southern, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "Mercenaries",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.Mercenaries, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "Just choose for me",
					function getResult( _event )
					{
						local SpawnGroups = [
							this.Const.World.Spawn.Noble,
							this.Const.World.Spawn.Southern,
							this.Const.World.Spawn.Mercenaries,
							this.Const.World.Spawn.Militia,
							this.Const.World.Spawn.BountyHunters,
							this.Const.World.Spawn.BanditBoss,
							this.Const.World.Spawn.Barbarians,
							this.Const.World.Spawn.NomadDefenders
						];
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), SpawnGroups[this.Math.rand(0, SpawnGroups.len() - 1)], true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "On second thought, perhaps something else",
					function getResult( _event )
					{
						return "J2";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "P",
			Text = "[img]gfx/ui/events/legend_tournament.png[/img]{The attendant shifts slightly but says nothing. %SPEECH_ON%Not a problem, any preference to the kind of Outlaw?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A Bandit Gang",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.BanditBoss, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "A Barbarian Tribe",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.Barbarians, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "A Nomad Tribe",
					function getResult( _event )
					{
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), this.Const.World.Spawn.NomadDefenders, true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "Just choose for me",
					function getResult( _event )
					{
						local SpawnGroups = [
							this.Const.World.Spawn.BanditBoss,
							this.Const.World.Spawn.Barbarians,
							this.Const.World.Spawn.NomadDefenders
						];
						local p = _event.selectFight(_event.getReputationToDifficultyLightMult(), SpawnGroups[this.Math.rand(0, SpawnGroups.len() - 1)], true);
						_event.registerToShowAfterCombat("J3", "null");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "On second thought, perhaps something else",
					function getResult( _event )
					{
						return "J2";
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function selectFight( scale, type, lootingStopped )
	{
		local round = this.World.Flags.get("LegendTournamentRound");
		local roundDifficulty = 0.7 + round * 0.3;
		this.World.Flags.increment("LegendTournamentRound", 1);
		local p = this.Const.Tactical.CombatInfo.getClone();
		p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
		p.TerrainTemplate = "tactical.tournament";
		p.LocationTemplate.Template[0] = "tactical.legend_tournament_floor";
		p.CombatID = "Legend Tournament";
		local tracks = [
			this.Const.Music.OrcsTracks,
			this.Const.Music.NobleTracks,
			this.Const.Music.UndeadTracks,
			this.Const.Music.BanditTracks,
			this.Const.Music.CivilianTracks,
			this.Const.Music.BeastsTracks,
			this.Const.Music.GoblinsTracks,
			this.Const.Music.OrientalBanditTracks,
			this.Const.Music.OrientalCityStateTracks,
			this.Const.Music.BarbarianTracks,
			this.Const.Music.BattleTracks
		];
		p.Music = tracks[this.Math.rand(0, tracks.len() - 1)];
		p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Arena;
		p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Arena;
		p.IsUsingSetPlayers = false;
		p.IsFleeingProhibited = true;
		p.IsLootingProhibited = lootingStopped;
		p.IsWithoutAmbience = true;
		p.IsFogOfWarVisible = false;
		p.IsArenaMode = true;
		p.IsAutoAssigningBases = false;
		p.Players = [];
		p.Entities = [];
		this.Const.World.Common.addUnitsToCombat(p.Entities, type, this.Math.pow(scale, roundDifficulty), this.Const.Faction.Enemy);
		p.AfterDeploymentCallback = function ()
		{
			this.Tactical.getWeather().setAmbientLightingPreset(1);
			this.Tactical.getWeather().setAmbientLightingSaturation(1.1);
		};
		return p;
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
	}

	function onDetermineStartScreen()
	{
		this.World.Flags.set("LegendTournamentRound", 1);
		local candidate_veteran = [];

		foreach( bro in this.World.getPlayerRoster().getAll() )
		{
			if (bro.getSkills().hasTrait(::Legends.Trait.LegendArenaVeteran))
			{
				candidate_veteran.push(bro);
			}
		}

		//if (candidate_veteran.len() == 0)
		//{
		//	return "A";
		//}

		//this.m.Veteran = candidate_veteran[this.Math.rand(0, candidate_veteran.len() - 1)];

		//if (candidate_veteran.len() < 3)
		//{
		//	return "B";
		//}

		return "C";
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"veteran",
			this.m.Veteran != null ? this.m.Veteran.getNameOnly() : ""
		]);
	}

	function onClear()
	{
	}

});

