this.legend_old_man_sells <- this.inherit("scripts/events/event", {
	m = {
		Bought = 0
	},
	function create()
	{
		this.m.ID = "event.legend_old_man_sells";
		this.m.Title = "The wanderer";
		this.m.Cooldown = 10000000000.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_76.png[/img]On your travels, an old man sits atop a crumbling wall. Normally this would be of little concern, but their frail body is draped in dark cloth while their face is muzzled by a mush of grey, broken hairs. The figure pulls out a pipe and begins to feebly puff on the smaller end.\n\n Without looking, he beckons you over towards the wall and brushes the moss from the top of it.%SPEECH_ON%Fine day, stranger...%SPEECH_OFF%He puffs some more but otherwise masks his intentions by looking straight through you — as if to peer deeper into your thoughts.%SPEECH_ON%I collect things, sellsword. Many things that you would never see in your life. Things that are lost and found again, by the wrong people.%SPEECH_OFF%He carefully holds aloft an ornate skull, which has been tethered to his belt by a chain thick enough to hold a giant, as if the skull would escape and frolic as soon as it was broken.\n The man puts his pipe down and holds the skull in both hands, casting it to his own eyes and peering deep into the sockets.%SPEECH_ON%My friend here, one of many, says that I carry and collect too many things — that I should share their brilliance with others who may spark an interest in the hunt. I\'m willing to part with one of these objects, for a small sum of two-thousand crowns.%SPEECH_OFF% He places the skull on his lap, which stares intently at you with socketless eyes as a dog would guard it\'s master...",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A relic for that much? I\'ll bite.",
					function getResult( _event )
					{
						_event.m.Bought = 1;
						return "B";
					}

				},
				{
					Text = "How about we just take everything you have, old man?",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 60 ? "C" : "D";
					}

				},
				{
					Text = "Not interested in trinkets.",
					function getResult( _event )
					{
						return "E";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_15.png[/img]The man parses the deal a second time, as if arguing with himself to reconsider. With a stumbling alacrity, he produces a small chest from almost thin air, opening it to reveal an object wrapped in burlap.%SPEECH_ON%Now if you\'d excuse me — I have a few children back at home to feed.%SPEECH_OFF% He hoists himself up like a damaged puppet with twisted strings and hobbles off into the treeline. A cracking of branches and leaves rustling can be heard from the depths, but soon everything goes quiet again.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Be seeing you...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Bought == 1)
				{
					local r = this.Math.rand(1, 5);
					local item;

					if (r == 1)
					{
						item = this.new("scripts/items/accessory/special/legend_oms_rib_item");
					}
					else if (r == 2)
					{
						item = this.new("scripts/items/accessory/special/legend_oms_amphora_item");
					}
					else if (r == 3)
					{
						item = this.new("scripts/items/accessory/special/legend_oms_ledger_item");
					}
					else if (r == 4)
					{
						item = this.new("scripts/items/accessory/special/legend_oms_paw_item");
					}
					else if (r == 5)
					{
						item = this.new("scripts/items/accessory/special/legend_oms_fate_item");
					}

					this.World.Assets.getStash().add(item);
					
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
					this.World.Assets.addMoney(-2000);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]2000[/color] Crowns"
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_29.png[/img]The old man thumbs his forehead as if you hadn\'t said anything at all. You watch his hands for a hidden dagger that never comes while he puts the smoking pipe away in a hidden pocket and gently puts the skull back into it\'s velvet cradle.\n\n He lets out a long sigh and bows his head. %SPEECH_ON%Fine.%SPEECH_OFF%A bolt grazes your shoulder and heralds a stumbling mass of undead that stream from behind every tree possible, steadily followed up by the more organised march and screaming silence of legionaries calmly making their way into their formations.\n\n %companyname% begins to cut, crush and push their way through the encircling horde to a small clearing.\n The undead have lost interest for now, but aside from the cuts and wounds of the company, your purse strings were cut in the confustion...",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Where the fark did they all come from!?",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local money = this.Math.rand(982, 2336);
				this.World.Assets.addMoney(-money);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You lost [color=" + this.Const.UI.Color.NegativeEventValue + "]" + money + "[/color] Crowns"
					}
				];
			}

			function giveEffect()
			{
				local brothers = this.World.getPlayerRoster().getAll();
				local result = [];
				local lowestChance = 9000;
				local lowestBro;
				local applied = false;

				foreach( bro in brothers )
				{
					for( local chance = bro.addLightInjury(); this.Math.rand(1, 100) < chance;  )
					{
						if (chance < lowestChance)
						{
							lowestChance = chance;
							lowestBro = bro;
						}
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_29.png[/img]The old man parses your statement for a moment, just enough time for you to see movement in the treeline around you as the man deftly sidesteps out of arms reach and walks to the treeline to join the undead. Meanwhile, the company forms a circle and have begun holding their ground against the lesser dead throwing themselves against %companyname%.\n\n Without warning, a terse clap is heard from the treeline as if to summon a servant. The ancient dead fall back in a more organised manner and still in formation, as if expecting you to give chase. The less organised members gradually swing, shuggle and flounder around as if restrained by weights around their arms and legs in the scattering of corpses they do not pay attention to before haphazardly wandering back to follow the others.\n Regardless, the company has survived with only a few minor bruises. A few members have already begun looting the pockets of the dead on the field.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Too close.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local money = this.Math.rand(489, 2582);
				this.World.Assets.addMoney(money);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gained [color=" + this.Const.UI.Color.NegativeEventValue + "]" + money + "[/color] Crowns"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_25.png[/img]You wave off the stranger at a safe distance. They nod their head and return to their pipe as you pass.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Can\'t trust anyone out here.",
					function getResult( _event )
					{
						return 0;
					}

				}
			]
		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getMoney() < 2500)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 6)
			{
				return false;
			}
		}

		this.m.Score = 25;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

