this.legends_adopt_warbear_event <- this.inherit("scripts/events/event", {
	m = {
		Bro = null,
		BearTamer = null
	},
	function create()
	{
		this.m.ID = "event.legends.adopt_warbear";
		this.m.Title = "Deep in the forest...";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_bear.png[/img]%bearTamer% taps you on the shoulder and points out fallen limbs and deep tracks that are typical of a bear's domain. The bear tamer asks your permission to set a trap to try and capture the beast?",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "This is no circus! A bear is dangerous. Keep well away from that thing",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "Better to put it down now before it steals any of our supplies later.",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 60)
						{
							return "C";
						}
						else
						{
							return "D";
						}
					}

				}
			],
			function start( _event )
			{
				if (_event.m.BearTamer != null)
				{
					this.Options.push({
						Text = "%bearTamer%, you\'re trained to handle bears, right?",
						function getResult( _event )
						{
							return "G";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_75.png[/img]This is no place to be ambushed by a bear. The next time the beast appears, you crack it between the eyes with a well-placed stone. Yelping, the bear retreats. It pauses, perhaps thinking that there was some sort of mistake here, but you quickly correct the foul thing with another rock. The bear leaves and is not seen again.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "And stay away!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_75.png[/img]You take a bow and nock an arrow. A few of the brothers watch as you take aim. The shot goes wide, but the bear gets the message and quickly scampers off.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I meant to scare it off.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_27.png[/img]You take a bow and nock an arrow. A few of the brothers watch as you take aim. The wind comes, goes, and comes again. You wait patiently before drawing the string and closing one eye to put the dog into focus. It sits down and stares at you between long-tongued pants.\n\nYou release the shot. The arrow zips through the air and the bear yelps. It keels back on its hind legs and falls over, its feet kicking and scraping on the ground until it stops. You put the bow back into its holding and get the company back on the road.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Poor thing.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_27.png[/img]You ask %bearTamer% the beartamer if they can try and \'woo\' this bear. The tamer nods and steps toward it. The wild beast\'s ears go from pinned to pointed. Crouched, the ranger  slowly edges toward the beast. Keeping a hand out with a piece of meat in the palm. Hunger overcomes heedfulness and the bear sniffs its way ever closer to the bear tamer\'s hand. The bear tongues it out of the ranger\'s palm and chows down. The bear trainer feeds another bite, scruffs the beast up and finds the sweet spot behind the ears. Looking back, %bearTamer% nods.%SPEECH_ON%Aye, it\'s an agreeable beast and will be easily trained.%SPEECH_OFF%That\'s great. You ask if it can fight. The ranger purses lips.%SPEECH_ON%A bear is akin to a human. If it can breathe, it can fight.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Nice.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.BearTamer.getImagePath());
				local item = this.new("scripts/items/accessory/legend_warbear_item");
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

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.Type == this.Const.World.TerrainType.Forest  && !currentTile.Type == this.Const.World.TerrainType.LeaveForest)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		local bearBros = 0;
		foreach( bro in brothers )
		{
			if (bro.getSkills().hasPerk(::Legends.Perk.LegendSummonBear) || bro.getBackground().getID() == "background.legend_druid" || bro.getBackground().getID() == "background.legend_commander_druid")
			{
				candidates.push(bro);
				bearBros++
			}
		}

		this.m.Bro = brothers[this.Math.rand(0, brothers.len() - 1)];

		if (candidates.len() > 0)
		{
			this.m.BearTamer = candidates[this.Math.rand(0, candidates.len() - 1)];
			this.m.Score = this.m.BearTamer.getLevel() - 5;
		}
		else
		{
			return;
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"bro",
			this.m.Bro.getName()
		]);
		_vars.push([
			"bearTamer",
			this.m.BearTamer != null ? this.m.BearTamer.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Bro = null;
		this.m.BearTamer = null;
	}

});

