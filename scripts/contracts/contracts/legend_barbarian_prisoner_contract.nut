this.legend_barbarian_prisoner_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Dude = null,
		Destination = null,
		Caravan = null,
		BarbCamp = null,
		BarbCampTile = null,
		BarbRetal = null,
		IsEscortUpdated = false,
		MinStrength = 10, // player needs to earn 10% of bonus (not including base 5% bonus) for this contract to be valid
		Perk = ::Legends.Perk.LegendFavouredEnemyBarbarian,
		ValidTypes = this.Const.LegendMod.FavoriteBarbarian,
		LevelSumRequiredForRandomSpawn = 50,
		IsRandomlyAdded = null,
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.legend_barbarian_prisoner";
		this.m.Name = "Facing Justice (Legendary)";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 120.0;
		this.m.MakeAllSpawnsAttackableByAIOnceDiscovered = true;
		this.m.DescriptionTemplates = [
			"A barbarian prisoner, shackled and guarded, awaits transport to face judgment. His kin will not this make this easy.",
			"Despite his captivity, the barbarian prisoner remains a formidable threat. Bulging muscles and furious eyes, not to mention the savage kin waiting to ambush you in the forest.",
			"Wrapped in thick chains, a hulking barbarian prisoner awaits transport. Nobody wants the job, for his savage kin are fiercely loyal and they will come for him."
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
		if (this.m.BarbCampTile == null || this.m.BarbCampTile.IsOccupied)
		{
			local playerTile = this.World.State.getPlayer().getTile();
			this.m.BarbCampTile = this.getTileToSpawnLocation(playerTile, 6, 12, [
				this.Const.World.TerrainType.Shore,
				this.Const.World.TerrainType.Ocean,
				this.Const.World.TerrainType.Mountains
			], false);
		}

		this.m.Flags.set("BarbCampName", "Reavers\'s Hold");
		this.m.Flags.set("Intercepted", false);
		this.contract.start();
	}

	function setup()
	{
		local settlements = this.World.EntityManager.getSettlements();
		local candidates = [];

		foreach( s in settlements )
		{
			if (s.getID() == this.m.Origin.getID())
			{
				continue;
			}

			if (!s.isDiscovered())
			{
				continue;
			}

			if (!s.isAlliedWith(this.getFaction()))
			{
				continue;
			}

			if (s.getSize() <= 2)
			{
				continue;
			}

			if (this.m.Origin.isIsolated() || s.isIsolated() || !this.m.Origin.isConnectedToByRoads(s) || this.m.Origin.isCoastal() && s.isCoastal())
			{
				continue;
			}

			local d = this.m.Origin.getTile().getDistanceTo(s.getTile());

			if (d <= 15 || d > 100)
			{
				continue;
			}

			local distance = this.getDistanceOnRoads(this.m.Origin.getTile(), s.getTile());
			local days = this.getDaysRequiredToTravel(distance, this.Const.World.MovementSettings.Speed * 0.6, true);

			if (days > 7 || distance < 15)
			{
				continue;
			}

			candidates.push(s);
		}

		if (candidates.len() == 0)
		{
			this.m.IsValid = false;
			return;
		}

		this.m.Destination = this.WeakTableRef(candidates[this.Math.rand(0, candidates.len() - 1)]);
		local distance = this.getDistanceOnRoads(this.m.Origin.getTile(), this.m.Destination.getTile());
		local days = this.getDaysRequiredToTravel(distance, this.Const.World.MovementSettings.Speed * 0.6, true);
		local modrate = this.World.State.getPlayer().getBarterMult();
		this.m.DifficultyMult = this.Math.rand(145, 175) * 0.01;
		this.m.Payment.Pool = this.Math.max(100, 3 * distance * (4 + modrate) * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult());
		this.m.Payment.Completion = 0.75;
		this.m.Payment.Advance = 0.25;
		this.m.Flags.set("Distance", distance);
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Escort prisoner to %objective% about %days% to the %direction%",
					"Provisions for the way are provided to your men"
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
				this.Contract.spawnCaravan();
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
				this.World.State.setCampingAllowed(false);

				if (this.Contract.m.BarbCampTile == null || this.Contract.m.BarbCampTile.IsOccupied)
				{
					local playerTile = this.World.State.getPlayer().getTile();
					this.Contract.m.BarbCampTile = this.Contract.getTileToSpawnLocation(playerTile, 6, 12, [
						this.Const.World.TerrainType.Shore,
						this.Const.World.TerrainType.Ocean,
						this.Const.World.TerrainType.Mountains
					], false);
				}

				local tile = this.Contract.m.BarbCampTile;
				tile.clear();
				this.Contract.m.BarbCamp = this.WeakTableRef(this.World.spawnLocation("scripts/entity/world/locations/barbarian_camp_location", tile.Coords));
				this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians).addSettlement(this.Contract.m.BarbCamp.get(), false);
				this.Contract.m.BarbCamp.setBanner("banner_wildmen_01");
				this.Contract.m.BarbCamp.getSprite("location_banner").Visible = true;
				this.Contract.m.BarbCamp.setName(this.Flags.get("BarbCampName"));
				this.Contract.m.BarbCamp.setDiscovered(false);
				this.Contract.m.BarbCamp.clearTroops();
				this.Contract.m.BarbCamp.getLoot().clear();
				this.Contract.addUnitsToEntity(this.Contract.m.BarbCamp, this.Const.World.Spawn.Barbarians, 200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.BarbCamp.setResources(this.Math.min(this.Contract.m.BarbCamp.getResources(), 200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
				this.Contract.m.BarbCamp.setLootScaleBasedOnResources(200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.BarbCamp.updateStrength();
				this.Contract.spawnEnemies();
				this.Contract.m.BarbCamp.getSprite("selection").Visible = false;
				this.Contract.m.BarbRetal.getSprite("selection").Visible = false;
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Escort prisoner to %objective% about %days% to the %direction%",
					"Provisions for the journey are provided to your mercenaries"
				];

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
				}

				this.World.State.setEscortedEntity(this.Contract.m.Caravan);
				this.World.Camp.onEscort(true);

				if (!this.World.State.isPaused())
				{
					this.World.setSpeedMult(this.Const.World.SpeedSettings.EscortMult);
				}

				this.World.State.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.EscortMult;
			}

			function update()
			{
				if (this.Contract.m.Caravan == null || this.Contract.m.Caravan.isNull() || !this.Contract.m.Caravan.isAlive() || this.Contract.m.Caravan.getTroops().len() == 0)
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (!this.Contract.m.IsEscortUpdated)
				{
					this.World.State.setEscortedEntity(this.Contract.m.Caravan);
					this.Contract.m.IsEscortUpdated = true;
				}

				this.World.State.setCampingAllowed(false);
				this.World.State.getPlayer().setPos(this.Contract.m.Caravan.getPos());
				this.World.State.getPlayer().setVisible(false);
				this.World.Assets.setUseProvisions(false);
				this.World.getCamera().moveTo(this.World.State.getPlayer());

				if (this.Flags.get("IsFleeing"))
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
					return;
				}
				else if (this.Contract.isPlayerAt(this.Contract.m.Destination))
				{
					this.Contract.setScreen("Success1");
					this.World.Contracts.showActiveContract();
				}

				local r = this.Math.rand(1, 100);

				if (this.Contract.m.BarbRetal == null || this.Contract.m.BarbRetal.isNull() || !this.Contract.m.BarbRetal.isAlive())
				{
					if (!this.Flags.get("Intercepted") && r <= 60)
					{
						this.Contract.setScreen("TheBattle");
						this.World.Contracts.showActiveContract();
						this.Flags.set("Intercepted", true);
					}
					else
					{
						return 0;
					}
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				this.Flags.set("IsFleeing", true);

				if (this.Contract.m.Caravan != null && !this.Contract.m.Caravan.isNull())
				{
					this.Contract.m.Caravan.die();
					this.Contract.m.Caravan = null;
				}

				this.start();
				this.World.State.getWorldScreen().updateContract(this.Contract);
			}

			function end()
			{
				this.World.State.setCampingAllowed(true);
				this.World.State.setEscortedEntity(null);
				this.World.State.getPlayer().setVisible(true);
				this.World.Assets.setUseProvisions(true);
				this.World.Camp.onEscort(false);

				if (!this.World.State.isPaused())
				{
					this.World.setSpeedMult(1.0);
				}

				this.World.State.m.LastWorldSpeedMult = 1.0;

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = false;
				}
			}

		});
		this.m.States.push({
			ID = "RealRetal",
			function start()
			{
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = false;
				}

				if (this.Contract.m.BarbCamp != null && !this.Contract.m.BarbCamp.isNull())
				{
					this.Contract.m.BarbCamp.getSprite("selection").Visible = true;
					this.Contract.m.BarbCamp.setDiscovered(true);
					this.World.uncoverFogOfWar(this.Contract.m.BarbCamp.getTile().Pos, 500.0);
				}

				this.Contract.m.BulletpointsObjectives = [
					"Destroy camp of prisoner\'s enemies"
				];
				this.World.State.setCampingAllowed(true);
				this.World.State.setEscortedEntity(null);
				this.World.State.getPlayer().setVisible(true);
				this.World.Assets.setUseProvisions(true);
				this.World.Camp.onEscort(false);

				if (this.Contract.m.Caravan != null && !this.Contract.m.Caravan.isNull() && this.Contract.m.Caravan.isAlive())
				{
					this.Contract.m.Caravan.die();
					this.Contract.m.Caravan = null;
				}

				if (!this.World.State.isPaused())
				{
					this.World.setSpeedMult(1.0);
				}

				this.World.State.m.LastWorldSpeedMult = 1.0;
			}

			function update()
			{
				if (this.Contract.m.BarbCamp == null || this.Contract.m.BarbCamp.isNull())
				{
					this.Contract.setScreen("Success2");
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
			Text = "[img]gfx/ui/events/event_100.png[/img] {%employer%\'s crosses his arms and purses his lips.%SPEECH_ON%Ordinarily I wouldn\'t ask some sellswords to guard a caravan, but my usual crew is a little out of it - sickness, drunkenness, licentiousness... I think you understand. What\'s important is that I have important cargo going to %objective% about %days% to the %direction% and I need someone watching it... someone specialized in that sort of \'cargo\'. I\'ve heard your particular company has \'individuals\' that are skilled in handling savages. The mountain of muscles in my dungeon is the most wanted bastard in %objective%. Rumor is they killed a whole patrol with their bare hands...but come, let\'s not dwell on those grisly details. Are you interested or not?%SPEECH_OFF% }",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{Let\'s talk money. | How many crowns are we talking about? | What does it pay?}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{Not interested. | This is not the kind of work we\'re looking for.}",
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
			ID = "Success1",
			Title = "At %objective%",
			Text = "[img]gfx/ui/events/event_65.png[/img] {You\'ve made it, having delivered the prison cart just as you promised %employer% you would. The caravan leader claims the reward for the criminal you delivered, and quickly hands over most of it. The sight of a monstrous savage beast finally in chains causes noticeable joy and relief to the local populace of %objective%. You wonder whether to stay around for a while to enjoy the show scheduled for tomorrow, but the common folk across streets have already started celebrating. Either way the job is done, the reward is paid and you can move out at any time.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Crowns well deserved.",
					function getResult()
					{
						local money = this.Contract.m.Payment.getOnCompletion();
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(money);
						local xp = money * 0.50;
						local playerRoster = this.World.getPlayerRoster().getAll();

						foreach( bro in playerRoster )
						{
							bro.addXP(xp);
							bro.updateLevel();
						}

						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Protected a prisoner wagon as promised");
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				local money = this.Contract.m.Payment.getOnCompletion();
				local xpGained = this.Math.round(money * 0.5 * this.Const.Combat.GlobalXPMult);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] Crowns."
				});
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/public_executions_situation"), 2, this.Contract.m.Destination, this.List);
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/local_holiday_situation"), 2, this.Contract.m.Destination, this.List);
			}

		});
		this.m.Screens.push({
			ID = "TheBattle",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_145.png[/img] {This battle was more bloody than the usual skirmishes your men are involved in. %randombrother% looks over wounded companions. %randombrother2% inspects the prison cart to ensure the recent encounter left it in a decent condition to resume the journey, then approaches you. %SPEECH_ON%These barbarians were serious business, cap - that big brute we have in custody must be someone important. Maybe… I don\'t know boss… but maybe let\'s see what the prisoner has to say? This might be their king or some kind of famed warrior! Who cares about %employer%\'s opinion on the matter? We got paid already and I don\'t think we\'ll find any more crowns waiting for us in %objective%.%SPEECH_OFF% }",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "No. Execution is only solution to the crimes of this savage! (Increase Moral Reputation)",
					function getResult()
					{
						this.World.Assets.addMoralReputation(5);
						return 0;
					}

				},
				{
					Text = "Good idea. Let\'s speak with the prisoner. (Decrease Moral Reputation)",
					function getResult()
					{
						this.World.Assets.addMoralReputation(-3);
						return "ThePrisoner";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ThePrisoner",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_139.png[/img] {Those of the company who are still strong enough to fight gather around the wagon. %randombrother% holds a weapon tight, ready to strike if need be. As you approach, the presence of the half naked northerner grows more and more menacing. What is left of %employer%\'s men are upset about this but after the recent battle they aren\'t looking for another fight. Finally the prisoner speaks. %SPEECH_ON%HAHA!! That was an impressive brawl! I didn\'t expect you\'d manage to kill them all. A few, maybe, but here I thought I\'d have to deal with the bulk of them myself, and I nary lifted a finger! Ha!%SPEECH_OFF%Seeing the surprise on your face, the barbarian raises an eyebrow and explains.%SPEECH_ON%You look surprised. Did you think those curs were here to rescue me? No, those were my enemies - and I assure you, there are more of them, and deadlier ones too. Still, killing these warriors was proof you\'re not just a bunch of milk drinking rabble like these so-called \'nobles\'.%SPEECH_OFF%The barbarian pauses, spits, eyes your for a moment longer. They continue.%SPEECH_ON%I have a score to settle with the chieftain of Reaver\'s Hold. Kill the guards. Free me. Take me there. It will be a worthy battle against real warriors, not some piddling skirmish surrounded by a bunch of fops in fancy armor. The chieftain is my kill, but the rest are fair game. You do that, and I\'d consider it an honor to join your band. What say you?%SPEECH_OFF% }",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "Back to the cage! (Increase Moral Reputation)",
					function getResult()
					{
						this.World.Assets.addMoralReputation(2);
						return 0;
					}

				},
				{
					Text = "Very well, you have a deal. (Decrease Moral Reputation)",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "Failed to protect a prisoner wagon");
						this.World.Assets.addMoralReputation(-5);
						this.Contract.setState("RealRetal");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "Retreat...",
			Text = "[img]gfx/ui/events/event_60.png[/img] {The prison cart is opened. There is no sight of the prisoner anywhere. You failed.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "Darn it!",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "Failed to protect a prisoner wagon");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success2",
			Title = "After the battle",
			Text = "[img]gfx/ui/events/event_145.png[/img] {The battle was hard fought, but you prevailed. Your mercenaries finish all those who have not reached the afterlife yet. As the plundering begins, the barbarian who convinced you to betray %employer% emerges victorious from the chieftain\'s hut, carrying a helmet with a bloody head still inside it. A fancy helm - too fancy for ordinary barbarians. The warrior tosses the gruesome trophy to your feet. The helm slips off and rolls aside, leaving the bloody stump facing up at you. From the wound you can tell the head was not cut off with a weapon, but ripped off by hand.%SPEECH_ON%I am done here. I hope I can count on you to find better challenges for me than this.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [],
			function start()
			{
				this.Options.push({
					Text = "We can\'t hire you.",
					function getResult()
					{
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				});

				if (this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
				{
					this.Options.push({
						Text = "You better be worth it.",
						function getResult()
						{
							local bros = this.World.getPlayerRoster().getAll();
							local candidates = [];

							foreach( bro in bros )
							{
								if (bro.getBackground().getID() == "background.legend_berserker" || bro.getBackground().getID() == "background.legend_commander_berserker")
								{
									candidates.push(bro);
								}
							}

							if (candidates.len() == 0)
							{
								this.Flags.set("BerkFree", true);
							}
							else
							{
								this.Flags.set("BerkFree", false);
							}

							return "Hired";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Hired",
			Title = "After the battle",
			Text = "[img]gfx/ui/events/event_139.png[/img]An outstanding capacity for violence is well-suited to a mercenary band. You agree to take the freed prisoner on.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Welcome to the company.",
					function getResult()
					{
						this.World.getPlayerRoster().add(this.Contract.m.Dude);
						this.World.getTemporaryRoster().clear();
						this.Contract.m.Dude.onHired();
						this.Contract.m.Dude = null;
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				local roster = this.World.getTemporaryRoster();
				this.Contract.m.Dude = roster.create("scripts/entity/tactical/player");

				if (this.Flags.get("BerkFree"))
				{
					this.Contract.m.Dude.setStartValuesEx([
						"legend_berserker_background"
					]);
					this.Contract.m.Dude.setTitle("the Beast");
					this.Contract.m.Dude.getBackground().m.RawDescription = "%name% was \'saved\' by you from execution. You decided that this killing machine is a worthy acquisition, ignoring the fact it is also the most wanted criminal in the north.";
					this.Contract.m.Dude.getBackground().buildDescription(true);
				}
				else
				{
					this.Contract.m.Dude.setStartValuesEx([
						"barbarian_background"
					]);
					this.Contract.m.Dude.setTitle("the Barbarian");
					this.Contract.m.Dude.getBackground().m.RawDescription = "%name% was \'saved\' by you from a death sentence. Recruiting this savage barbarian has put you in bad terms with the nobles of the north.";
					this.Contract.m.Dude.getBackground().buildDescription(true);
				}

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
				}

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
				}

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
				}

				this.Characters.push(this.Contract.m.Dude.getImagePath());
			}

		});
	}

	function spawnEnemies() {
		local party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians).spawnEntity(this.m.BarbCamp.getTile(), "Barbarian Retaliation", false, this.Const.World.Spawn.Barbarians, 200 * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		party.getSprite("banner").setBrush(this.m.BarbCamp.getBanner());
		party.setAttackableByAI(false);
		this.m.BarbRetal = this.WeakTableRef(party);
		local c = party.getController();
		local intercept = this.new("scripts/ai/world/orders/intercept_order");
		intercept.setTarget(this.World.State.getPlayer());
		c.addOrder(intercept);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(true);
		party.setDescription("These savages would like to have their buddy back.");
		party.setMovementSpeed(this.Const.World.MovementSettings.Speed * 1.4);
		party.getLoot().Money = this.Math.rand(150, 500);
		party.getLoot().ArmorParts = this.Math.rand(0, 20);
		party.getLoot().Medicine = this.Math.rand(0, 10);
		party.getLoot().Ammo = this.Math.rand(0, 15);
		return party;
	}

	function spawnCaravan()
	{
		local faction = this.World.FactionManager.getFaction(this.getFaction());
		local party = faction.spawnEntity(this.m.Home.getTile(), "Escort Caravan", false, this.Const.World.Spawn.Caravan, this.m.Home.getResources() * 0.8, this.getMinibossModifier());
		party.getSprite("banner").Visible = false;
		party.getSprite("base").Visible = false;
		party.setMirrored(true);
		party.setDescription("A prison cart from " + this.m.Home.getName() + " that is transporting a dangerous barbarian.");
		party.setMovementSpeed(this.Const.World.MovementSettings.Speed * 0.6);
		party.setLeaveFootprints(false);
		party.getLoot().Money = this.Math.rand(0, 400);
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(this.m.Destination.getTile());
		move.setRoadsOnly(true);
		local unload = this.new("scripts/ai/world/orders/unload_order");
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		local wait = this.new("scripts/ai/world/orders/wait_order");
		wait.setTime(4.0);
		c.addOrder(move);
		c.addOrder(unload);
		c.addOrder(wait);
		c.addOrder(despawn);
		this.m.Caravan = this.WeakTableRef(party);
		return party;
	}

	function onPrepareVariables( _vars )
	{
		local days = this.getDaysRequiredToTravel(this.m.Flags.get("Distance"), this.Const.World.MovementSettings.Speed * 0.6, true);
		_vars.push([
			"objective",
			this.m.Destination == null || this.m.Destination.isNull() ? "" : this.m.Destination.getName()
		]);
		_vars.push([
			"direction",
			this.m.Destination == null || this.m.Destination.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Destination.getTile())]
		]);
		_vars.push([
			"days",
			days <= 1 ? "a day" : days + " days"
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			this.World.State.setCampingAllowed(true);
			this.World.State.setEscortedEntity(null);
			this.World.State.getPlayer().setVisible(true);
			this.World.Assets.setUseProvisions(true);

			if (!this.World.State.isPaused())
			{
				this.World.setSpeedMult(1.0);
			}

			this.World.State.m.LastWorldSpeedMult = 1.0;

			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
			}
		}

		if (this.m.Caravan != null && !this.m.Caravan.isNull() && this.m.Caravan.isAlive())
		{
			this.m.Caravan.die();
			this.m.Caravan = null;
		}

		if (this.m.BarbRetal != null && !this.m.BarbRetal.isNull() && this.m.BarbRetal.isAlive())
		{
			this.m.BarbRetal.die();
			this.m.BarbRetal = null;
		}

		if (this.m.BarbCamp != null && !this.m.BarbCamp.isNull() && this.m.BarbCamp.isAlive())
		{
			this.m.BarbCamp.die();
			this.m.BarbCamp = null;
		}
	}

	function onIsValid()
	{
		if (this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isAlive() || !this.m.Destination.isAlliedWith(this.getFaction()))
		{
			return false;
		}

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

	function onIsTileUsed( _tile )
	{
		if (this.m.Destination != null && !this.m.Destination.isNull() && _tile.ID == this.m.Destination.getTile().ID)
		{
			return true;
		}

		return false;
	}

	function onSerialize( _out )
	{
		if (this.m.Destination != null && !this.m.Destination.isNull())
		{
			_out.writeU32(this.m.Destination.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		if (this.m.BarbCamp != null && !this.m.BarbCamp.isNull())
		{
			_out.writeU32(this.m.BarbCamp.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		if (this.m.BarbRetal != null && !this.m.BarbRetal.isNull())
		{
			_out.writeU32(this.m.BarbRetal.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		if (this.m.Caravan != null && !this.m.Caravan.isNull())
		{
			_out.writeU32(this.m.Caravan.getID());
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
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}

		local camp = _in.readU32();

		if (camp != 0)
		{
			this.m.BarbCamp = this.WeakTableRef(this.World.getEntityByID(camp));
		}

		local party = _in.readU32();

		if (party != 0)
		{
			this.m.BarbRetal = this.WeakTableRef(this.World.getEntityByID(party));
		}

		local caravan = _in.readU32();

		if (caravan != 0)
		{
			this.m.Caravan = this.WeakTableRef(this.World.getEntityByID(caravan));
		}

		if (!this.m.Flags.has("Distance"))
		{
			this.m.Flags.set("Distance", 0);
		}

		this.m.IsRandomlyAdded = _in.readBool();
		this.contract.onDeserialize(_in);
	}

});
