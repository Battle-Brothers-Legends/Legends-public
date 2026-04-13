this.legends_troubadour_and_juggler_event <- this.inherit("scripts/events/event", {
	m = {
		Troubadour = null,
		Juggler = null
	},
	function create()
	{
		this.m.ID = "event.legends_troubadour_and_juggler";
		this.m.Title = "During camp...";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]As sparks rise from the fire, %juggler% is stretching and adopting various acrobatic poses. %troubadour% approaches and adopts some of the positions along side the juggler. %SPEECH_ON% These movements remind me of the theater troupe I used to perform in. Playing at fighting and love needs tight timings and positioning, to know your spacing as well as your lines. Do you know the faked dagger pass? The trust fall? What of the stage dive? %SPEECH_OFF% \n\n The juggler laughs and replies. %SPEECH_ON%I have been practicing them for years troubadour, shall we dance? %SPEECH_OFF% The two rise and begin conducting a series of moves you have not seen before. One turning their back to the other and then falling into their arms, before trading places. They grow faster and faster at this blind falling, before the juggler turns midair and the fall becomes a tumble. Soon both are tumbling, through each others arms, and spinning around each other. It becomes a blur of arms, legs and objects moving between them. They begin passing things back and forth, first a ball, then a rock, then a knife. Before long there are items hurling through the air, most caught, but some bouncing off through the camp.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Not standard training, but it will do",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Troubadour.getImagePath());
				this.Characters.push(_event.m.Juggler.getImagePath());
				local r = this.Math.rand(0, 20);
				local tmdef = _event.m.Troubadour.getCurrentProperties().getMeleeDefense();
				local jmdef = _event.m.Juggler.getCurrentProperties().getMeleeDefense();
				local avgmdef = this.Math.floor((tmdef + jmdef) / 2);
				if (r > avgmdef)
				{
					r = this.Math.rand(1, 5);
					if (r == 1)
					{
						this.List.push(::Legends.EventList.changeMeleeDefense(_event.m.Troubadour, 1));
						_event.m.Troubadour.getSkills().update();
					}

					if (r == 2)
					{
						this.List.push(::Legends.EventList.changeMeleeSkill(_event.m.Troubadour, 1));
						_event.m.Troubadour.getSkills().update();
					}

					if (r == 3)
					{
						local injury = _event.m.Troubadour.addInjury(this.Const.Injury.BluntBody);
						this.List.push({
							id = 10,
							icon = injury.getIcon(),
							text = _event.m.Troubadour.getName() + " suffers " + injury.getNameOnly()
						});
					}

					else
					{
						local injury = _event.m.Troubadour.addInjury(this.Const.Injury.PiercingBody);
						this.List.push({
							id = 10,
							icon = injury.getIcon(),
							text = _event.m.Troubadour.getName() + " suffers " + injury.getNameOnly()
						});
					}
				}
				else
				{
					local r;
					r = this.Math.rand(1, 8);

					if (r == 1)
					{
						this.List.push(::Legends.EventList.changeRangedDefense(_event.m.Juggler, 1));
						_event.m.Juggler.getSkills().update();
					}

					if (r == 2)
					{
						this.List.push(::Legends.EventList.changeRangedSkill(_event.m.Juggler, 1));
						_event.m.Juggler.getSkills().update();
					}

					if (r == 3)
					{
						local injury = _event.m.Troubadour.addInjury(this.Const.Injury.BluntBody);
						this.List.push({
							id = 10,
							icon = injury.getIcon(),
							text = _event.m.Troubadour.getName() + " suffers " + injury.getNameOnly()
						});
					}

					if (r == 4)
					{
						local injury = _event.m.Troubadour.addInjury(this.Const.Injury.PiercingBody);
						this.List.push({
							id = 10,
							icon = injury.getIcon(),
							text = _event.m.Troubadour.getName() + " suffers " + injury.getNameOnly()
						});
					}

					local brothers = this.World.getPlayerRoster().getAll();
					foreach( bro in brothers )
					{
						if (bro.getID() == _event.m.Troubadour.getID() || bro.getID() == _event.m.Juggler.getID())
						{
							continue;
						}
						local r;
						r = this.Math.rand(1, 20);

						if (r == 1)
						{
							this.List.push(::Legends.EventList.changeRangedDefense(bro, 1));
							bro.getSkills().update();
						}

						if (r == 2)
						{
							local injury = bro.addInjury(this.Const.Injury.Archery);
							this.List.push({
								id = 10,
								icon = injury.getIcon(),
								text = bro.getName() + " suffers " + injury.getNameOnly()
							});

						}
					}

				}

			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates_troubadour = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.minstrel" && bro.getGender() == 1)
			{
				candidates_troubadour.push(bro);
			}
		}

		if (candidates_troubadour.len() == 0)
		{
			return;
		}

		local candidates_juggler = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.juggler")
			{
				candidates_juggler.push(bro);
			}
		}

		if (candidates_juggler.len() == 0)
		{
			return;
		}

		this.m.Troubadour = candidates_troubadour[this.Math.rand(0, candidates_troubadour.len() - 1)];
		this.m.Juggler = candidates_juggler[this.Math.rand(0, candidates_juggler.len() - 1)];
		this.m.Score = (candidates_troubadour.len() + candidates_juggler.len()) * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"troubadour",
			this.m.Troubadour.getNameOnly()
		]);
		_vars.push([
			"juggler",
			this.m.Juggler.getName()
		]);
	}

	function onClear()
	{
		this.m.Troubadour = null;
		this.m.Juggler = null;
	}

});
