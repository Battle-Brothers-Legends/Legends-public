this.legend_enter_wizard_tower_event <- this.inherit("scripts/events/event", {
	m = {
		Observer = null
	},
	function create()
	{
		this.m.ID = "event.location.legend_enter_wizard_tower";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_125.png[/img]{The tower is the tallest structure you have ever seen. %observer% walks up and halts at the very sight.%SPEECH_ON%By the old gods, is that tower touching the sky? %SPEECH_OFF%You sigh and tell the company to stay here while you and the very observant sellsword go take a look.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let\'s see what secrets are inside.",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "It\'s not worth investigating now.",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setVisited(false);
						}

						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Observer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_125.png[/img]{As you approach the tower door you hear a voice call out as if far away. Looking up you see a person waving from the tallest room in the tower. They yell and gesture that they will be with you in a moment. Barely an instant later the door opens, and the same person is standing before you in long flowing robes and a floopy hat.  %SPEECH_ON% Ah a visitor, not often we get visitors these days. %SPEECH_OFF%  As he speaks a younger person in the same robes pokes their head throug the door behind him. %SPEECH_ON% You must have a reason for coming all this way. %SPEECH_OFF%  he continues %SPEECH_ON% Perhaps you\'re here to buy an apprentice? %SPEECH_OFF%  The young apprentice looks shocked and blurts out %SPEECH_ON% Buy? You\'re not selling me, are you master? %SPEECH_OFF% The old man looks dismissive and rebuffs %SPEECH_ON% Buy? Why I meant Hire! Every apprentice must go out on a workplace trial in the real world to become a journeyman. Yes, yes it\'s decided then. Now all that is needed is to negotiate the wage %SPEECH_OFF%  The apprentice looks scared and confused but the old man continues. %SPEECH_ON% If you give me 20,000 crowns I will let you keep the kid, but no refunds.%SPEECH_OFF% The apprentice meekly asks %SPEECH_ON%  Shouldn\'t the wage be a daily stipend to the journeyman doing the work? %SPEECH_OFF%  The old man dimisses the suggestion with a wave %SPEECH_ON% Of course not! This is the fee to cover your training. How else am I meant to buy another apprentice? Hopefully one who complains less. So do we have a deal? Remember, no returns. %SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Accept the kid.",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "We don\'t buy children",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setVisited(false);
						}

						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Observer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_125.png[/img]{%observer% suggests maybe you are really rescuing the kid, who cowers as you take them under your arm. }",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Is this what a wizard looks like?",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Observer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_125.png[/img]{%observer% heads back to the company with the apprentice, who is squinting and looking about as if they haven\'t been outside the tower in a long time. You wonder if the mercenary life is any better. }",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "The journeyman begins",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"wildman_background"
				]);
				_event.m.Dude.setTitle("the apprentice");
				_event.m.Dude.getBackground().m.RawDescription = "%name% was \'hired\' by you from an old man in a tall tower";
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (!bro.getBackground().isBackgroundType(this.Const.BackgroundType.Noble) && !bro.getSkills().hasTrait(::Legends.Trait.Bright) && !bro.getSkills().hasTrait(::Legends.Trait.ShortSighted) && !bro.getSkills().hasTrait(::Legends.Trait.NightBlind))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() != 0)
		{
			this.m.Observer = candidates[this.Math.rand(0, candidates.len() - 1)];
		}
		else
		{
			this.m.Observer = brothers[this.Math.rand(0, brothers.len() - 1)];
		}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"observer",
			this.m.Observer != null ? this.m.Observer.getNameOnly() : ""
		]);
	}

	function onClear()
	{
		this.m.Observer = null;
	}

});

