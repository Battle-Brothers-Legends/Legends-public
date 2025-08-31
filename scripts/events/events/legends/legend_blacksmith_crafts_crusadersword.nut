this.legend_blacksmith_crafts_crusadersword <- this.inherit("scripts/events/event", {
	m = {
		Blacksmith = null,
		OtherGuy1 = null,
		OtherGuy2 = null
	},
	function create()
	{
		this.m.ID = "event.legend_blacksmith_crafts_crusadersword";
		this.m.Title = "During camp...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]%blacksmith% thumbs their tools in an idle manner, they pick up the iron ingots in the company stash and weigh them with their eyes. You can already tell that there is much more at work here than it seems, at it is only when %Blacksmith% notices you standing there that they put their plan into motion. %SPEECH_ON%I\'ve been ponderin\' this for some time capt\'n, I see you lot running around in yer\' fancy cloaks killin\' all them strange folk comin\' from the ground and it got me thinkin\'. Me da\' used to serve the order way back when — he showed me \'is sword a few times and I think, with your \'elp I could make it work. All I need is your eyes and this \'ere iron.%SPEECH_OFF% You make sustained eye contact with %Blacksmith% %SPEECH_ON%Okay, maybe a few crowns as well.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You can have 2000 crowns, I\'ll tell you what to do — just swing.",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "We don\'t have time for this.",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Blacksmith.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]{The blacksmith hammers the metal with the accuracy of a loom — twisting the metal this way and that while you point and mutter from behind. The hammering is ceaseless until the blade is committed back to the forge, at which point %Blacksmith% takes the lul to get up, stretch and talk with the others.\n\n A few more turns on the anvil and a successful quench later, %Blacksmith% fits and finishes the blade, proud of the masterpiece that has been lost for generations.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "It will kill.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Blacksmith.getImagePath());
				this.World.Assets.addMoney(-2000);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]2000[/color] Crowns"
				});
				local stash = this.World.Assets.getStash().getItems();
				local numIngots = ::Math.rand(1, 2);

				foreach( i, item in stash )
				{
					if (item != null && item.getID() == "misc.legend_iron_ingots")
					{
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You lose " + item.getName()
						});
						numIngots -= 1;

						if (numIngots == 0)
							break;
					}
				}

				local item = this.new("scripts/items/weapons/legend_crusader_sword");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				this.List.push(::Legends.EventList.changeMood(_event.m.Blacksmith, 2.5, "Created a legendary sword"));
			}
		});

		// this.m.Screens.push({ //Fail
		// 	ID = "C",
		// 	Text = "[img]gfx/ui/events/event_05.png[/img]%Blacksmith% begins strong, but gradually loses control of the shape and form of the blade over time. %Blacksmith% squints and attempts to start again. But at this point the blade is already lost. You tell them to finish it as best as they can.\n\n With a tounge stuck out and a pensive look, %Blacksmith% eventually defaults back to their old ways and makes an impressively average looking blade, allbeit functional and sturdy.",
		// 	Image = "",
		// 	List = [],
		// 	Characters = [],
		// 	Options = [
		// 		{
		// 			Text = "Well, you almost had it.",
		// 			function getResult( _event )
		// 			{
		// 				return 0;
		// 			}

		// 		}
		// 	],
		// 	function start( _event )
		// 	{
		// 		this.Characters.push(_event.m.Blacksmith.getImagePath());
		// 		this.World.Assets.addMoney(-2000);
		// 		this.List.push({
		// 			id = 10,
		// 			icon = "ui/icons/asset_money.png",
		// 			text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]2000[/color] Crowns"
		// 		});
		// 		local stash = this.World.Assets.getStash().getItems();

		// 		local numIngots = ::Math.rand(1, 2);
		// 		foreach (i, item in stash)
		// 		{
		// 			if (item != null && item.getID() == "misc.legend_iron_ingots")
		// 			{
		// 				stash[i] = null;
		// 				this.List.push({
		// 					id = 10,
		// 					icon = "ui/items/" + item.getIcon(),
		// 					text = "You lose " + item.getName()
		// 				});
		// 				if (--numIngots == 0) break;
		// 			}
		// 		}

		// 		local item = this.new("scripts/items/weapons/legend_longsword"); //lmao get fucked
		// 		item.m.Name = _event.m.Blacksmith.getNameOnly() + "\'s " + item.m.Name;
		// 		this.World.Assets.getStash().add(item);
		// 		this.List.push({
		// 			id = 10,
		// 			icon = "ui/items/" + item.getIcon(),
		// 			text = "You gain " + item.getName()
		// 		});
		// 		_event.m.Blacksmith.worsenMood(1.5, "Didn\'t quite get the sword right...");

		// 		if (_event.m.Blacksmith.getMoodState() < this.Const.MoodState.Neutral)
		// 		{
		// 			this.List.push({
		// 				id = 10,
		// 				icon = this.Const.MoodStateIcon[_event.m.Blacksmith.getMoodState()],
		// 				text = _event.m.Blacksmith.getName() + this.Const.MoodStateEvent[_event.m.Blacksmith.getMoodState()]
		// 			});
		// 		}
		// 	}

		// });

		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_05.png[/img]You tell the Blacksmith that that sword is better off lost. They begin to object, but eventually fall silent.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "The past doesn\'t matter anymore.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Blacksmith.getImagePath());
				this.List.push(::Legends.EventList.changeMood(_event.m.Blacksmith, -2.0, "Was denied a request"));
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() != "scenario.legends_crusader")
		{
			return;
		}

		if (this.World.Assets.getMoney() < 2500)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 9 && bro.getBackground().getID() == "background.legend_blacksmith")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local numIngots = 0;

		foreach( item in stash )
		{
			if (item != null && item.getID() == "misc.legend_iron_ingots")
			{
				numIngots = ++numIngots;
				numIngots = numIngots;

				if (numIngots >= 2)
				{
					break;
				}
			}
		}

		if (numIngots < 2)
		{
			return;
		}

		this.m.Blacksmith = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 4;
	}

	function onPrepare()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			if (bro.getID() != this.m.Blacksmith.getID())
			{
				this.m.OtherGuy1 = bro;
				break;
			}
		}

		foreach( bro in brothers )
		{
			if (bro.getID() != this.m.Blacksmith.getID() && bro.getID() != this.m.OtherGuy1.getID())
			{
				this.m.OtherGuy2 = bro;
				break;
			}
		}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"blacksmith",
			this.m.Blacksmith.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Blacksmith = null;
	}

});

