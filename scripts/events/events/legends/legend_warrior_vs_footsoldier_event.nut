this.legend_warrior_vs_footsoldier_event <- this.inherit("scripts/events/event", {
	m = {
		noble1h = null, //shield
		noble2h = null //2 hander
	},
	function create()
	{
		this.m.ID = "event.legend_warrior_vs_footsoldier"; //—
		this.m.Title = "During camp..."; //footsoldier gets more attack, warrior gets more def
		this.m.Cooldown = 75.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]You walk out of your tent to see %noble1h% and %noble2h% in deep discussion with one another and trading point after counterpoint about this and that. While the two warriors have known each other for some time, this discussion goes beyond the usual pleasantries. The two fighters verbally size each other up again, and start on a new thread of discussion. %SPEECH_ON%So, how come you\'d rather not use a shield anyhow? I use \'em all the time and it does me no harm.%SPEECH_OFF%%noble2h% thumbs their jaw for a moment before retorting. %SPEECH_ON%Never really liked the idea of hidin\' behind a slab of wood an\' metal. What you need is less of this prancin\' about and more just hittin\' something one real hard and making sure it stops movin\' after the fact.%SPEECH_OFF%%noble1h% seems confused. %SPEECH_ON%Right. But aren\'t you just a little bit concerned about bein\' hit? With all those squishy bits you got and barely anythin\' \'between?%SPEECH_OFF% %SPEECH_ON% Oh I am, but a wise man once tol\' me that if you get somethin\' in you enough you get \'arder to kill — \'munity it is called. Or somthin\' like that.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I don\'t think that\'s how that works...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.noble1h.getImagePath());
				this.Characters.push(_event.m.noble2h.getImagePath());

				this.List.push(::Legends.EventList.changeMood(_event.m.noble1h, 1.0, "Bonded with " + _event.m.noble2h.getName()));
				this.List.push(::Legends.EventList.changeMeleeSkill(_event.m.noble1h, ::Math.rand(3, 5)));

				this.List.push(::Legends.EventList.changeMood(_event.m.noble2h, 1.0, "Bonded with " + _event.m.noble1h.getName()));
				this.List.push(::Legends.EventList.changeMeleeDefense(_event.m.noble2h, ::Math.rand(3, 5)));

				_event.m.noble1h.getSkills().update();
				_event.m.noble2h.getSkills().update();
			}
		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local noble1h_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.legend_noble_shield")
			{
				noble1h_candidates.push(bro);
			}
		}

		if (noble1h_candidates.len() == 0)
		{
			return;
		}

		local noble2h_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.legend_noble_2h")
			{
				noble2h_candidates.push(bro);
			}
		}

		if (noble2h_candidates.len() == 0)
		{
			return;
		}

		this.m.noble1h = noble1h_candidates[this.Math.rand(0, noble1h_candidates.len() - 1)];
		this.m.noble2h = noble2h_candidates[this.Math.rand(0, noble2h_candidates.len() - 1)];
		this.m.Score = (noble1h_candidates.len() + noble2h_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"noble1h",
			this.m.noble1h.getNameOnly()
		]);
		_vars.push([
			"noble2h",
			this.m.noble2h.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.noble1h = null;
		this.m.noble2h = null;
	}

});

