this.legend_camp_nomads_raid_caravan_contract <- this.inherit("scripts/contracts/legend_camp_contract", {
	m = {
		Target = null,
		LastCombatTime = 0.0
	},
	function setEnemyCityState( _h )
	{
		this.m.Flags.set("EnemyCityState", _h.getID());
	}

	function create()
	{
		this.legend_camp_contract.create();
		this.m.Type = "contract.legend_camp_nomads_raid_caravan";
		this.m.Name = "Intercept City State Supplies";
		this.m.EmployerFaction = ::Legends.CampContracts.EmployerFaction.Bandits;  
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DescriptionTemplates = [
			"A group of Bandits has contacted us about a southern trade caravan.",
			"A trade caravan is coming from the south, lightly protected and high in value.",
		];
		this.m.Payment.ItemPool = [
			[50, "misc/legend_enemy_skill_book_item"],
			[50, "misc/legend_class_skill_book_item"],
			[50, "misc/legend_weapon_skill_book_item"],
			[50, "misc/legend_trait_skill_book_item"]
		];
	}

	function start()
	{
		this.m.Payment.Pool = 100 * this.getPaymentMult() * this.getDifficultyMult() * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.9;
			this.m.Payment.Advance = 0.1;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		local myTile = this.World.State.getPlayer().getTile();
		local enemyFaction = this.World.FactionManager.getFaction(this.m.Flags.get("EnemyCityState"));
		local settlements = enemyFaction.getSettlements();
		local lowest_distance = 99999;
		local highest_distance = 0;
		local best_start;
		local best_dest;

		foreach( s in settlements )
		{
			if (s.isIsolated())
			{
				continue;
			}

			local d = s.getTile().getDistanceTo(myTile);

			if (d < lowest_distance)
			{
				lowest_distance = d;
				best_dest = s;
			}

			if (d > highest_distance)
			{
				highest_distance = d;
				best_start = s;
			}
		}

		this.m.Flags.set("InterceptStart", best_start.getID());
		this.m.Flags.set("InterceptDest", best_dest.getID());
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Raid the caravan going from %start% to %dest%",
					"Return to %townname%"
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
				this.Flags.set("Survivors", 0);

				if (r <= 10)
				{
					this.Flags.set("IsBribe", true);
					this.Flags.set("Bribe1", this.Contract.beautifyNumber(this.Contract.m.Payment.Pool * (this.Math.rand(70, 150) * 0.01)));
					this.Flags.set("Bribe2", this.Contract.beautifyNumber(this.Contract.m.Payment.Pool * (this.Math.rand(70, 150) * 0.01)));
				}
				else if (r <= 15)
				{
					if (this.Contract.getDifficultyMult() >= 1.0)
					{
						this.Flags.set("IsMortar", true);
					}
				}
				else if (r <= 20)
				{
					if (this.Contract.getDifficultyMult() >= 1.0)
					{
						this.Flags.set("IsAssassinSurprise", true);
					}
				}
				else if (r <= 25)
				{
					this.Flags.set("IsSurvivingSlaves", true);
				}

				local enemyFaction = this.World.FactionManager.getFaction(this.Flags.get("EnemyCityState"));
				local best_start = this.World.getEntityByID(this.Flags.get("InterceptStart"));
				local best_dest = this.World.getEntityByID(this.Flags.get("InterceptDest"));
				local party = enemyFaction.spawnEntity(best_start.getTile(), "Caravan", false, this.Const.World.Spawn.CaravanSouthernEscort, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getMinibossModifier());
				party.getSprite("base").Visible = false;
				party.getSprite("banner").setBrush(enemyFaction.getBannerSmall());
				party.setMirrored(true);
				party.setVisibleInFogOfWar(true);
				party.setImportant(true);
				party.setDiscovered(true);
				party.setDescription("A southern caravan with armed escorts transporting something worth protecting between settlements.");
				party.setFootprintType(this.Const.World.FootprintsType.Caravan);
				party.getFlags().set("IsCaravan", true);
				party.setAttackableByAI(false);
				party.getFlags().add("ContractCaravan");
				this.Contract.m.Target = this.WeakTableRef(party);
				this.Contract.m.UnitsSpawned.push(party);
				party.getLoot().Money = this.Math.rand(100, 150);
				party.getLoot().ArmorParts = this.Math.rand(5, 20);
				party.getLoot().Medicine = this.Math.rand(5, 8);
				party.getLoot().Ammo = this.Math.rand(0, 40);
				local r = this.Math.rand(1, 6);

				if (r == 1)
				{
					party.addToInventory("supplies/rice_item");
				}
				else if (r == 2)
				{
					party.addToInventory("weapons/oriental/firelance");
				}
				else if (r == 3)
				{
					party.addToInventory("weapons/oriental/handgonne");
				}
				else if (r == 4)
				{
					party.addToInventory("tools/fire_bomb_item");
				}
				else if (r == 5)
				{
					party.addToInventory("tools/smoke_bomb_item");
				}

				local c = party.getController();
				c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				local move = this.new("scripts/ai/world/orders/move_order");
				move.setDestination(best_dest.getTile());
				move.setRoadsOnly(true);
				local despawn = this.new("scripts/ai/world/orders/despawn_order");
				c.addOrder(move);
				c.addOrder(despawn);
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
					this.Contract.m.Target.setVisibleInFogOfWar(true);
				}
			}

			function update()
			{
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull())
				{
					if (this.Flags.get("IsSurvivingSlaves"))
					{
						this.Contract.setScreen("SurvivingSlaves1");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setState("Return");
					}
				}
				else if (this.Contract.isEntityAt(this.Contract.m.Target, this.World.getEntityByID(this.Flags.get("InterceptDest"))))
				{
					this.Contract.setScreen("Failure3");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Contract.isPlayerAt(this.Contract.m.Target))
				{
					this.onTargetAttacked(this.Contract.m.Target, false);
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (!this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);

					if (this.Flags.get("IsBribe"))
					{
						this.Contract.setScreen("Bribe1");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsMortar"))
					{
						this.Contract.setScreen("Mortar");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsAssassinSurprise"))
					{
						this.Contract.setScreen("AssassinSurprise");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.onTargetAttacked(_dest, true);
					}
				}
				else if (this.Time.getVirtualTimeF() >= this.Contract.m.LastCombatTime + 5.0)
				{
					local enemyFaction = this.World.FactionManager.getFaction(this.Flags.get("EnemyCityState"));
					enemyFaction.setIsTemporaryEnemy(true);
					this.Contract.m.LastCombatTime = this.Time.getVirtualTimeF();
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}

			function onActorRetreated( _actor, _combatID )
			{
				if (!_actor.isNonCombatant() && _actor.getFaction() == this.Flags.get("EnemyCityState") && this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("Survivors", this.Flags.get("Survivors") + 1);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				this.Contract.m.LastCombatTime = this.Time.getVirtualTimeF();
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Wait for your 'allies' to contact you."
				];
			}

			function update()
			{
				if (this.Flags.get("Survivors") == 0)
				{
					this.Contract.setScreen("Success1");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Math.rand(1, 100) > this.Flags.get("Survivors") * 15)
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					this.Contract.setScreen("Failure2");
					this.World.Contracts.showActiveContract();
				}
			}
		});
	}

	function createScreens()
	{
		this.importScreens(::Const.Contracts.NegotiationItemsOnly());
		this.importScreens(this.Const.Contracts.Overview);
		this.m.Screens.push({ // \' —
			ID = "Task",
			Title = "Negotiations",
			Text = "[img]gfx/ui/events/event_63.png[/img]{You thumb through the letter passed to you. It has coiled in the heat and attached to an arrow that was, until recently, languishing near your latrine.%SPEECH_ON%I have seen you and your work, my men are most impressed with how you fight and how strong your grudge is with the cities in the south. I have recently come into information which may be useful to you...%SPEECH_OFF%You thumb faster through the pages, which steadily get to the point. You start at the beginning again and pick out the key information admist the flattery and meandering. \n\nIn short — the writer pretends to be someone they are not, and is most likely a crownling with an axe to grind from a late payment, or more likely a well-written brigand with other motives. You match the information against what you know already, and find there is indeed a large mysterious caravan leaving a city state in the south bound for elsewhere. There is a great and consistant emphasis on not leaving a soul alive. \n\nRegardless of intentions, you could work with this, and think about sending a message back...}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{What\'s in it for us? | Let\'s talk pay.}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{We can\'t trust these people. | I don\'t think so.}",
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
			ID = "Bribe1", // \' — 
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_158.png[/img]{You rapidly close in on the caravan. However, an officer confidently strolls to your party — helmet cradled in their left arm at rest and their right hand lazily on the pommel of their sword. They motion to their belt and produce a large pouch of coins.%SPEECH_ON%Bandits, yes?%SPEECH_OFF%He studies you quickly, and holds the pouch more aloft.%SPEECH_ON%Let\'s just skip the killing, shall we? I have a very unmodest sum for my soldiers behind me, but if you let us pass you are more than welcome to it. I can deal with their complaining later. It is a long journey after all.%SPEECH_OFF%The man cracks a wry smile. He knows this has worked countless times before, and no doubt keeps a pouch of coains on reserve for these very moments. \n\nStill, is this man more trustworthy than the stranger in your letter?}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{So be it. Hand over the crowns. | A fair offer, we\'ll take it.}",
					function getResult()
					{
						return "Bribe2";
					}

				},
				{
					Text = "You took my land, now we\'ll take your lives!",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Bribe2", // \' — 
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_158.png[/img]{As you bein the leave, the officer turns heel and comes back to you. At first you sense a trap, but he speaks before you can consider your options.%SPEECH_ON%Tell, me, how did you find us? Not many know of this caravan, fewers till would dare to think of attacking it.%SPEECH_OFF%His tongue stops wagging, and moves around in his mouth as he considers how much he is risking.%SPEECH_ON%Tell me who told you about this. Names, or ortherwise. I will keep it to my grave and gie you something extra for your troubles...%SPEECH_OFF%The man has paid you once, how much is your honour worth anyway?}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{Hand over the crowns, then. | Very well, not that it makes a difference at this point.}",
					function getResult()
					{
						return "Bribe3";
					}

				},
				{
					Text = "I won\'t betray our reputation like this, we\'ll be leaving.",
					function getResult()
					{
						return "Bribe4";
					}

				}
			],
			function start()
			{
				this.World.Assets.addMoney(this.Flags.get("Bribe1"));
				this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail * 2);
				this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Flags.get("Bribe1") + "[/color] Crowns"
				});
			}

		});
		this.m.Screens.push({
			ID = "Bribe3", // \' — 
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_04.png[/img]{You take the extra crowns. In the back of your mind you can hear your ancestors getting more tumoltious by the second. You hand over the letter you orginally received and the officer leafs through the pages.%SPEECH_ON%Ah, %employer%. This makes more sense now. May the path be clear to you.%SPEECH_OFF%With that, he turns heel a second time and sits at the front of the caravan. The conscripts keep a close eye on you as they pass.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Payment without having to kill anyone. I can get used to that.",
					function getResult()
					{
						this.World.Contracts.removeContract(this.Contract);
						return 0;
					}

				}
			],
			function start()
			{
				this.World.Assets.addMoney(this.Flags.get("Bribe2"));
				this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail * 2);
				this.World.FactionManager.getFaction(this.Contract.getFaction()).getFlags().set("Betrayed", true);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Flags.get("Bribe2") + "[/color] Crowns"
				});
			}

		});
		this.m.Screens.push({
			ID = "Bribe4", // \' — 
			Title = "As you approach...", 
			Text = "[img]gfx/ui/events/event_158.png[/img]{You spit a sidewards curse at the man and he takes a half-pace backwards. He silently leaves you be as the caravan rolls past.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We\'re moving out!",
					function getResult()
					{
						this.World.Contracts.removeContract(this.Contract);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Mortar", // \' — 
			Title = "As you approach...", 
			Text = "[img]gfx/ui/events/event_177.png[/img]{You approach the caravan at great speed, with your warriors moving fast and low. The silence is broken when %randombrother% points to the middle of the caravan. You know that shape below the cloth draped over the wagon. With a grand unveiling, two engineers dismount and pull the canvas clear of the cart in a well practiced, drilled motiion. \n\nThe swine have a mortar, and the shells to use it!}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "To Arms!",
					function getResult()
					{
						this.Const.World.Common.addTroop(this.Contract.m.Target, 
						{
							Type = this.Const.World.Spawn.Troops.Mortar
							Type = this.Const.World.Spawn.Troops.Engineer
							Type = this.Const.World.Spawn.Troops.Engineer
						}, 
						true, this.Contract.getDifficultyMult() >= 1.1 ? 5 : 0);
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "AssassinSurprise", // \' — 
			Title = "As you approach...", 
			Text = "[img]gfx/ui/events/event_165.png[/img]{Ordering the assault, your fighters launch themselves at the caravan. They stop dead as an assassin materialises from behind one of the wagons.%SPEECH_ON%Your path ends here, interloper!%SPEECH_OFF}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "To Arms!",
					function getResult()
					{
						this.Const.World.Common.addTroop(this.Contract.m.Target, 
						{
							Type = this.Const.World.Spawn.Troops.Assassin
							Type = this.Const.World.Spawn.Troops.Assassin
							Type = this.Const.World.Spawn.Troops.Assassin
						}, 
						true, this.Contract.getDifficultyMult() >= 1.1 ? 5 : 0);
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SurvivingSlaves1", // \' — 
			Title = "After the battle...", 
			Text = "[img]gfx/ui/events/event_166.png[/img]{As your tribe picks over the battlefield, you quickly realise something you strangely missed before — about two dozen sunburnt and whipped slaves are following the wagons. They are chained to one another and witnessed the battle. %randombrother% laughs nervously, and really asks if you are about to do this. The letter said no survivors, but the odds that every one of these slaves never speaks of this again is impossible...}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We\'re paid to leave no one alive, so that\'s what we\'ll do.",
					function getResult()
					{
						this.World.Assets.addMoralReputation(-20);
						return "SurvivingSlaves2";
					}

				},
				{
					Text = "To hell with it - let them leave.",
					function getResult()
					{
						this.World.Assets.addMoralReputation(5);
						this.Flags.set("Survivors", this.Flags.get("Survivors") + 3);
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SurvivingSlaves2", // \' — 
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_168.png[/img]{The task is, mercifully, quick. The only kindess in all of this is you cannot tell the sonscripts from the slaves on the battlefield. Hopefully nobody else will either.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Well, it\'s not a pretty job, but that\'s what we\'re being paid for.",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1", // \' — 
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_04.png[/img]{You write back to %employer% with news of your success. A letter soon follows the same day, this time by courier and payment. The courier seems none the wiser as to what happened here. You feel a sense of envy.}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "Destroyed a caravan");
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
			ID = "Failure1", // \' — 
			Title = "On your return...", //to do
			Text = "[img]gfx/ui/events/event_45.png[/img]{You sit down to write a letter to %employer% of the news, only to find one already in your tent. You open it and read the first few lines and it coveyed what you had expected. You burn the letter, there has been enough disapointment today.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Could have been worse...",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion() / 2);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "Failed to destroy a caravan without letting anyone escape");
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
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() / 2 + "[/color] Crowns"
				});
			}

		});
		this.m.Screens.push({
			ID = "Failure2", // \' — 
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_45.png[/img]{You sit down to write a letter to %employer% of the news, only to find one already in your tent. You open it and read the first few lines and it coveyed what you had expected. You burn the letter, there has been enough disapointment today.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Damn this contract!",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "Failed to destroy a caravan without letting anyone escape");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Failure3", // \' — 
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_167.png[/img]{Awaiting the caravan, a pair of travelers come up from where the convoy should be going. They remark in detail about a cart which is no doubt the one which you were supposed to be hunting down. No point in returning to %employer%. | Word on the road hints that the caravan you were supposed to be hunting down has given you the slip and reached its destination. The company shouldn\'t bother reaching %employer%.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "It was too good to be true anyway...",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "Failed to destroy a caravan");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"bribe",
			this.m.Flags.get("Bribe1")
		]);
		_vars.push([
			"bribe2",
			this.m.Flags.get("Bribe2")
		]);
		_vars.push([
			"start",
			this.World.getEntityByID(this.m.Flags.get("InterceptStart")).getName()
		]);
		_vars.push([
			"dest",
			this.World.getEntityByID(this.m.Flags.get("InterceptDest")).getName()
		]);
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
	}

	function onIsValid()
	{
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

