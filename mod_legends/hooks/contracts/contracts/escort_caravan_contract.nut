::mods_hookExactClass("contracts/contracts/escort_caravan_contract", function(o)
{
	o.onHomeSet <- function ()
	{
		if (this.m.Home.isSouthern())
		{
			this.m.DescriptionTemplates = [
				"Among the desert caravans, fortunes rise and fall just like the shifting sands.",
				"Among the desert caravans, diversity thrives as cultures blend along the trade routes.",
				"Quicksand pits lie hidden beneath the sands, swallowing whole caravans with no hope of escape.",
				"Scorching heat drains the strength of travelers, leaving them vulnerable to attacks from desert beasts.",
				"Savage tribes of desert nomads like to raid passing caravans, taking both goods and lives.",
				"Sandstorms can engulf the desert, sometimes swallowing caravans whole and leaving no trace behind.",
				"Mirages deceive travelers, leading them astray and into the clutches of desert predators.",
				"They say dark magic seeps from ancient tombs buried in the desert, making the roads unsafe.",
				"Ancient ruins dot the desert landscape, ideal ambush locations for unwary caravans.",
				"Life among the desert merchants is a dance of trade and negotiation, where every stop is a chance for profit and danger.",
				"Accompanied by a formidable escort, this wealthy merchant/'s travels will be safeguarded.",
			];
			return;
		}

		this.m.DescriptionTemplates = [
			"The roads these days are dangerous. Merchants are willing to pay good coin for sellsword protection.",
			"Ensure the safe passage of the caravan, profit from your service.",
			"Amidst the merchant caravan, camaraderie is forged over shared travels and shared burdens.",
			"In the merchant caravan, goods are traded and stories exchanged under the open sky.",
			"Fat merchants are willing to pay good coin to ensure their safety on the roads.",
			"In these fell times, guarding a caravan is a constant watch for danger.",
			"The roads are infested with monstrous beasts and men, making travel perilous.",
			"Mysterious disappearances plague the roads, leaving many a merchant to fear for their lives.",
			"Corrupt officials often extort merchants, demanding tolls or else facing dire consequences.",
			"Dark forests border the roads, where malicious creatures often ambush passing caravans.",
			"Wildmen sightings have made the roads perilous, with merchants falling victim to their savage ambushes.",
			"Giant spiders sometimes spin their webs across the roads, trapping unwary caravans in their deadly snares.",
			"Wolves, dire bears and other beasts prowl the forests, preying on travelers.",
			"Guarding a caravan means standing firm against bandits and beasts, as well as knowing when to abandon your employer to save yourself.",
			"Our well-armed escort will protect this weasel-faced merchant as he travels perilous roads.",
			"With stout defenders by her side, this rotund merchant can venture forth unscathed.",
			"Ensure the safety of this portly merchant and his wares on the road for a tiny cut of his profits.",
			"Surrounded by vigilant guards, this plump merchant will be able to move more confidently along the road.",
			"Our dedicated warriors will shield this rotund merchant from any threats on the way. In theory anyway.",
		];
	}

	o.setup = function ()
	{
		local settlements = this.World.EntityManager.getSettlements();
		local candidates = [];

		foreach( s in settlements )
		{
			if (s.getID() == this.m.Origin.getID())
			{
				continue;
			}

			if (!s.isAlliedWith(this.getFaction()))
			{
				continue;
			}

			if (this.m.Origin.isIsolated() || s.isIsolated() || !this.m.Origin.isConnectedToByRoads(s) || this.m.Origin.isCoastal() && s.isCoastal())
			{
				continue;
			}

			local d = this.m.Origin.getTile().getDistanceTo(s.getTile());

			if (d <= 12 || d > 100)
			{
				continue;
			}

			local distance = this.getDistanceOnRoads(this.m.Origin.getTile(), s.getTile());
			local days = this.getDaysRequiredToTravel(distance, this.Const.World.MovementSettings.Speed * 0.6, true);

			if (days > 7 || distance < 15)
			{
				continue;
			}

			if (this.World.getTime().Days <= 10 && days > 4)
			{
				continue;
			}

			if (this.World.getTime().Days <= 5 && days > 2)
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
		local modrate = 10 * this.World.State.getPlayer().getBarterMult();


		if (days >= 5)
		{
			this.m.DifficultyMult = this.Math.rand(115, 135) * 0.01;
		}
		else if (days >= 2)
		{
			this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
		}
		else
		{
			this.m.DifficultyMult = this.Math.rand(70, 85) * 0.01;
		}

		this.m.Payment.Pool = this.Math.max(150, distance * (4 + modrate) * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult());
		local r = this.Math.rand(1, 3);

		//	local modBonus = distance * modrate * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
		//	this.Contract.m.BulletpointsObjectives.push("You gain + " modBonus " crowns due to your bartering skills");


		if (r == 1)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else if (r == 2)
		{
			this.m.Payment.Count = 0.25;
			this.m.Payment.Completion = 0.75;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		local maximumHeads = [
			15,
			20,
			25,
			30
		];
		this.m.Payment.MaxCount = maximumHeads[this.Math.rand(0, maximumHeads.len() - 1)];
		this.m.Flags.set("HeadsCollected", 0);
		this.m.Flags.set("Distance", distance);
	}

	local createStates = o.createStates;
	o.createStates = function()
	{
		createStates();
		foreach (s in this.m.States)
		{
			if (s.ID == "Offer")
			{
				local end = s.end;
				s.end <- function ()
				{
					end();
					this.World.State.setCampingAllowed(true);
				}
			}
			if (s.ID == "Running")
			{
				local start = s.start;
				s.start <- function ()
				{
					start();
					this.World.Camp.onEscort(true);

					if (!this.World.State.isPaused())
					{
						this.World.setSpeedMult(this.Const.World.SpeedSettings.EscortMult);
					}

					this.World.State.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.EscortMult;
				}

				s.update <- function ()
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

					this.World.State.setCampingAllowed(true);
					this.World.State.getPlayer().setPos(this.Contract.m.Caravan.getPos());
					this.World.State.getPlayer().setVisible(false);
					this.World.Assets.setUseProvisions(false);
					this.World.getCamera().moveTo(this.World.State.getPlayer());
					//this.World.Camp.update(null);

					if (this.Flags.get("IsFleeing"))
					{
						this.Contract.setScreen("Failure1");
						this.World.Contracts.showActiveContract();
						return;
					}
					else if (this.Contract.isPlayerAt(this.Contract.m.Destination))
					{
						if (this.Flags.get("IsCaravanHalfDestroyed"))
						{
							this.Contract.setScreen("Success2");
						}
						else
						{
							this.Contract.setScreen("Success1");
						}

						this.World.Contracts.showActiveContract();
					}
					else if (!this.Flags.get("IsEnoughCombat"))
					{
						if (this.Contract.spawnEnemies())
						{
							this.Flags.set("IsEnoughCombat", true);
						}
					}
					else
					{
						local parties = this.World.getAllEntitiesAtPos(this.World.State.getPlayer().getPos(), 400.0);
						local numParties = 0;

						foreach( party in parties )
						{
							numParties = ++numParties;
						}

						if (numParties > 2)
						{
							return;
						}

						if (this.Flags.get("IsStolenGoods") && this.World.State.getPlayer().getTile().HasRoad)
						{
							if (!this.TempFlags.get("IsStolenGoodsDialogTriggered") && this.Contract.getDistanceToNearestSettlement() >= 6 && this.Math.rand(1, 1000) <= 1)
							{
								this.TempFlags.set("IsStolenGoodsDialogTriggered", true);
								this.Contract.setScreen("StolenGoods1");
								this.World.Contracts.showActiveContract();
							}
						}
						else if (this.Flags.get("IsVampires") && !this.World.getTime().IsDaytime)
						{
							if (!this.TempFlags.get("IsVampiresDialogTriggered") && this.Contract.getDistanceToNearestSettlement() >= 6 && this.Math.rand(1, 1000) <= 2)
							{
								this.TempFlags.set("IsVampiresDialogTriggered", true);
								this.Contract.setScreen("Vampires1");
								this.World.Contracts.showActiveContract();
							}
						}
						else if (this.Flags.get("IsValuableCargo"))
						{
							if (!this.TempFlags.get("IsValuableCargoDialogTriggered") && this.Contract.getDistanceToNearestSettlement() >= 6 && this.Math.rand(1, 1000) <= 1)
							{
								this.TempFlags.set("IsValuableCargoDialogTriggered", true);
								this.Contract.setScreen("ValuableCargo1");
								this.World.Contracts.showActiveContract();
							}
						}
						else if (this.Flags.get("IsPrisoner"))
						{
							if (!this.TempFlags.get("IsPrisonerDialogTriggered") && this.Contract.getDistanceToNearestSettlement() >= 6 && this.Math.rand(1, 1000) <= 1)
							{
								this.TempFlags.set("IsPrisonerDialogTriggered", true);
								this.Contract.setScreen("Prisoner1");
								this.World.Contracts.showActiveContract();
							}
						}
					}
				}

				s.end <- function ()
				{
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

						this.Contract.clearSpawnedUnits();
					}
				}
			}
		}
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "TaskSouthern")
			{
				s.Text = "[img]gfx/ui/events/event_98.png[/img]{Nested in towers and aviaries, bells and birds alike echo in the air like the rattled voluntaries of a caged city. Beneath the noise, in the dull marbled halls of a palace, you find %employer% ordering the death of a servant. The offense is unknown to you, not that it bothers the Vizier in the slightest as he approaches you with a smile and clean hands.%SPEECH_ON%A number of councilmen are sending goods to %objective%, a good %days% to the %direction%. These goods must arrive in a shape that is passable to the awaiting merchants. I believe a Crownling such as yourself can see to this task, yes?%SPEECH_OFF% | You find a few of the councilmen and aldermen of %employer%, the resident Vizier. They approach you with a document stamped with his emblem.%SPEECH_ON%We shall soon be off to %objective% with a caravan of goods. The city guard refuse to aide us in defending our wares, however we are still bright beneath the Gilder\'s eye, and our pockets full of shine. We\'ll pay you, Crownling, to help us to our destination for the next %days%.%SPEECH_OFF% | A servant boy carries a leash of slaves in one hand and a note in the other. He presents the latter which carries written instruction to meet with a set of merchants. They announce that they are traveling to %objective%, around %days% to the %direction%, under orders of the Gilder and Vizier alike, and need protection. For this, your services are needed and will be paid for quite handsomely. | The town\'s merchant square is rife with business and, apparently, you are wanted to be a part of it. A few of the Vizier\'s \'finest\' peddlers are wanting to take a caravan of goods to %objective%, a good %days% of travel. One explains tersely.%SPEECH_ON%If the Gilder might look the other way, I pray the so-called \'soldiers\' of this town find the world of shade. You, Crownling, I suspect you\'d be willing to help us where others are not? For coin, of course.%SPEECH_OFF% | You watch as slaves bundle goods and load them into a series of wagons. The caravan\'s owners spot you and seek you out, pushing their workforce out of the way or smacking them for apparently no reason at all other than it brings some unknown pleasure to do so. One beams with delight as he greets you. He puts one hand out, but you do not shake it.%SPEECH_ON%Ah, Crownling, it is true that this hand has profaned itself with the flesh of an indebted, but you shouldn\'t be so shy. We are all bright beneath the Gilder\'s eye, are we not? We\'ve a task for you, one of some import given the governance of our suzerain %employer%. The caravan is heading to %objective%, a good %days%\'s travel, and requires a fair bit of guard so that it may arrive in good health. Is this task amenable to your coin-seeking interests?%SPEECH_OFF%}";
			}
			if (s.ID == "ValuableCargo2")
			{
				foreach (option in s.Options)
				{
					option.Text = "Those should be worth a pretty crown. (Decrease Moral Reputation)"
				}
			}
			if (s.ID == "Prisoner2")
			{
				foreach (option in s.Options)
				{
					option.Text = "I see my pocket filled with crowns already! (Decrease Moral Reputation)"
				}
			}
			if (s.ID == "Success1")
			{
				s.start <- function ()
				{
					local money = this.Contract.m.Payment.getOnCompletion() + this.Contract.m.Payment.getPerCount() * this.Flags.get("HeadsCollected");
					local xpGained = this.Math.round(money * 0.50 * this.Const.Combat.GlobalXPMult);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] Crowns and [color=" + this.Const.UI.Color.PositiveEventValue + "]" + xpGained + "[/color] Experience"
					});
					this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/well_supplied_situation"), 3, this.Contract.m.Destination, this.List);
				}
				foreach (option in s.Options)
				{
					option.getResult <- function()
					{
						local money = this.Contract.m.Payment.getOnCompletion() + this.Contract.m.Payment.getPerCount() * this.Flags.get("HeadsCollected");
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(money);

						local xp = money * 0.50;
						local playerRoster = this.World.getPlayerRoster().getAll();
						foreach( bro in playerRoster )
						{
							bro.addXP(xp);
							bro.updateLevel();
						}

						if (this.World.FactionManager.getFaction(this.Contract.getFaction()).getType() == this.Const.FactionType.OrientalCityState)
						{
							this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "Protected a caravan as promised");
						}
						else if (this.Flags.get("IsStolenGoods"))
						{
							this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess * 2.0, "Protected a caravan of stolen goods");
						}
						else
						{
							this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Protected a caravan as promised");
						}

						this.World.Contracts.finishActiveContract();

						if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
						{
							local origin = this.Contract.getOrigin();
							if (origin != null)
							{
								local v = this.Contract.m.Caravan.getResources() + this.Contract.m.Caravan.getResources() * 0.10;
								origin.setResources(origin.getResources() + v);
							}
						}

						return 0;
					}
				}
			}
			if (s.ID == "Success2")
			{
				foreach (option in s.Options)
				{
					option.getResult <- function()
					{
						local money = this.Contract.m.Payment.getOnCompletion() + this.Contract.m.Payment.getPerCount() * this.Flags.get("HeadsCollected");
						money = this.Math.floor(money / 2);
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(money);

						if (this.World.FactionManager.getFaction(this.Contract.getFaction()).getType() == this.Const.FactionType.OrientalCityState)
						{
							this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractPoor, "Protected a caravan, albeit poorly");
						}
						else if (this.Flags.get("IsStolenGoods"))
						{
							this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractPoor * 2.0, "Protected a caravan of stolen goods, albeit poorly");
						}
						else
						{
							this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractPoor, "Protected a caravan, albeit poorly");
						}

						//moved from up above when we actually call this screen -> supposedly this is the issue where it makes it fail the contract but here it shouldn't
						if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
						{
							this.Contract.m.Caravan.setResources(this.Math.round(this.Contract.m.Caravan.getResources() / 2));
							local L = this.Contract.m.Caravan.getInventory();
							this.Contract.m.Caravan.clearInventory();
							for (local i = 0; i < (L.len() - 1) / 2; i = ++i)
							{
								this.Contract.m.Caravan.addToInventory(L[i]);
							}
						}

						this.World.Contracts.finishActiveContract();

						//Using this as a economy rewward for taking deliver contract missions - it'll increase the orgin resources by 10% if contract successfull
						//Think of it as establishing a trade route?
						local origin = this.Contract.getOrigin();
						if (origin != null)
						{
							local v = this.Contract.m.Caravan.getResources() + this.Contract.m.Caravan.getResources() * 0.10;
							origin.setResources(origin.getResources() + v);
						}

						return 0;
					}
				}
			}
		}
	}

	o.spawnCaravan = function ()
	{
		local faction = this.World.FactionManager.getFaction(this.getFaction());
		local party;

		if (faction.hasTrait(this.Const.FactionTrait.OrientalCityState))
		{
			party = faction.spawnEntity(this.m.Home.getTile(), "Trading Caravan", false, this.Const.World.Spawn.CaravanSouthernEscort, this.m.Home.getResources() * ::Math.rand(10, 25) * 0.01, this.getMinibossModifier());
		}
		else
		{
			party = faction.spawnEntity(this.m.Home.getTile(), "Trading Caravan", false, this.Const.World.Spawn.CaravanEscort, this.m.Home.getResources() * 0.4, this.getMinibossModifier());
		}

		party.getSprite("banner").Visible = false;
		party.getSprite("base").Visible = false;
		party.setMirrored(true);
		party.setDescription("A trading caravan from " + this.m.Home.getName() + " that is transporting all manner of goods between settlements.");
		party.setMovementSpeed(this.Const.World.MovementSettings.Speed * 0.6);
		party.setLeaveFootprints(false);

		// yes world economy
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			::Const.World.Common.WorldEconomy.Trade.setupTrade(party, this.m.Home, this.m.Destination);
		}
		// no world economy
		else
		{
			if (this.m.Home.getProduce().len() != 0)
			{
				local produce = 3;
				local L = this.m.Home.getProduce();

				for( local j = 0; j < produce; j = ++j )
				{
					party.addToInventory(::MSU.Array.rand(L));
				}
			}
		}

		party.getLoot().Money = this.Math.rand(0, 100);

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
	}
});
