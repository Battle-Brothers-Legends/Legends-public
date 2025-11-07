::mods_hookExactClass("contracts/contracts/discover_location_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"Exploration. Easy money, for a sellsword company.",
			"Find a concealed place that may not even exist. Perfect.",
			"Scout a mysterious location for your employer. Perhaps even loot it.",
			"Exploration! The thrill of the unknown.",
			"Venture into uncharted territory and perhaps uncover an ancient mystery or two.",
			"Get lost, and get paid whilst doing so.",
			"Rummage around the wilderness and see what you can find.",
			"Scouting is not exactly a glorious contract, but it can pay well.",
		];
	}

	o.setup = function ()
	{
		local locations = clone this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
		locations.extend(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getSettlements());
		local lowestDistance = 9000;
		local best;
		local myTile = this.m.Home.getTile();

		foreach( b in locations )
		{
			if (b.isLocationType(this.Const.World.LocationType.Unique))
			{
				continue;
			}

			if (b.isDiscovered())
			{
				continue;
			}

			local region = this.World.State.getRegion(b.getTile().Region);

			if (!region.Center.IsDiscovered)
			{
				continue;
			}

			if (region.Discovered < 0.25)
			{
				this.World.State.updateRegionDiscovery(region);
			}

			if (region.Discovered < 0.25)
			{
				continue;
			}

			local d = myTile.getDistanceTo(b.getTile());

			if (d > 20)
			{
				continue;
			}

			if (d + this.Math.rand(0, 5) < lowestDistance)
			{
				lowestDistance = d;
				best = b;
			}
		}

		if (best == null)
		{
			this.m.IsValid = false;
			return;
		}

		this.m.Location = this.WeakTableRef(best);
		this.m.Flags.set("Region", this.World.State.getTileRegion(this.m.Location.getTile()).Name);
		this.m.Flags.set("Location", this.m.Location.getName());
		this.m.DifficultyMult = this.Math.rand(70, 85) * 0.01;
		this.m.Payment.Pool = this.Math.max(300, 100 + (this.World.State.m.CampaignSettings ? 100 : 0) + lowestDistance * 15.0 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentLightMult());

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.m.Flags.set("Bribe", this.beautifyNumber(this.m.Payment.Pool * (this.Math.rand(110, 150) * 0.01)));
		this.m.Flags.set("HintBribe", this.beautifyNumber(this.m.Payment.Pool * 0.1));
	}

	local createStates = o.createStates;
	o.createStates = function()
	{
		createStates();
		foreach (s in this.m.States)
		{
			if (s.ID == "Offer")
			{
				s.end <- function ()
				{
					this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
					local r = this.Math.rand(1, 100);

					if (r <= 15)
					{
						this.Flags.set("IsAnotherParty", true);
						this.Flags.set("IsShowingAnotherParty", true);
					}

					this.Contract.m.LastHelpTime = this.Time.getVirtualTimeF() + this.Math.rand(10, 30);
					this.Contract.setScreen("Overview");
					this.World.Contracts.setActiveContract(this.Contract);
				}
			}
		}
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		::Legends.Screens.hook(this, "AnotherParty3", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_51.png[/img]{After telling the man no, he falls to his knees and cries out, much to the amusement of the %companyname%. He wails on about how you\'ve left the historic past of his family in the hands of lechers and usurers. You tell him that you don\'t care. | Telling the man that you\'ve no interest in betraying your original employer sets him off. He tries to attack you, launching forward to glom onto you with angry hands. %randombrother% pushes him away and threatens to kill him with a blade. The man backs off. He sits beside the path, head between his knees, sobbing. One of the men gives him a handkerchief as they pass by. | You tell the man no. He begs. You tell him no again. He begs some more. You suddenly realize you\'ve done this with a woman or two. It really isn\'t a good look. You tell him as much, but the emotion of the moment is too much for him. He starts to wail, going on about how his family name will be ruined by the greedy bastards that run %townname%. You tell him that his supposed family name would be spared if, perhaps, he was the one running this town. This does not clear his tears.}";
		});
		::Legends.Screens.hook(this, "Success1", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_20.png[/img]{%employer% welcomes you back. You hand over your recently illustrated map and he pores over it, swatting the spotted mark with the back of his hand.%SPEECH_ON%Of course that\'s where it is!%SPEECH_OFF%He smirks and pays you what you\'re owed. | You come to %employer%\'s room, a fresh map in hand. He takes it from you and looks it over.%SPEECH_ON%Well then. I\'d mind to think this was a spot too easy, but an agreement is an agreement.%SPEECH_OFF%He hands you a satchel weighed with precisely what is owed. | You report to %employer%, telling him of %location%\'s location. He nods and scribbles, copying the notes from your map. Curious, you ask how he knows you\'re not lying. The man sets down in a chair and leans back, clasping his hands over his belly.%SPEECH_ON%I invested in a tracker who kept close to your company. He made it here before you did and you\'ve but confirmed what I already know. Hope you don\'t mind the measures taken.%SPEECH_OFF%Nodding, you think it a wise move and take your pay and go.}";
			_screen.Options = [
				{
					Text = "Crowns well deserved.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						local playerRoster = this.World.getPlayerRoster().getAll();
						local xp = this.Contract.m.Payment.getOnCompletion() * 0.10;
						foreach( bro in playerRoster ) {
							bro.addXP(xp);
							bro.updateLevel();
						}
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Hired to find the " + this.Flags.get("Location"));
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			];
			_screen.start <- function () {
				local xpGained = this.Math.round(this.Contract.m.Payment.getOnCompletion() * 0.10 * this.Const.Combat.GlobalXPMult);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] Crowns and [color=" + this.Const.UI.Color.PositiveEventValue + "]" + xpGained + "[/color] Experience"
				});
			}
		});
	}
});
