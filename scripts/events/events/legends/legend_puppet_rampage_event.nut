this.legend_puppet_rampage_event <- this.inherit("scripts/events/event", {
	m = {
		Puppet = null,
		Necrohandler = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.legend_puppet_rampage";
		this.m.Title = "At %townname%";
		this.m.Cooldown = 42.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({ //— \
			ID = "A",
			Text = "%townImage%Entering %townname%, you are met with the usual stares and uneasy looks. Women hurry their children back inside while militia ready their weapons and ask if they're under attack. The merchants within the market are also uneasy, but gold is nothing if not a great equaliser of men. With little to no warning, one of your puppets, %puppet%, breaks ranks and lunges for a group of children throwing stones at it. \n\nThe troupe of children scatter as a few of the braver militia jump into action.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I don\'t care for this.",
					function getResult( _event )
					{
						return "B";
					}
				},
				{
					Text = "Attempt to restrain the thrall.",
					function getResult( _event )
					{
						return "C";
					}
				},
				{
					Text = "Take this oppertunity to loot.",
					function getResult( _event )
					{
						return "D";
					}
				}
			],
			function start( _event )
			{
				if (_event.m.Necrohandler != null)
				{
					this.Options.push({
						Text = "%necrohandler% needs to get their thrall in check...",
						function getResult( _event )
						{
							return "E";
						}
					});
				}

				this.World.Assets.addMoralReputation(-1);
				f.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "One of your thralls caused havoc in town");
				this.Characters.push(_event.m.Puppet.getImagePath());

				this.List.push({
					id = 11,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "Lost a small amount of moral reputation."
				});
			}

		});
		this.m.Screens.push({ //— \
			ID = "B",
			Text = "%townImage%You shrug. %puppet% grabs one of the children and bites down. Hard. \n\nThe child is sent reeling with a sudden instinct to escape and slips out the rotten grasp. Which Militia do arrive attempt to corral %puppet% like a cow, only for their morale to break as it turns it\'s attention on them. In this bedlam you continue talking with the merchant, who quickly wraps up their business with you and leaves before things escalate further.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We should probably leave.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Puppet.getImagePath());
				this.World.Assets.addMoralReputation(-4);
				local f = _event.m.Town.getFactionOfType(this.Const.FactionType.Settlement);
				f.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "One of your puppets caused havoc in town and you did nothing");

				this.List.push({
					id = 11,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "Lost a large amount of moral reputation."
				});
				this.List.push({
					id = 11,
					icon = "ui/icons/mood_02.png",
					text = "Angered the local inhabitants by doing nothing."
				});
			}

		});
		this.m.Screens.push({ //— \
			ID = "C",
			Text = "%townImage%As %puppet% raises their weapon high, you grab them by their armour and pull them into the mud. The rest of %companyname% quickly restrains %puppet% as much as possible before they do more damage. \nDespite the myriad of onlookers, it would be hard to judge that you didn\'t try to make amends. The local militia captain appears on the second floor of a townhouse and politely, yet firmly, waves you on.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That was almost a disaster.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Puppet.getImagePath());
				this.World.Assets.addMoralReputation(2);

				this.List.push({
					id = 11,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "Regained a small amount of moral reputation."
				});
				this.List.push({
					id = 11,
					icon = "ui/icons/mood_04.png",
					text = "The local inhabitants are content with your response."
				});
			}

		});
		this.m.Screens.push({ //— \
			ID = "D",
			Text = "[img]gfx/ui/events/event_30.png[/img]With that, you set loose the rest of the puppets under your control and the full force of %companyname%. Outside the settlement would\'ve been a difficult fight — but with the advantage of being inside the defences the mottled and scattered defenders have little time to organised. Arrows are loosed but do little damage to %puppet% as it pins down another screaming militiaman. %randonbro% loots a house and sets it on fire as they exit. Before long most of the market is more akin to a large-scale tavern brawl with your side handily willing through supernatural advantage. \n\nYou make sure to get well clear of the town before reinforcements catch you...",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That\'ll teach them.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Puppet.getImagePath());
				this.World.Assets.addMoralReputation(-8);
				local f = _event.m.Town.getFactionOfType(this.Const.FactionType.Settlement);
				f.addPlayerRelation(this.Const.World.Assets.RelationAttacked, "You pillaged the town");
				local money = this.Math.rand(252, 782);
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] Crowns"
				});
				this.List.push({
					id = 11,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "Greatly lost moral reputation."
				});
				this.List.push({
					id = 11,
					icon = "ui/icons/mood_01.png",
					text = "Local inhabitants are furious with you."
				});

				local brothers = this.World.getPlayerRoster().getAll();
				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == (::Legends.Background.Cultist))
					{
						bro.improveMood(2.0, "Enjoyed raiding and pillaging");
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
		this.m.Screens.push({ //— \
			ID = "E",
			Text = "%townImage%%necrohandler% murmurs something, %puppet% appears to resist. %necrohandler% murmers something again and the puppet ceases it\'s assault. The children return to pelting %puppet% with stones at a distance outside of arm reach this time — their target lolling obediently at the barrage. Both the puppet and the master look at you in unison. %SPEECH_ON%See? Nothing to it.%SPEECH_OFF%%necrohandler% cracks a sickly smile, their thrall attempts to mimic it, but only leaves you with a sensation that makes it difficult to judge which is worse.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Crisis averted.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Puppet.getImagePath());
				this.Characters.push(_event.m.Necrohandler.getImagePath());
				this.World.Assets.addMoralReputation(3);
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() || t.isMilitary())
			{
				continue;
			}

			if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_puppet = [];
		local candidates_necrohandler = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() ==(::Legends.Background.LegendPuppet))
			{
				candidates_puppet.push(bro);
			}
			else if (bro.getBackground().getID() == (::Legends.Background.LegendWarlockSummoner))
			{
				candidates_necrohandler.push(bro);
			}
		}

		if (candidates_puppet.len() == 0)
		{
			return;
		}

		this.m.Puppet = candidates_puppet[this.Math.rand(0, candidates_puppet.len() - 1)];

		if (candidates_necrohandler.len() != 0)
		{
			this.m.Necrohandler = candidates_necrohandler[this.Math.rand(0, candidates_necrohandler.len() - 1)];
		}

		this.m.Town = town;
		this.m.Score = candidates_puppet.len() * 8;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"puppet",
			this.m.Puppet.getName()
		]);
		_vars.push([
			"necrohandler",
			this.m.Necrohandler != null ? this.m.Necrohandler.getNameOnly() : ""
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Puppet = null;
		this.m.Necrohandler = null;
		this.m.Town = null;
	}

});
