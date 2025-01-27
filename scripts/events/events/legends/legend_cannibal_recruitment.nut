this.legend_cannibal_recruitment <- this.inherit("scripts/events/event", {
	m = {
		Cannibal = null
	},
	function create()
	{
		this.m.ID = "event.legend_cannibal_recruitment";
		this.m.Title = "Strange Times";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_cannibal_recruitment.png[/img]You halt and turn your nose skyward, a thread of flavour is drifting on the wind — it is not grain or fruit, but instead something more sickly sweet. Following the trail like a hungry pig leads to a ramshackle camp — inhabited by a lonely figure basked in the light of a campfire.\n\n A vast array of utensils are laid out in the same manner as a torturer places his instruments before beginning their work. The figure shuffles slightly, exchanging a ladle for a spoon.\n A branch crunches and the figure twitches somewhat, but does not rise or jump as you would expect.\n\n Their grisly voice rings out towards your hide. %SPEECH_ON%Ther\'s enough fer all of yer\'s %SPEECH_OFF% The figure starts stirring the pot gently with their finger. You emerge into the dim dancing light of the open fire, the smell is stronger now, but there\'s something else in the air that was not there before.\n\n With a hand on your weapon and approaching slowly, you enter the innermost ring of the fire. The fire no longer dances, instead it mopes and tumbles slowly on the stranger\'s face — who is still fixated on the stew mere inches from the tip of their rankling nose. They motion for you to sit down, irritated by you towering over them.\n It\'s best to sit.\n The stranger, now half illuminated by the tired flame, moves from their spot to fix eyes with you. They stare and wait, as if they were mentally dissecting you.\n The thickness of the air starts to become noticeable this close to the ground. You wonder if this is what death feels like. The stranger hangs a crooked grin. %SPEECH_ON%Yer want somethin\' \'ta eat?\n\nOr are ya lookin\' fer a real artist like merself?%SPEECH_OFF% With a smile the grin becomes uncomfortably wide.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Welcome to the %companyname%.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Cannibal);
						this.World.getTemporaryRoster().clear();
						_event.m.Cannibal.onHired();
						return 0;
					}

				},
				{
					Text = "We\'d rather not take you in.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Cannibal = roster.create("scripts/entity/tactical/player");

				if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
				{
					_event.m.Cannibal.getFlags().add("PlayerSkeleton");
					_event.m.Cannibal.getFlags().add("undead");
					_event.m.Cannibal.getFlags().add("skeleton");
					_event.m.Cannibal.setStartValuesEx([
						"legend_cannibal_background"
					]);
					::Legends.Traits.grant(_event.m.Cannibal, ::Legends.Trait.RacialSkeleton);
					::Legends.Traits.grant(_event.m.Cannibal, ::Legends.Trait.LegendFleshless);
				}
				else
				{
					_event.m.Cannibal.setStartValuesEx([
						"legend_cannibal_background"
					]);
				}

				this.Characters.push(_event.m.Cannibal.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local totalbrothers = 0;
		local brotherlevels = 0;

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.legend_cannibal")
			{
				return;
			}

			totalbrothers = totalbrothers + 1;
			brotherlevels = brotherlevels + bro.getLevel();
		}

		if (totalbrothers < 1 || brotherlevels < 1)
		{
			return;
		}

		// this.m.Score = 2.5 + brotherlevels / totalbrothers * 5.0 / this.Const.LevelXP.len();
		//this.m.Score = 2.0; //people kept complaining they got this event too often with the score above
		this.m.Score = 1.0; //people kept complaining they got this event too often with the scores above
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"cannibal",
			this.m.Cannibal.m.Name
		]);
	}

	function onClear()
	{
		this.m.Cannibal = null;
	}

});

