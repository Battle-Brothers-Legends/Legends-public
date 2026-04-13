this.legend_spider_abductions_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		SpiderNestTile = null,
		PaymentModifier = 1,
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.legend_spider_abductions";
		this.m.Name = "Horror In The Woods";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DescriptionTemplates = [
			"Few things elicit such horror as the Webknechts, especially when they grow large enough to start abducting fully-grown townsfolk.",
			"Spider abductions is yet another nightmare come to life, with local reports of hapless victims ensnared in webs being dragged away into the darkness.",
			"Disturbing reports of people being seized in the night by eight-legged horrors are the talk of the town.",
			"For those who tread the forest paths, the threat of being ensnared in sticky silk and spirited away by arachnid fiends fills their waking hours with dread.",
			"Spider abduction is a grim fate that befalls those who wander too far from safety, their screams drowned out by the cacophony of chirping crickets and rustling leaves as they are dragged away.",
			"Those taken by the webspinners into the trees never return, for the forest holds secrets darker than night.",
		];
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		if (this.m.SpiderNestTile == null || this.m.SpiderNestTile.IsOccupied)
		{
			local playerTile = this.World.State.getPlayer().getTile();
			local excluded = ::Const.World.getAllTerrainTypesExcept([::Const.World.TerrainType.Forest, ::Const.World.TerrainType.LeaveForest, ::Const.World.TerrainType.AutumnForest]);
			this.m.SpiderNestTile = this.getTileToSpawnLocation(playerTile, 6, 12, excluded, false);
		}

		this.m.Payment.Pool = 550 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

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
				// TODO: intermediary steps to investigate site before finding the nest
				// TODO: Special scenarios: Redback / Spider Queen / Kobold Ambush
				this.Contract.m.BulletpointsObjectives = [
					"Find the Webknecht Nest where the abducted townsfolk from " + this.Contract.m.Home.getName() + " were taken to"
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
				if (this.Contract.m.SpiderNestTile == null || this.Contract.m.SpiderNestTile.IsOccupied)
				{
					local playerTile = this.World.State.getPlayer().getTile();
					local excluded = ::Const.World.getAllTerrainTypesExcept([::Const.World.TerrainType.Forest, ::Const.World.TerrainType.LeaveForest, ::Const.World.TerrainType.AutumnForest]);
					this.Contract.m.SpiderNestTile = this.Contract.getTileToSpawnLocation(playerTile, 6, 12, excluded, false);
				}

				// Setup Spider Nest
				local tile = this.Contract.m.SpiderNestTile;
				tile.clear();
				this.Contract.m.Destination = this.WeakTableRef(this.World.spawnLocation("scripts/entity/world/locations/legend_spider_nest_location", tile.Coords));
				this.Contract.m.Destination.onSpawned();
				this.Contract.m.Destination.setFaction(::World.FactionManager.getFactionOfType(::Const.FactionType.Beasts).getID());
				this.Contract.m.Destination.setBanner(this.World.FactionManager.getFaction(::Const.FactionType.Beasts).getPartyBanner());
				this.Contract.m.Destination.setDiscovered(true);
				::World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
				this.Contract.setScreen("Overview");
				::World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}
			}

			function update()
			{
				// if (!this.TempFlags.get("IsNestReached") && !this.TempFlags.get("IsNestEntered") && this.Contract.isPlayerAt(this.Contract.m.Destination))
				// {
				// 	this.TempFlags.set("IsNestReached", true);
				// 	this.Contract.setScreen("Nest1");
				// 	this.World.Contracts.showActiveContract();
				// }

				// TODO: Handle "successful retreat" (player rescued the townsfolk and retreated without destroying the nest)

				if (::MSU.isNull(this.Contract.m.Destination))
				{
					this.Contract.setScreen("NestDestroyed");
					::World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}

			}

			function onDestinationAttacked( _dest, _isPlayerAttacking = true )
			{
				// if (!this.Flags.get("IsAttackDialogTriggered"))
				// {
				// 	this.Flags.set("IsAttackDialogTriggered", true);
				// 	this.Contract.setScreen("Nest1");
				// 	::World.Contracts.showActiveContract();
				// }
				if (this.Flags.get("IsAttackingNest"))
				{
					local tile = this.Contract.m.Destination.getTile();
					local p = ::Const.Tactical.CombatInfo.getClone();
					p.Music = ::Const.Music.BeastsTracks;
					p.TerrainTemplate = ::Const.World.TerrainTacticalTemplate[tile.TacticalType];
					p.Tile = tile;
					p.CombatID = "SpiderNest";
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Custom;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;			//Was 80, but this proved to be almost three fold the difficulty expected. Decreased to 30 as a test on 6/3/24 - Luft
					::Const.World.Common.addUnitsToCombat(p.Entities, ::Const.World.Spawn.Spiders, 20 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), ::World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());

					// TODO: Balance the fight
					// Maybe also add another "ring" of eggs between the player and the surrounding spiders
					local onPlayerDeployment = function(_frontline)
					{
						// Chance for some of the player's units to start webbed
						foreach (unit in _frontline)
						{
							if (::Math.rand(1,6) == 1)
							{
								::Legends.Effects.grant(unit, ::Legends.Effect.LegendWebAtStart);
							}
						}

						local entities = [];
						local eggs = [];
						local abductees = ::Math.rand(3,6);
						this.Flags.set("NumAbductees", abductees);

						local freeSlots = ::Legends.S.getEmptySlotsInFormation();
						for (local i=0; i < abductees; i++) {
							local villager = ::World.getGuestRoster().create("scripts/entity/tactical/humans/envoy");
							villager.setName("Abducted Villager");
							villager.setFaction(1);
							villager.setPlaceInFormation(freeSlots.pop());
							::Legends.Effects.grant(villager, ::Legends.Effect.LegendWebAtStart);
							villager.getFlags().add("IsSpiderAbductee", true);
							entities.push(villager);
						}

						for (local i=0; i < ::Math.rand(4,6); i++)
						{
							local egg = {
								ID = ::Const.EntityType.SpiderEggs,
								Variant = 0,
								Script = "scripts/entity/tactical/enemies/spider_eggs",
								Faction = ::World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID(),
								Callback = this.onEggPlaced.bindenv(this)
							}
							eggs.push(egg);
						}

						entities.extend(_frontline);

						// spawn player units, abductees take priority as it may attempting to remove object
						::Tactical.Entities.placePlayersAtCenter(entities); // this is from the tactical_entity_manager

						// Spawn eggs in center
						::Tactical.Entities.spawnEntitiesAtCenter(eggs);

						// Spawn additional ring of eggs / decorations between center and circle of enemies
						local limit = ::Math.rand(20,30);
						local wc = ::MSU.Class.WeightedContainer([
							[3,"Egg"],
							[5,"CrushedEgg"],
							[2,"BrokenWeb"],
						]);
						for( local i=0; i < limit; i++ )
						{
							local x = 0, y = 0;
							local tries = 0, tile;

							while (1)
							{
								x = ::Math.rand(9, 23);
								y = ::Math.rand(9, 23);

								if (x > 13 && x < 19 && y > 13 && y < 19)
									continue;

								if (::Tactical.isValidTileSquare(x, y) && ::Tactical.getTileSquare(x, y).IsEmpty && !::Tactical.Entities.isTileIsolated(::Tactical.getTileSquare(x, y)))
								{
									tile = ::Tactical.getTileSquare(x, y);
									break;
								}

								if (++tries >= 500)
									break;
							}

							if (tile == null)
								continue;

							switch(wc.roll())
							{
								case "Egg":
									local egg = ::Tactical.spawnEntity("scripts/entity/tactical/enemies/spider_eggs", tile.Coords);
									egg.setFaction(::World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
									egg.setSpawnDelay(1);

									break;

								case "CrushedEgg":
									tile.spawnDetail("nest_01_dead", this.Const.Tactical.DetailFlag.Corpse, ::Math.rand(1,2) == 1);
									break;

								case "BrokenWeb":
									tile.spawnDetail("web_destroyed");
									break;

								default:
									break;
							}
						}
					}

					p.PlayerDeploymentWithFrontlineCallback = onPlayerDeployment.bindenv(this);
					::World.Contracts.startScriptedCombat(p, false, false, true);
				}
				else
				{
					this.Contract.setScreen("Nest1");
					::World.Contracts.showActiveContract();
				}
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (_actor.getFlags().has("IsSpiderAbductee") && _actor.getFlags().get("IsSpiderAbductee"))
				{
					this.World.getGuestRoster().remove(_actor);
				}
			}

			function onEggPlaced( _entity, _tag)
			{
				_entity.setSpawnDelay(1); // add a delay so that the eggs don't spawn hatchlings on the very first turn
			}

			function onRetreatedFromCombat( _combatID )
			{
				// if (_combatID == "SpiderNest")
				// {
				// 	this.Contract.setScreen("Retreat");
				// 	this.Contract.m.Destination.onFinish();
				// 	::World.Contracts.removeContract(this.Contract);
				// }
				if (_combatID == "SpiderNest")
				{
					// TODO: different outcomes depending on the number of survivors
					// this.Contract.m.Destination.onFinish();
					this.Contract.m.Destination.die();
					this.Contract.m.Destination = null;
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "SpiderNest")
				{
					// TODO: different outcomes depending on the number of survivors
					this.Contract.m.Destination.die();
					this.Contract.m.Destination = null;
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Return with the rescued townsfolk to " + this.Contract.m.Home.getName()
				];

				if (!::MSU.isNull(this.Contract.m.Destination))
				{
					this.Contract.m.Destination.getSprite("selection").Visible = false;
				}

				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					local survivorCount = 0;
					foreach ( g in ::World.getGuestRoster().getAll())
					{
						if ( g.getFlags().get("IsSpiderAbductee") )
						{
							survivorCount += 1
						}
					}

					if (survivorCount > 0)
					{
						this.Contract.setScreen("Success1");
					}
					else
					{
						this.Contract.setScreen("Failure1");
					}

					this.World.Contracts.showActiveContract();
				}
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (_actor.getFlags().has("IsSpiderAbductee") && _actor.getFlags().get("IsSpiderAbductee"))
				{
					this.World.getGuestRoster().remove(_actor);
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
			Title = "Horror In The Woods",
			Text = "[img]gfx/ui/events/event_62.png[/img]{You enter to find %employer% slumped down in their chair as if the world were crushing down on them. A small spider no bigger than half a crown begins to climb up their cup, only to be detected and sent flying, along with the cup, across the room. The cup bounces off a wall, spilling it\'s contents across the floor as the spider escapes, dazed yet unharmed, from the flood of wine now escaping from the vessel. %employer% locks their gaze with yours, refusing to move any other part of their body except their eyes. You ask about the contract, and are met with a hand wave followed by a grunt. A steward quickly steps in, with rehearsed practice and precision. %SPEECH_ON%You must forgive him, times have been tough with these nightmares scurrying about. I will keep this short for you - there is a nest somewhere nearby. Find it. Destroy it. Then bring anyone there back here ALIVE.%SPEECH_OFF% The steward made a special effort to draw attention to that last part, clearly after making the mistake of not doing so with a previous band of mercenaries... | A steward ushers you into a fine study, where a %employer% sits in an ornate chair facing a crackling fireplace. He doesn/'t seem to notice your arrival, apparently preoccupied with staring vacantly into the flames. You hesitate, unsure whether to approach or not. The steward realises your predicament and pointedly clears his throat. %SPEECH_ON%Ahem! The uhm, sellsword you asked for my Lord?%SPEECH_OFF% %employer% jolts out of his reverie and rises to his feet. As he approaches you recognise an emotion on his face you see far too often with the people you deal with, grief. %SPEECH_ON%A sellsword captain? Yes, yes of course. You are here to deal with the problem. Six... just six days ago sellsword, my precious Imelda was out practice riding her pony when she was taken by the web creatures. We... we never found her and apparently there have been others. Many, many others recently...%SPEECH_OFF% His voice cracks, and he suddenly grabs the front of your shirt. You reflexively reach for your absent sword, which a guard took from you before the meeting. %employer% seems not to notice. %SPEECH_ON%I knew! I knew they were a problem, sellsword! I ignored it... ignored it for far too long, so many other pressing problems you see. Now... this is my punishment.%SPEECH_OFF% A shadow passes over his face and he releases his grip on you. This is just as well as you were thinking of going for the hidden dagger in your boot. He turns away, idly running a hand through his hair to master his emotions. When he faces you once again his eyes and intent are firm. %SPEECH_ON%Find their nest. Burn it. Burn the whole forest for all I care if that\'s what it takes. Return any survivors you find and you will be handsomely rewarded.%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{Attacking a Webknecht nest is dangerous. This better pay well. | How much are their lives worth to you? | We will rescue them if the pay is right.}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{This isn\'t worth it. | This sounds far too dangerous.}",
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

		// At the Nest
		this.m.Screens.push({
			ID = "Nest1",
			Title = "At the Webknecht Nest...",
			Text = "[img]gfx/ui/events/event_110.png[/img]{You are drawn to the muffled screams and sobbing prayers of those trapped within the shimmering field of webs. The sticky blanket covering the area is occasionally broken by clusters of eggs and wrapped animals struggling all the same. You pause for a moment, assessing the scene. Aside from the captives, the area seems to be clear of anything with more than four legs.\n\n Now could be your chance...}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{Rush in!}",
					function getResult()
					{
						// this.TempFlags.set("IsNestEntered", true);
						return "Nest2";
					}

				},
				{

//For result, 'We'll come back later', how about turning it into a night battle, with 50% of victims already dead, and no large spiders?
//"You wait until nightfall, when the larger creatures are away hunting for prey. It seems quieter now, many of the victims seem to have expired during the day. Regrettable, but you reckon that if can still grab a few survivors and torch the nest you'll likely get paid the same regardless."
					Text = "{We\'ll come back later.}",
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
		// TODO: Different battle layouts depending on player choice
		this.m.Screens.push({
			ID = "Nest2",
			Title = "At the Webknecht Nest...",
			Text = "[img]gfx/ui/events/event_110.png[/img]{You give the signal and %companyname% start to grimly advance towards the trapped victims, wading through webs and eggs along the way, some getting caught in the webs themselves and jumping over the larger clusters of eggs.\n\n The whole nest reverberates like a silent lyre string. At first this is just your movement, but then something further away pulls a different chord. Once, twice then thrice the smaller, faster notes are plucked. With mounting dread you feel the notes being played from a different direction and quickly draw your weapon. They are all around you now, in silent communion with one another as an excited, frantic song is played.\n\n They know you are here.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{Defend the townsfolk! | To arms! | Prepare for battle!}",
					function getResult()
					{
						this.Flags.set("IsAttackingNest", true);
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			],
			function start()
			{
			}
		});


		this.m.Screens.push({
			ID = "Retreat",
			Title = "At the Webknecht Nest...",
			Text = "{%companyname% abandons the townsfolk to their doom.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{Better them than us.}",
					function getResult()
					{
						// TODO: clear guest roster of any rescued townsfolk
						return 0;
					}
				}
			],
			function start()
			{
			}
		});
		this.m.Screens.push({
			ID = "NestDestroyed",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_123.png[/img]{As the last little nightmare falls silent, there is a firm calmness over the battlefield. The broken and torn web covering the ground now gently breaks apart and spreads to the winds, succumbing to it\'s wounds the same way as it\'s creators have. A mixture of blood and poison pools under each sticky corpse as crows gather nearby for your departure.\n\n You order the %companyname% to clear out any remaining eggs in the nest, and prepare to bring the survivors back to %townname%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{Let\'s get these poor souls back to safety. | We\'ve seen enough here.}",
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

		// Return home
		// TODO: Different outcomes based on the number of survivors
		this.m.Screens.push({
			ID = "Success1",
			Title = "Upon your return...",
			Text = "[img]gfx/ui/events/event_43.png[/img]{The townsfolk of %townname% thank you and %employer% expresses no concern. They continue to pace up and down their chambers, dictating in muttered tones to a scribe about some other crisis. The steward pulls you to one side and hands you your payment. No words are exchanged.\n\n Today was one danger, tomorrow will yield another - either way, you can expect to be back here soon with more to say and more to kill.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{All in a day\'s work. | I hope to never see a spider again for the rest of my life.}",
					function getResult()
					{
						::World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						::World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						::World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Rescued townsfolk from Webknechts");
						::World.Contracts.finishActiveContract();
						return 0;
					}
				}
			],
			function start()
			{
				// Count survivors
				local survivorCount = 0;
				foreach ( g in ::World.getGuestRoster().getAll())
				{
					if ( g.getFlags().get("IsSpiderAbductee") )
					{
						survivorCount += 1
					}
				}

				this.List.push({
					id = 10,
					icon = "ui/icons/relations.png",
					text = format("You rescued %s out of %s Abducted Townsfolk", ::Const.UI.getColorized(survivorCount, survivorCount == 0 ? ::Const.UI.Color.NegativeEventValue : ::Const.UI.Color.PositiveEventValue), ::Const.UI.getColorized(this.Flags.get("NumAbductees"), ::Const.UI.Color.PositiveEventValue))
				});
				// TODO: scale reward based on the number of survivors who made it back?
				if (survivorCount == this.Flags.get("NumAbductees"))
				{
					this.Text += "{The townsfolk you rescued step forward.%SPEECH_ON%They saved all of us! We thought we were all done for, but they kept us safe.\"\n\n\"And not a single one of us was left behind either!\"\n\n\"All shall hear of the %companyname%!\"\n\n\"Hear, hear!%SPEECH_OFF%}";
					this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/legend_word_of_mouth_situation"), 5, this.Contract.m.Home, this.List);
				}
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + ::Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] Crowns"
				});
			}
		});

		this.m.Screens.push({
			ID = "Failure1",
			Title = "Upon your return...",
			Text = "[img]gfx/ui/events/event_43.png[/img]{%employer% greets you upon your return to %townname%. The hopeful look on %their_employer% face quickly turns concern when %they_employer% notices the lack of rescued townsfolk among the %companyname%.%SPEECH_ON%Where are the people who were abducted? You brought them back with you, yes?%SPEECH_OFF%%randombrother% shifts %their_randombrother% weight comfortably, notably avoiding all eye contact with %employer%.\n\nAs you begin to explain what happened, %employer% cuts you off with a wave of %their_employer% hand.%SPEECH_ON%We hired you to bring those poor folks back. Surely it is not too much to ask for you to have brought at least one person back safely?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{Next time you try clearing out a Webknecht nest yourself. | It\'s a dangerous world. | At least we made it back alive ourselves.}",
					function getResult()
					{
						::World.Assets.addMoney(::Math.round(this.Contract.m.Payment.getOnCompletion() * this.Contract.m.PaymentModifier));
						::World.Contracts.finishActiveContract();
						return 0;
					}
				}
			],
			function start()
			{
				if (::MSU.isNull(this.Contract.m.Destination))
				{
					this.Text += "\n\n{%employer% lets out a sigh.%SPEECH_ON%Fine, I shall pay half of the agreed payment for at least having destroyed the nest.%SPEECH_OFF%}";
					this.Contract.m.PaymentModifier = 0.5;
				}
				else
				{
					this.Text += "\n\n{After a brief moment of consideration, %employer% hands you a paltry sum of crowns.%SPEECH_ON%I don\'t think you deserve this at all, but having risked your lives for this, perhaps you should get something for the trouble%SPEECH_OFF%}";
					this.Contract.m.PaymentModifier = 0.1;
				}

				this.List.push({
					id = 10,
					icon = "ui/icons/relations.png",
					text = format("You rescued %s out of %s Abducted Townsfolk", ::Const.UI.getColorized(0, ::Const.UI.Color.NegativeEventValue), ::Const.UI.getColorized(this.Flags.get("NumAbductees"), ::Const.UI.Color.PositiveEventValue))
				});

				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + ::Const.UI.Color.PositiveEventValue + "]" + ::Math.round(this.Contract.m.Payment.getOnCompletion() * this.Contract.m.PaymentModifier) + "[/color] Crowns"
				});
			}
		});

	}

	function onPrepareVariables( _vars )
	{
		if (::MSU.isNull(this.m.Destination))
		{
			_vars.push([
				"direction",
				this.m.SpiderNestTile == null ? "" : ::Const.Strings.Direction8[::World.State.getPlayer().getTile().getDirection8To(this.m.SpiderNestTile)]
			]);
		}
		else
		{
			_vars.push([
				"direction",
				::MSU.isNull(this.m.Destination) ? "" : ::Const.Strings.Direction8[::World.State.getPlayer().getTile().getDirection8To(this.m.Destination.getTile())]
			]);
		}
	}

	function onHomeSet()
	{
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (!::MSU.isNull(this.m.Destination))
			{
				this.m.Destination.getSprite("selection").Visible = false;
			}

			this.m.Home.getSprite("selection").Visible = false;

			// Instead of calling getGuestRoster().clear(), only remove guest townsfolk for future compatibility with possible other guests
			local survivors = [];
			foreach ( g in ::World.getGuestRoster().getAll())
			{
				if ( g.getFlags().get("IsSpiderAbductee") )
				{
					survivors.push(g);
				}
			}
			if (survivors.len() > 0)
			{
				foreach(g in survivors)
				{
					::World.getGuestRoster().remove(g);
				}
			}
		}
	}

	function onIsValid()
	{
		return true;
	}

	function onSerialize( _out )
	{
		if (!::MSU.isNull(this.m.Destination))
		{
			_out.writeU32(this.m.Destination.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(::World.getEntityByID(destination));
		}

		this.contract.onDeserialize(_in);
	}

});
