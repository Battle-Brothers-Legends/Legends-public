this.legend_lonewolf_companion_berserker_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.legend_lonewolf_companion_berserker";
		this.m.Title = "Sole Survivor";
		this.m.Cooldown = 66.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_36.png[/img]{You have been walking for what feels like forever now.\n\n The blizzard has begun to pick up and you move into the treeline for cover. It has been a long time since you have felt this cold and your body is fully aware of it. You spot black smoke through the tips of the trees and make your way towards it — with any luck the fire it came from is still burning or at least easy enough to rekindle.\n\n In a matter of speaking, the fire still is alive, in the sense that a few dozen huts, burning or collapsed, rise into view as you snap through the treeline on the other side. The settlement is somewhere between a crude camp and an established home where the occasional tent or ramshackle structure breaks up the more uniform and thoughtful huts.\n In the distance, you can hear fighting, and more alarmingly, screaming.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Someone needs our help! | It\'s worth a look at least... | Approach carefully...}",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "Rest and leave.",
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
			ID = "B",
			Text = "[img]gfx/ui/events/event_76.png[/img]{You wind your way through the sea of tents and huts to find a pile of corpses in the middle of what appears to be an area. The edges are clearly marked with large stones in an oval that is nearly twenty paces from the furthest edges. Two-dozen bodies burn on the the pyre in the middle of the area, some melted away while others have been added more recently.\n\n You follow the screaming to find a lone fighter — a barely dressed and heavily bleeding mountain of a northman who is in the process of ripping a necrosavant\'s head in two by parting its upper and lower jaw away with their bare hands like a scribe would part a large tome with a stiff spine. You cannot tell if the screaming is from the berserker or the bloodsucker which is now clawing for freedom to no avail.\n A crack is heard and the vampire falls to the ground with its lower jaw lolling free. It hits the snow the pale skin turns to ash like a book soaked in heavy rain. Two more of it\'s kind emerge from a longhouse, as you draw your weapon with a hurried breath they both disappear back into the storm.\n\n Of the two of you, the berserker is the first to speak. %SPEECH_ON%My name is %dude%, and what you see around me is the last of my people...%SPEECH_OFF% You cast a gaze around, anticipating more will emerge from the huts. But no survivors present themselves aside from the remains on the still-burning pyre. %SPEECH_ON%I am hungry for revenge, outlander. And I think you are too.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{I haven\'t told you who I am yet... | What about me? | I\'d be glad to have a fighter like you.}",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "{Not interested. | You\'re too unpredictable for my tastes.}",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_76.png[/img]{%dude% smiles.\n %SPEECH_ON%I know who you are — what you are...and your purpose. Few would\'ve come to find me unless they wanted a fight or had something to prove.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Good thing I\'m not one of those bloodsuckers.}",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_76.png[/img]{%dude% says nothing, but picks up a blunted hatchet and walks into the storm to pursue the two that got away.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Hopefully it works out okay.",
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
			ID = "E",
			Text = "[img]gfx/ui/events/event_76.png[/img]The noise will just draw more problems to this place. After a while of huddling in one of the many huts, the storm eventually passes, as so does the yelling.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Nothing good could\'ve come of that.",
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
		if (this.World.Assets.getOrigin().getID() != "scenario.lone_wolf")
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Snow && currentTile.Type != this.Const.World.TerrainType.SnowyForest)
		{
			return;
		}

		this.m.Score = 30;
	}

	function onPrepareVariables( _vars )
	{
		if (this.m.Dude == null)
		{
			local roster = this.World.getTemporaryRoster();
			this.m.Dude = roster.create("scripts/entity/tactical/player");
			this.m.Dude.setStartValuesEx([
				"legend_berserker_background"
			]);
			this.m.Dude.getSprite("miniboss").setBrush("bust_miniboss");
			this.m.Dude.addHeavyInjury();
		}

		_vars.push([
			"dude",
			this.m.Dude.getName()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

