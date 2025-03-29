this.legend_blacksmith_craft_armor <- this.inherit("scripts/events/event", {
	m = {
		Blacksmith = null,
		numIngots = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.legend_blacksmith_craft_armor";
		this.m.Title = "At %townname%";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_01.png[/img]While walking around the town shopping you notice %blacksmith% looks like he has his mind on something else.%SPEECH_ON%What\'s the matter %blacksmith%?%SPEECH_OFF%%SPEECH_ON%Sir I don\'t know how to say this but you see we have this tradition in a craft smith community where we compete in the art of craft to prove who is worthy of a name \"King of Craftsmen\" and are proud to hold that title!%SPEECH_OFF% Is he talking about that legendary contest where smiths from all over the world gather and they craft the best items that are worthy to withstand blows of a behemoth?%SPEECH_ON%What is it that you need from me?%SPEECH_OFF%%SPEECH_ON% I need 10,000 to enter the contest to buy the metal and other supplies.%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Here it is",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "B";
						}
						else
						{
							return "C";
						}
					}

				},
				{
					Text = "We can\'t spare money on this",
					function getResult( _event )
					{
						return;
					}

				}
			],
			function start( _event )
			{
				if (_event.m.numIngots != null && _event.m.numIngots >= 3)
				{
					this.Options.push({
						Text = "Use the Iron we have in stash instead",
						function getResult( _event )
						{
							if (this.Math.rand(1, 100) <= 60)
							{
								return "D";
							}
							else
							{
								return "E";
							}
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_31.png[/img]{You give him the money and %blacksmith% in no time gets up and sets off to seek the best metal and begin working. As he finishes his work, he tells a story of a blacksmith who was called by a king. The king had summoned all of the guild masters. Calling them to the throne one at a time, he questioned each, then sent them to the opposite side of the hall from those who had not yet been questioned. The first craftsman that he spoke with was a carpenter. The king asked what he made. %SPEECH_ON% I make all things of wood. Houses, wagons, wheels, looms and so on. %SPEECH_OFF% The king asked where he got his tools, and the carpenter answered that he got them from the blacksmith. The second craftsman was a weaver. The king asked the weaver where he got his tools, the weaver said that he got them from the blacksmith. The third craftsman was a potter. When the king questioned him, he admitted that he too got his tools from the blacksmith. Finally, the king called the %blacksmith% to the throne. When he asked the blacksmith where he got His tools, the %blacksmith% answered %SPEECH_ON%I made them myself, for no one else could make tools for the working of iron.%SPEECH_OFF% The king announced that he had made his decision. Since the blacksmith was the only craftsman who did not have to obtain his tools from someone else but made them for himself, that henceforth and forever more, the Blacksmith would be known as the King of Craftsmen",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A masterwork!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-10000);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]10000[/color] Crowns"
				});
				local item = this.Const.World.Common.pickArmor([
					[
						1,
						"named/named_golden_lamellar_armor"
					]
				]);
				item.m.Name = _event.m.Blacksmith.getNameOnly() + "\'s golden lamellar armor";
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				_event.m.Blacksmith.improveMood(2.0, "Created a masterwork Armor");

				if (_event.m.Blacksmith.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Blacksmith.getMoodState()],
						text = _event.m.Blacksmith.getName() + this.Const.MoodStateEvent[_event.m.Blacksmith.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_31.png[/img]{You give him the money and %blacksmith% in no time gets up and sets off to seek the best metal and begin working. As he finishes his work, he tells a story of a blacksmith who was called by a king. The king had summoned all of the guild masters. Calling them to the throne one at a time, he questioned each, then sent them to the opposite side of the hall from those who had not yet been questioned. The first craftsman that he spoke with was a carpenter. The king asked what he made. %SPEECH_ON% I make all things of wood. Houses, wagons, wheels, looms and so on. %SPEECH_OFF% The king asked where he got his tools, and the carpenter answered that he got them from the blacksmith. The second craftsman was a weaver. The king asked the weaver where he got his tools, the weaver said that he got them from the blacksmith. The third craftsman was a potter. When the king questioned him, he admitted that he too got his tools from the blacksmith. Finally, the king called the %blacksmith% to the throne. When he asked the blacksmith where he got His tools, the %blacksmith% answered %SPEECH_ON%I made them myself, for no one else could make tools for the working of iron.%SPEECH_OFF% The king announced that he had made his decision. Since the blacksmith was the only craftsman who did not have to obtain his tools from someone else but made them for himself, that henceforth and forever more, the Blacksmith would be known as the King of Craftsmen",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A masterwork!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-10000);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]10000[/color] Crowns"
				});
				local item = this.Const.World.Common.pickArmor([
					[
						1,
						"heavy_lamellar_armor"
					]
				]);
				item.m.Name = _event.m.Blacksmith.getNameOnly() + "\'s " + item.m.Name;
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_31.png[/img]{You give him the money and %blacksmith% in no time gets up and sets off to seek the best metal and begin working. As he finishes his work, he tells a story of a blacksmith who was called by a king. The king had summoned all of the guild masters. Calling them to the throne one at a time, he questioned each, then sent them to the opposite side of the hall from those who had not yet been questioned. The first craftsman that he spoke with was a carpenter. The king asked what he made. %SPEECH_ON% I make all things of wood. Houses, wagons, wheels, looms and so on. %SPEECH_OFF% The king asked where he got his tools, and the carpenter answered that he got them from the blacksmith. The second craftsman was a weaver. The king asked the weaver where he got his tools, the weaver said that he got them from the blacksmith. The third craftsman was a potter. When the king questioned him, he admitted that he too got his tools from the blacksmith. Finally, the king called the %blacksmith% to the throne. When he asked the blacksmith where he got His tools, the %blacksmith% answered %SPEECH_ON%I made them myself, for no one else could make tools for the working of iron.%SPEECH_OFF% The king announced that he had made his decision. Since the blacksmith was the only craftsman who did not have to obtain his tools from someone else but made them for himself, that henceforth and forever more, the Blacksmith would be known as the King of Craftsmen",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A masterwork!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-5000);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]5000[/color] Crowns"
				});
				local stash = this.World.Assets.getStash().getItems();
				local numIngots = 0;

				foreach( i, item in stash )
				{
					if (item != null && item.getID() == "misc.copper_ingots")
					{
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You lose " + item.getName()
						});
						numIngots = ++numIngots;
					}

					if (numIngots >= 3)
					{
						break;
					}
				}

				local item = this.Const.World.Common.pickArmor([
					[
						1,
						"named/named_golden_lamellar_armor"
					]
				]);
				item.m.Name = _event.m.Blacksmith.getNameOnly() + "\'s golden lamellar armor";
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				_event.m.Blacksmith.improveMood(2.0, "Created a masterwork Armor");

				if (_event.m.Blacksmith.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Blacksmith.getMoodState()],
						text = _event.m.Blacksmith.getName() + this.Const.MoodStateEvent[_event.m.Blacksmith.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_31.png[/img]{You give him the money and %blacksmith% in no time gets up and sets off to seek the best metal and begin working. As he finishes his work, he tells a story of a blacksmith who was called by a king. The king had summoned all of the guild masters. Calling them to the throne one at a time, he questioned each, then sent them to the opposite side of the hall from those who had not yet been questioned. The first craftsman that he spoke with was a carpenter. The king asked what he made. %SPEECH_ON% I make all things of wood. Houses, wagons, wheels, looms and so on. %SPEECH_OFF% The king asked where he got his tools, and the carpenter answered that he got them from the blacksmith. The second craftsman was a weaver. The king asked the weaver where he got his tools, the weaver said that he got them from the blacksmith. The third craftsman was a potter. When the king questioned him, he admitted that he too got his tools from the blacksmith. Finally, the king called the %blacksmith% to the throne. When he asked the blacksmith where he got His tools, the %blacksmith% answered %SPEECH_ON%I made them myself, for no one else could make tools for the working of iron.%SPEECH_OFF% The king announced that he had made his decision. Since the blacksmith was the only craftsman who did not have to obtain his tools from someone else but made them for himself, that henceforth and forever more, the Blacksmith would be known as the King of Craftsmen",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A masterwork!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-5000);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]5000[/color] Crowns"
				});
				local stash = this.World.Assets.getStash().getItems();
				local numIngots = 0;

				foreach( i, item in stash )
				{
					if (item != null && item.getID() == "misc.copper_ingots")
					{
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You lose " + item.getName()
						});
						numIngots = ++numIngots;
					}

					if (numIngots >= 3)
					{
						break;
					}
				}

				local item = this.Const.World.Common.pickArmor([
					[
						1,
						"heavy_lamellar_armor"
					]
				]);
				item.m.Name = _event.m.Blacksmith.getNameOnly() + "\'s " + item.m.Name;
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.Assets.getMoney() < 15000)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getSize() >= 3 && t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
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

		this.m.Town = town;
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_blacksmith = [];

		foreach( b in brothers )
		{
			if (b.getLevel() > 9 && b.getBackground().getID() == "background.legend_blacksmith")
			{
				candidates_blacksmith.push(b);
			}
		}

		if (candidates_blacksmith.len() < 1)
		{
			return;
		}
		else
		{
			this.m.Blacksmith = candidates_blacksmith[this.Math.rand(0, candidates_blacksmith.len() - 1)];
		}

		local stash = this.World.Assets.getStash().getItems();
		this.m.numIngots = 0;

		foreach( item in stash )
		{
			if (item != null && item.getID() == "misc.copper_ingots")
			{
				this.m.numIngots = ++this.m.numIngots;
			}
		}

		this.m.Score = 25;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"blacksmith",
			this.m.Blacksmith.getName()
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Blacksmith = null;
		this.m.numIngots = null;
		this.m.Town = null;
	}

});

