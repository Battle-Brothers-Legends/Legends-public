this.legend_hunting_rock_unholds_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		Dude = null,
		IsPlayerAttacking = true,
		MinStrength = 10, // player needs to earn 10% of bonus (not including base 5% bonus) for this contract to be valid
		Perk = ::Legends.Perk.LegendFavouredEnemyUnhold,
		ValidTypes = this.Const.LegendMod.FavoriteUnhold,
		LevelSumRequiredForRandomSpawn = 50,
		IsRandomlyAdded = null,
	},
	function setEnemyType( _t )
	{
		this.m.Flags.set("EnemyType", _t);
	}

	function create()
	{
		this.contract.create();
		this.m.Type = "contract.legend_hunting_rock_unholds";
		this.m.Name = "Hunting a Mountain (Legendary)";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DifficultyMult = this.Math.rand(145, 175) * 0.01;
		this.m.DescriptionTemplates = [
			"Blundering mountains of hatred and rage are devastating the area. These are the largest Unholds you have ever seen.",
			"Colossal footsteps shake the earth. Buildings have been shattered, the very landscape torn apart by primal fury.",
			"Rampaging unholds have left a trail of devastation for miles. You can hear their thunderous roars from here.",
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
		this.m.Payment.Pool = 1500 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 10)
		{
			this.m.Payment.Completion = 0.9;
			this.m.Payment.Advance = 0.1;
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
					"Hunt down the Rock Unholds around " + this.Contract.m.Home.getName()
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

				if (r <= 20)
				{
					this.Flags.set("IsDriveOff", true);
				}
				else if (r <= 70)
				{
					this.Flags.set("IsSignsOfAFight", true);
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
					if (this.Flags.get("IsSignsOfAFight"))
					{
						this.Contract.setScreen("SignsOfAFight");
					}
					else
					{
						this.Contract.setScreen("Victory");
					}

					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
				else if (!this.Flags.get("IsBanterShown") && this.Contract.m.Target.isHiddenToPlayer() && this.Math.rand(1, 1000) <= 1 && this.Flags.get("StartTime") + 10.0 <= this.Time.getVirtualTimeF())
				{
					this.Flags.set("IsBanterShown", true);
					this.Contract.setScreen("Banter");
					this.World.Contracts.showActiveContract();
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (this.Flags.get("IsDriveOff") && !this.Flags.get("IsEncounterShown"))
				{
					this.Flags.set("IsEncounterShown", true);
					local bros = this.World.getPlayerRoster().getAll();
					local candidates = [];

					foreach( bro in bros )
					{
						if (bro.getBackground().getID() == "background.beast_slayer" || bro.getBackground().getID() == "background.wildman" || bro.getBackground().getID() == "background.barbarian" || bro.getSkills().hasTrait(::Legends.Trait.Dumb))
						{
							candidates.push(bro);
						}
					}

					if (candidates.len() == 0)
					{
						this.World.Contracts.showCombatDialog(_isPlayerAttacking);
					}
					else
					{
						this.Contract.m.Dude = candidates[this.Math.rand(0, candidates.len() - 1)];
						this.Contract.setScreen("DriveThemOff");
						this.World.Contracts.showActiveContract();
					}
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
					if (this.Flags.get("IsDriveOffSuccess"))
					{
						this.Contract.setScreen("SuccessPeaceful");
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
			Text = "[img]gfx/ui/events/event_31.png[/img]{When you enter %employer%\'s keep he runs out to greet you, he looks wracked with fear. He has clearly run too fast for his fat lungs and has to catch his breath before burbling out a slew of words.%SPEECH_ON%Thank the gods you came! The mountains have come alive! I have seen it, boulders the size of a house stirring up from their slumber, standing tall like a man and then crushing a horse in a single blow.%SPEECH_OFF% He throws you a huge lump of bluish crystalline rock, %employer% continues on %SPEECH_ON%My best men chopped this off the giant, that stone you hold is its flesh. The beast is so armored that most weapons glance right off. It took four men with axes to carve that tiny chunk off, and as soon as they had finished, the rock grew right back. The beast barely noticed we were there, it crushed three men in a single blow. We fled, and we know not where it hides now. Search the surrounding lands, it is slow and huge, so it should not be hard to track. My tracker tells me you specialise in hunting unholds, so undoubtedly you already have poison with you to stop the creature regenerating. Even so, this beast may be impossible to kill, worse than a dozen unholds. If you do manage to kill a mountain, I will reward you like a king.%SPEECH_OFF% }",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{Fighting mountain giants won\'t come cheap. | The %companyname% can help for the right price. | Let\'s talk crowns.}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{This doesn\'t sound like our kind of work. | This won\'t be worth the risk.}",
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
			Text = "[img]gfx/ui/events/event_71.png[/img]{%randombrother% returns from scouting, he has a harrowed look of a man who has passed by death. %SPEECH_ON%I climbed a hill to survey the landscape, couldn\'t see it in any direction. Then the earth shook something powerful, I was thrown off my feet and slid down the side of the hill, landing in a bush. When I looked back up, the hill was gone and it was walking away.%SPEECH_OFF%.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "It can\'t have gotten far.",
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
			Text = "[img]gfx/ui/events/legend_rock_unhold.png[/img]{The mountain unhold is bent over, it looks for all the world like the rubble of a collapsed castle. Large boulders piled together, with plants growing from between the joins. The rocks shudder and move, grinding together in a horrific low screech. The low pile turns to face you, then stands to its full height, towering above you. It is gnawing on half a cow, and as it sees you approach it burbles a chortle, spraying rancid ichor all over you.}",
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
			ID = "DriveThemOff",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/legend_rock_unhold.png[/img]{As you put the men into formation, %shouter% goes running by you and right toward the unholds. He\'s hooting and hollering, his arms flailing like a sea cretin drawn up by the hook. The unholds pause and stare amongst one another. You\'re not sure whether this should be allowed to continue...}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Attack them!",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				},
				{
					Text = "%shouter% knows what he\'s doing.",
					function getResult()
					{
						if (this.Math.rand(1, 100) <= 5)
						{
							return "DriveThemOffSuccess";
						}
						else
						{
							return "DriveThemOffFailure";
						}
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "DriveThemOffSuccess",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/legend_rock_unhold.png[/img]{Against your better judgment, you let %shouter% go. He doesn\'t stop for nothing, like he was chasing down a throng of beautiful women undressing just for him. Shockingly, the unholds take a step back. They start to retreat one by one until only a lone giant remains.\n\n%shouter% runs up to its feet like a yapping dog and lets forth some atavistic scream so hoarsely made that you wonder if every ancestor of the earth buried or otherwise had heard it. The unhold slings an arm before its face as though to shield it, then starts stepping back, further and further until it\'s gone! They\'re all gone!}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "And don\'t come back!",
					function getResult()
					{
						this.Contract.m.Target.die();
						this.Contract.m.Target = null;
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Dude.getImagePath());
				this.Contract.m.Dude.improveMood(3.0, "Managed to drive off unholds all by himself");
				this.Contract.m.Dude.addXP(1000, false);

				if (this.Contract.m.Dude.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[this.Contract.m.Dude.getMoodState()],
						text = this.Contract.m.Dude.getName() + this.Const.MoodStateEvent[this.Contract.m.Dude.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "DriveThemOffFailure",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/legend_rock_unhold.png[/img]{Against your better judgment, you let %shouter% go. He doesn\'t stop for nothing, like he was chasing down a throng of beautiful women undressing just for him. Shockingly, the unholds take a step back. They start to retreat one by one until only a lone giant remains.\n\n%shouter% runs up to its feet like a yapping dog and lets forth some atavistic scream so hoarsely made that you wonder if every ancestor of the earth buried or otherwise had heard it. The unhold slings an arm before its face and then throws it down and swats %shouter% away. The man goes cartwheeling through the air and his screams go with him like a rabbit stolen up by a hawk. His shouts somersault back to earth in an echo of dizzying whoops and he lands with a hardy thud. The giant jiggles with an earthen chuckle. It\'s amusement catches the attention of the departed unholds who all turn around and start to return.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "So much for that.",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, false);
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Dude.getImagePath());
				local injury1;
				local injury2;

				if (this.Math.rand(1, 100) <= 90)
				{
					injury1 = this.Contract.m.Dude.addInjury(this.Const.Injury.BluntBody);
					injury2 = this.Contract.m.Dude.addInjury(this.Const.Injury.BluntBody);
				}
				else
				{
					injury1 = this.Contract.m.Dude.addInjury(this.Const.Injury.BluntBody);
					injury2 = this.Contract.m.Dude.addInjury(this.Const.Injury.BluntHead);
				}

				this.List.push({
					id = 10,
					icon = injury2.getIcon(),
					text = this.Contract.m.Dude.getName() + " suffers " + injury1.getNameOnly() + " and " + injury2.getNameOnly()
				});
				this.Contract.m.Dude.worsenMood(1.0, "Failed to drive off unholds all by himself");

				if (this.Contract.m.Dude.getMoodState() <= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[this.Contract.m.Dude.getMoodState()],
						text = this.Contract.m.Dude.getName() + this.Const.MoodStateEvent[this.Contract.m.Dude.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Victory",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_113.png[/img]{The giant lays broken, rocks and shattered crystals strewn across the ground. You order the men to begin hacking apart the body, you have big plans for these remains.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Time to get paid.",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SignsOfAFight",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_113.png[/img]{With the giants slain, you get the men ready for a return to %employer%, but %randombrother% fetches your attention with a bit of quiver in his throat. You head on over to see him standing before one of the felled unholds. He points across its flesh which has been torn asunder in slices and hangs like the ears of a corn stalk. The damage is far beyond the ability of your own weaponry. The sellsword turns and looks past you with his eyes widening.%SPEECH_ON%What do you imagine did that?%SPEECH_OFF%Further along the skin are concave scars shaped like saucers with punctures rent right into the holes. You climb atop the unhold and crank your sword into one of these divots, wrenching free a tooth about the length of your forearm. Along its edges are barbs, teeth upon teeth it seems. The men see this and start muttering amongst themselves and you wished you\'d never saw it at all for you\'ve no sense to make of it.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "The wilds are dark and full of terrors.",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Success",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%employer% seems surprised when you return. %SPEECH_ON%If you have come back to ask for men to help, you are on your own. I already sent my best off to die, you will have to make do with what you have.%SPEECH_OFF%  You show him the remains of the giant and his eyes grow wide  %SPEECH_ON%How...  How did you?  Never mind, there will be songs written to tell the tale I am sure. For now let us feast, you have freed my lands of this horror and earned your reward.%SPEECH_OFF%  He gestures to his servants who cheer as one, then begin tending to your wounds, bringing over drinks, food, and a small chest full of crowns. }",
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
						this.World.Assets.getStash().add(this.new("scripts/items/supplies/mead_item"));
						this.World.Assets.getStash().add(this.new("scripts/items/supplies/cured_venison_item"));
						this.World.Assets.getStash().add(this.new("scripts/items/supplies/medicine_item"));
						this.World.Assets.getStash().add(this.new("scripts/items/loot/ancient_gold_coins_item"));
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Rid the town of rock unholds");
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Saviour of the lands");
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
			ID = "SuccessPeaceful",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_79.png[/img]{%employer% drives his fingers up to the corners of his eye then fans them forward.%SPEECH_ON%Let me get this straight, one of your sellswords shouted the giants into a retreat?%SPEECH_OFF%You nod and tell him the direction they went which is, rather importantly, away from %townname%. The mayor leans back in his chair.%SPEECH_ON%Well. Alright then. I guess it ain\'t my problem now. Dead or gone, all the same I suppose.%SPEECH_OFF%He hands you a satchel, but holds his hand on it a moment.%SPEECH_ON%You know if you\'re lying and they come back I\'ll send every messenger bird I got to speak of your honor.%SPEECH_OFF%You stand up, draw your sword, and tell him they\'ll have his skull to rest in when they get there. The man nods and lets the coin go.%SPEECH_ON%No bother, sellsword, only business.%SPEECH_OFF%}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Rid the town of unholds");
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
	}

	function spawnEnemies() {
		local playerTile = this.World.State.getPlayer().getTile();
		local tile = this.getTileToSpawnLocation(playerTile, 6, 12, [
			this.Const.World.TerrainType.Mountains
		]);
		local nearTile = this.getTileToSpawnLocation(playerTile, 4, 8);
		local party;
		party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Unholds", false, this.Const.World.Spawn.LegendRockUnhold, 200 * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		party.setDescription("One or more lumbering giants.");
		party.setAttackableByAI(false);
		party.setFootprintSizeOverride(0.85);
		party.getFlags().set("IsUnholds", true);
		this.Const.World.Common.addFootprintsFromTo(nearTile, party.getTile(), this.Const.BeastFootprints, 0.85);
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
		roam.setTerrain(this.Const.World.TerrainType.Forest, false);
		roam.setTerrain(this.Const.World.TerrainType.LeaveForest, false);
		roam.setTerrain(this.Const.World.TerrainType.SnowyForest, false);
		roam.setTerrain(this.Const.World.TerrainType.AutumnForest, false);
		c.addOrder(roam);
		return party;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"shouter",
			this.m.Dude != null ? this.m.Dude.getName() : ""
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
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/unhold_attacks_situation"));
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
