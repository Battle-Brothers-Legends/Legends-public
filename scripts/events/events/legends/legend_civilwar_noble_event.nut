this.legend_civilwar_noble_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.crisis.civilwar_noble";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_35.png[/img]A well outfited man approaches with a self confident swagger in his step. You put a hand to your sword and order him to announce his intentions, all the while keeping your eyes peeled for an ambush. The stranger takes a step forward and you can see his well manicured facial hair.%SPEECH_ON%I am %crusader%, fear not peasant, I am here to help. The noble houses are at war again, and while they bicker and plot the towns are not safe. %SPEECH_OFF%You take your hand off your sword and ask him of the nobles. He nods and speaks.%SPEECH_ON%I am related to most of the houses, I know a thing or two about these feuds. %SPEECH_OFF% The man gestures to your weapons.%SPEECH_ON%Enough to know the safest place is with good blades by your side.%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "You might as well join us.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				},
				{
					Text = "No, thanks, we\'re good.",
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
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
					{
						_event.m.Dude.getFlags().add("PlayerSkeleton");
						_event.m.Dude.getFlags().add("undead");
						_event.m.Dude.getFlags().add("skeleton");
						_event.m.Dude.setStartValuesEx([
							"legend_noble_commander_background"
					]);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.RacialSkeleton);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendFleshless);
					}
				else
				{
					_event.m.Dude.setStartValuesEx([
						"legend_noble_commander_background"
					]);
				}
				::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendHateNobles);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.FactionManager.isCivilWar())
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local roster = this.World.getPlayerRoster().getAll();
		foreach( bro in roster)
		{
			if (bro.getBackground().getID() == "background.legend_commander_noble")
			{
				return
			}
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"crusader",
			this.m.Dude.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});
