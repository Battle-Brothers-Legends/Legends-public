::mods_hookExactClass("contracts/contracts/deliver_item_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"A valuable cargo requires express, armed delivery. Discretion preferred.",
			"Complete the delivery, claim your payment. Sounds so simple.",
			"Secure the package, fulfill the contract, collect your fee.",
			"Get paid for the armed delivery of this crucial item.",
			"\'Deliver with maximum security.\' You have to wonder what kind of item demands such lengths.",
			"Handle with care, deliver securely, enjoy the payout. Sounds easy enough.",
			"From pickup to drop-off, prioritize security, earn your pay.",
			"Make sure the package arrives intact to secure your compensation.",
			"Secure the package, ensure safe delivery, earn your reward.",
			"Guard the item closely, hand only to its intended recipient to fulfill the contract.",
			"Navigate dangerous roads, fulfill the contract, and get paid.",
		];
	}

	o.setup = function ()
	{
		local settlements = this.World.EntityManager.getSettlements();
		local candidates = [];

		foreach( s in settlements )
		{
			if (s.getID() == this.m.Home.getID())
			{
				continue;
			}

			if (!s.isDiscovered() || s.isMilitary())
			{
				continue;
			}

			if (!s.isAlliedWithPlayer())
			{
				continue;
			}

			if (this.m.Home.isIsolated() || s.isIsolated() || !this.m.Home.isConnectedToByRoads(s) || this.m.Home.isCoastal() && s.isCoastal())
			{
				continue;
			}

			local d = this.m.Home.getTile().getDistanceTo(s.getTile());

			if (d < 15 || d > 100)
			{
				continue;
			}

			if (this.World.getTime().Days <= 10)
			{
				local distance = this.getDistanceOnRoads(this.m.Home.getTile(), s.getTile());
				local days = this.getDaysRequiredToTravel(distance, this.Const.World.MovementSettings.Speed, false);

				if (this.World.getTime().Days <= 5 && days >= 2)
				{
					continue;
				}

				if (this.World.getTime().Days <= 10 && days >= 3)
				{
					continue;
				}
			}

			candidates.push(s);
		}

		if (candidates.len() == 0)
		{
			this.m.IsValid = false;
			return;
		}

		this.m.Destination = this.WeakTableRef(candidates[this.Math.rand(0, candidates.len() - 1)]);
		local distance = this.getDistanceOnRoads(this.m.Home.getTile(), this.m.Destination.getTile());
		local days = this.getDaysRequiredToTravel(distance, this.Const.World.MovementSettings.Speed, false);

		local modrate = this.World.State.getPlayer().getBarterMult();

		if (days >= 2 || distance >= 40)
		{
			this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
		}
		else
		{
			this.m.DifficultyMult = this.Math.rand(70, 85) * 0.01;
		}

		this.m.Payment.Pool = this.Math.max(75, distance * (4.0 + modrate) * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentLightMult());
		//	local modBonus = distance * modrate * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentLightMult();
		//	this.Contract.m.BulletpointsObjectives.push("You gain + " modrate " crowns due to your bartering skills");

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.m.Flags.set("Distance", distance);
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Success1")
			{
				s.Options = [
					{
						Text = "Crowns well deserved.",
						function getResult()
						{
							this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
							this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());

							local playerRoster = this.World.getPlayerRoster().getAll();
							local xp = this.Contract.m.Payment.getOnCompletion() * 0.25;
							foreach( bro in playerRoster )
							{
									bro.addXP(xp);
									bro.updateLevel();
							}
							if (this.World.FactionManager.getFaction(this.Contract.getFaction()).getType() == this.Const.FactionType.OrientalCityState)
							{
								this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "Delivered some cargo");
							}
							else
							{
								this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Delivered some cargo");
							}

							local recipientFaction = this.Contract.m.Destination.getFactionOfType(this.Const.FactionType.Settlement);

							if (recipientFaction != null)
							{
								recipientFaction.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess * 0.5, "Delivered some cargo");
							}

							this.World.Contracts.finishActiveContract();
							return 0;
						}

					}
				];
				local start = s.start;
				s.start <- function ()
				{
					start();
					this.Contract.m.Home.setResources(this.Contract.m.Home.getResources() + this.Contract.m.Home.getResources() * 0.05); // Gain 5% settlement wealth for this contract
				}
			}
			if (s.ID == "Success2")
			{
				s.Options = [
					{
						Text = "Crowns well deserved.",
						function getResult()
						{
							this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
							this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());

							local playerRoster = this.World.getPlayerRoster().getAll();
							local xp = this.Contract.m.Payment.getOnCompletion() * 0.25;
							foreach( bro in playerRoster )
							{
								bro.addXP(xp);
								bro.updateLevel();
							}

							if (this.World.FactionManager.getFaction(this.Contract.getFaction()).getType() == this.Const.FactionType.OrientalCityState)
							{
								this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "Delivered some cargo");
							}
							else
							{
								this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Delivered some cargo");
							}

							local recipientFaction = this.Contract.m.Destination.getFactionOfType(this.Const.FactionType.Settlement);

							if (recipientFaction != null)
							{
								recipientFaction.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess * 0.5, "Delivered some cargo");
							}

							this.World.Contracts.finishActiveContract();
							return 0;
						}

					}
				];
				s.start <- function ()
				{
					local xpGained = this.Math.round(this.Contract.m.Payment.getOnCompletion() * 0.25 * this.Const.Combat.GlobalXPMult);
					this.Characters.push(this.Tactical.getEntityByID(this.Contract.m.RecipientID).getImagePath());
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] Crowns and [color=" + this.Const.UI.Color.PositiveEventValue + "]" + xpGained + "[/color] Experience"
					});
					this.Contract.m.Home.setResources(this.Contract.m.Home.getResources() + this.Contract.m.Home.getResources() * 0.05); // Gain 5% settlement wealth for this contract
				}
			}
		}
	}
});
