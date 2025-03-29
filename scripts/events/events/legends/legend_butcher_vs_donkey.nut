this.legend_butcher_vs_donkey <- this.inherit("scripts/events/event", {
	m = {
		Butcher = null,
		Donkey = null
	},
	function create()
	{
		this.m.ID = "event.legend_butcher_vs_donkey";
		this.m.Title = "During camp...";
		this.m.Cooldown = 7.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_06.png[/img]You come around the tents to find %butcher% looming around %donkey%, the donkey is busy grazing and pays no heed to the human nearby. %butcher% seems to have not noticed you and begins edging towards %donkey%. From your vantage point you can make out a large blade hidden begind the butcher\'s back, and you hear a muttering. %SPEECH_ON%That\'s right, nothing to see here. Keep feeding those juicy little rump cuts and ribs. You may have plenty of food, but the rest of us could use a roast!%SPEECH_OFF% As the butcher leans closer, the donkey notices something awry and kicks out towards the butcher before running off to safety behind you.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I need to get the men something to eat.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				if (this.Math.rand(1, 100) <= 70)
				{
					local injury1 = _event.m.Butcher.addInjury(this.Const.Injury.Accident1);
					this.List.push({
						id = 10,
						icon = injury1.getIcon(),
						text = _event.m.Butcher.getName() + " suffers " + injury1.getNameOnly()
					});
				}
				else
				{
					_event.m.Butcher.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Butcher.getName() + " suffers light wounds"
					});
				}

				_event.m.Butcher.worsenMood(0.5, "Kicked by the " + _event.m.Donkey.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Butcher.getMoodState()],
					text = _event.m.Butcher.getName() + this.Const.MoodStateEvent[_event.m.Butcher.getMoodState()]
				});
				_event.m.Donkey.worsenMood(1.0, "Frighten for his death");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Donkey.getMoodState()],
					text = _event.m.Donkey.getName() + this.Const.MoodStateEvent[_event.m.Donkey.getMoodState()]
				});
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (this.World.Assets.getFood() > 0)
		{
			return;
		}

		if (brothers.len() < 2)
		{
			return;
		}

		local Butcher_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.butcher")
			{
				Butcher_candidates.push(bro);
				break;
			}
		}

		if (Butcher_candidates.len() == 0)
		{
			return;
		}

		local Donkey_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.legend_donkey")
			{
				Donkey_candidates.push(bro);
			}
		}

		if (Donkey_candidates.len() == 0)
		{
			return;
		}

		this.m.Butcher = Butcher_candidates[this.Math.rand(0, Butcher_candidates.len() - 1)];
		this.m.Donkey = Donkey_candidates[this.Math.rand(0, Donkey_candidates.len() - 1)];
		this.m.Score = (Butcher_candidates.len() + Donkey_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"donkey",
			this.m.Donkey.getName()
		]);
		_vars.push([
			"butcher",
			this.m.Butcher.getName()
		]);
	}

	function onClear()
	{
		this.m.Donkey = null;
		this.m.Butcher = null;
	}

});

