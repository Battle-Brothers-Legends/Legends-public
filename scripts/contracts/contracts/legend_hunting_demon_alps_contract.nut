this.legend_hunting_demon_alps_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		SpawnAtTime = 0.0,
		IsPlayerAttacking = false,
		MinStrength = 10, // player needs to earn 10% of bonus (not including base 5% bonus) for this contract to be valid
		Perk = ::Legends.Perk.LegendFavouredEnemyAlps,
		ValidTypes = this.Const.LegendMod.FavoriteAlps,
		LevelSumRequiredForRandomSpawn = 50,
		IsRandomlyAdded = null,
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.legend_hunting_demon_alps";
		this.m.Name = "Ending the Terror Demon (Legendary)";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DifficultyMult = this.Math.rand(145, 175) * 0.01;
		this.m.DescriptionTemplates = [
			"Alps are nightmares made flesh, yet they can be beaten. These reports though... sound downright demonic.",
			"Beware these souldrinkers, for they are cunning and elusive, wreathed in the flames of hell.",
			"Flamewalkers are creatures of darkness and despair, their very touch draining the life force from their victims.",
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
		this.m.Payment.Pool = 1300 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 10)
		{
			this.m.Payment.Completion = 0.9;
			this.m.Payment.Advance = 0.1;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		local names = [
			"demons",
			"dreameaters",
			"souldrinkers",
			"deathstalkers",
			"soulblights",
			"flamewalkers"
		];
		this.m.Flags.set("enemyName", names[this.Math.rand(0, names.len() - 1)]);
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"End the demons stalking " + this.Contract.m.Home.getName() + " at night"
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

				if (r <= 25)
				{
					this.Flags.set("IsGoodNightsSleep", true);
				}

				this.Contract.m.Home.setLastSpawnTimeToNow();
				this.Flags.set("StartTime", this.Time.getVirtualTimeF());
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
			}

			function update()
			{
				if (this.World.getTime().IsDaytime)
				{
					this.Contract.m.SpawnAtTime = 0.0;
				}
				else if (this.Contract.m.SpawnAtTime == 0.0 && !this.World.getTime().IsDaytime)
				{
					this.Contract.m.SpawnAtTime = this.Time.getVirtualTimeF() + this.Math.rand(8, 18);
				}

				if (this.Flags.get("IsVictory"))
				{
					this.Contract.setScreen("Victory");
					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
				else if (this.Contract.m.Target == null && !this.World.getTime().IsDaytime && this.Contract.isPlayerNear(this.Contract.m.Home, 600) && this.Contract.m.SpawnAtTime > 0.0 && this.Time.getVirtualTimeF() >= this.Contract.m.SpawnAtTime)
				{
					this.Flags.set("IsEncounterShown", true);
					this.Contract.setScreen("Encounter");
					this.World.Contracts.showActiveContract();
				}
				else if (!this.Flags.get("IsBanterShown") && this.World.getTime().IsDaytime && (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || this.Contract.m.Target.isHiddenToPlayer()) && this.Contract.isPlayerNear(this.Contract.m.Home, 600) && this.Time.getVirtualTimeF() - this.Flags.get("StartTime") >= 6.0 && this.Math.rand(1, 1000) <= 5)
				{
					this.Flags.set("IsBanterShown", true);
					this.Contract.setScreen("Banter");
					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "Alps")
				{
					this.Flags.set("IsVictory", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "Alps")
				{
					this.Contract.m.SpawnAtTime = -1.0;
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
					this.Contract.setScreen("Success");
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
			Text = "[img]gfx/ui/events/event_68.png[/img]{The height of %employer%\'s keep gives an impressive view of the surrounding country. From up here you could imagine yourself as lord of all you survey. Unfortunately, all you survey is not worth much. The people below you look haggard and sleep deprived. They shamble along like walking corpses, between burned out houses and blackened fields. A woman is howling in the distance, holding charred remains in a small blanket. %employer% joins you at the bannister and sighs heavily at the sight before you. He looks across the horizon for a time, like a stern man thinking through intense emotions. At last he speaks, a deep gruff voice in soft low tones. %SPEECH_ON%You look upon my father\'s lands. He carved this keep out of the raw earth, raised up a whole town for his kin. Then the night terrors came, in blood and fire they destroyed his dream. When he fought back, they destroyed him too.%SPEECH_OFF%The pain is obvious on %employer%\'s face, but he turns away from the thought and towards you with iron determination. %SPEECH_ON%So, dream hunter, your arrival here so soon after the demons must not be a coincidence. I suppose you must have tracked the terrors here, in search of coin no doubt? Well, you shall have it. %SPEECH_OFF% His huge hand slaps you on the shoulder and he smiles as if finding dark humour in the situation. %SPEECH_ON% The nightmares have taken so much from me already, it seems only fitting that the rest should be taken by a dream hunter. If you return with a demon head, I will empty my coffers to you.%SPEECH_OFF% }",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{How many crowns can you muster? | And how many coins are in that coffer? | What is the total? | How much is left?}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{This doesn\'t sound like mercenary work. | This doesn\'t sound like our kind of work. | That\'s not the kind of work we\'re looking for.}",
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
			Title = "Near %townname%...",
			Text = "[img]gfx/ui/events/event_71.png[/img]{As you walk past the smouldering ruins of a farmhouse, you notice a young teenage girl curled up in a burned out doorway. She stares into the middle distance, seemingly through you, not at you. %randombrother% walks up and asks if she knows where to find those that did this. The girl keeps looking through you, but speaks softly through cracked lips. %SPEECH_ON%You don\'t find them. They find you. There is no hiding. Every night they come, and every night they take someone. %SPEECH_OFF% %randombrother% asks if there is anything the girl needs, but she has gone silent and will say no more. | While you\'re checking your map and getting a lay of the land, %randombrother% comes up with a little girl at his side. She looks barely old enough to talk, and yet it clear she want\'s to tell you something. You bend down and she whispers in your ear.%SPEECH_ON%They mostly come at night, mostly.%SPEECH_OFF%. With that she turns and runs off into a burned out orchard, cackling with fiendish glee. }",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{Keep your eyes peeled. | We need to be ready for this. | Stay awake, people.}",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Encounter",
			Title = "Near %townname%...",
			Text = "[img]gfx/ui/events/legend_demonalp.png[/img]{%randombrother% hurriedly comes to your side.%SPEECH_ON%Something\'s moving just yonder.%SPEECH_OFF%You take your eyes to the perimeter of the patrol. Whatever it is, it\'s not moving so much as slipping over the ground. It looks like a bloody skinned deer pacing backwards and its eyes leave streams of jet black behind as though to etch horror itself over the earth. You tell the men to grab their weapons. | Assessing your map by a torchlight, you suddenly see a black shape bounding through the darkness. It is a mess of limbs cartwheeling over the earth, flailing forward with unseemly speed. It stalks as low as a snake, yet you hear the choking snarl of someone dying in their sleep. You order the men to arms. | A dark red shape stalks the rim of the company\'s patrol. It crouches in the tall grass and stares at the company. Finally, you walk forward and hold your arms out and close your eyes. Immediately, %randombrother% calls out.%SPEECH_ON%Sir get back! Sir, oh by the gods there are more!%SPEECH_OFF%You open your eyes and nod. Finally, they\'ve come.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Charge!",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "Alps";
						p.Entities = [];
						p.Music = this.Const.Music.BeastsTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.LegendDemonAlp, 200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Victory",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/legend_demonalp_dead.png[/img]{The monsters are slain. You take your sword and hack into one\'s neck. The blade cuts through with complete ease and the head lolls off into the grass. Its eyesockets are barren and concave. There\'s nothing inside, no flesh, no muscle. Whatever. You tell the men to get ready for a return march to %employer%. | The demons lay in the grass and though you know you saw them hurt, their flesh seems to have healed over and they seem more slain by your resilience than any weapon. You take your sword to saw a head off, only to find the blade slides right through the skin and the neckhole puckers closed. You stab the body a few times, twisting the blade to rend the flesh unmendable. Sinews slither briefly before coming to rest in the wound\'s hole. Not sure what to make of that, you shovel the head into a bag and tell the men ready a return to %employer%.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Payment awaits.",
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
			Text = "[img]gfx/ui/events/event_31.png[/img]{%employer% asks to see the demon\'s remains. You take it out of the bag. The flesh has deflated and you hold the head more like a scalp than a skull. %employer% reaches out to touch it and the demon skin twists away like fire made solid. He asks how they fought %SPEECH_ON% Like the brimstone of hell itself, I pray we need not see another so brutal %SPEECH_OFF%The man nods slowly.%SPEECH_ON% That is a prayer I can second. Well, I am a man of my word, my treasury is yours%SPEECH_OFF% | You dump the alp\'s head onto %employer%\'s desk. It flops over the wood until its maw rests wide, its emptied eyesockets drooping sadly at the world above. %employer% takes a fire iron and fishes around the skull before hanging its shapelessness in the air.%SPEECH_ON%What an awful thing this is. I should let you know that many folks came to me just hours ago stating they\'d visions of fields being bathed in a glorious light. Like they\'d dreamt the renewal of the world whole. So I don\'t know if every last one of these monsters is gone, but it seems %townname%\'s plight has been well taken care of. I\'ll see to it that you get your reward as promised.%SPEECH_OFF% | %employer% meets you in his room and laughs at the knapsack you\'ve brought. He shakes his head as he pours a drink.%SPEECH_ON%You need not show me that foul thing\'s face, sellsword. It visited me just hours ago, while I was sitting right there writing notes, an intrusion that was a dream, a sight of its death as though its spirit had been severed from mine and I was forced to see it go. And in its leaving I saw you standing there, sword in hand, victorious..%SPEECH_OFF%You nod and ask if you looked good. He laughs.%SPEECH_ON%You looked a slayer of worlds, certainly a slayer of that creature\'s world and, I must fear, perhaps a bit of mine as well. Stolen, permanently. Well, no matter, I as a man whole or a man sundered, I\'ve promised you a good pay and here it is.%SPEECH_OFF%}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Rid the town of unnatural nightmares");
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Saviour of the lands");

						if (this.Flags.get("IsGoodNightsSleep"))
						{
							return "GoodNightsSleep";
						}
						else
						{
							this.World.Contracts.finishActiveContract();
							return 0;
						}
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
			ID = "GoodNightsSleep",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_33.png[/img]{You wager the men have earned themselves a good rest and take a break in %townname%. The men spend the nap in slumbers so deep they might as well be dead. Awaking, the men stretch and yawn. Not a one has a dream or nightmare to speak of, the snooze but a brief touch of oblivion, and a much needed one at that.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I feel refreshed!",
					function getResult()
					{
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 75)
					{
						bro.improveMood(1.0, "Refreshed from having a great night\'s sleep");
						::Legends.Effects.remove(bro, ::Legends.Effect.Exhausted);
						::Legends.Effects.remove(bro, ::Legends.Effect.Drunk);
						::Legends.Effects.remove(bro, ::Legends.Effect.Hangover);

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Target.getTile())]
		]);
		_vars.push([
			"enemy",
			this.m.Flags.get("enemyName")
		]);
		_vars.push([
			"enemyC",
			this.m.Flags.get("enemyName").toupper()
		]);
	}

	function onHomeSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/terrifying_nightmares_situation"));
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
		this.m.Flags.set("SpawnAtTime", this.m.SpawnAtTime);
		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local target = _in.readU32();

		if (target != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
		}

		if (!this.m.Flags.has("StartTime"))
		{
			this.m.Flags.set("StartTime", 0);
		}
		this.m.IsRandomlyAdded = _in.readBool();
		this.contract.onDeserialize(_in);

		if (this.m.Flags.has("SpawnAtTime"))
		{
			this.m.SpawnAtTime = this.m.Flags.get("SpawnAtTime");
		}
	}

});
