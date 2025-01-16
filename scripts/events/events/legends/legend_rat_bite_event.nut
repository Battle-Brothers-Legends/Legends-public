this.legend_rat_bite_event <- this.inherit("scripts/events/event", {
	m = {
		Ratman = null,
		Bitten = null
	},
	function create()
	{
		this.m.ID = "event.legend_rat_bite";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_33.png[/img] You wake to a {piercing shriek | blood curdling scream | gutteral roar}, and run outside to find %bitten% holding a bloody wound, kicking and swearing at another mercenary while backing away. %SPEECH_ON% That beastly knave bit me! I woke to a giant rat gnawing on my {wrist|finger|thumb|hand}, i kicked it across the tent and by the time I stood up this bastard was in my tent%SPEECH_OFF%. He gestures to %ratman% who is looking guilty with a blood lined mouth. %SPEECH_ON% I don\'t know what happened sir, I was minding my own business when I started to feel a bit hungry.. I didn\'t mean to hurt anyone! %SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That is a poor meal",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Ratman.getImagePath());
				this.Characters.push(_event.m.Bitten.getImagePath());
				_event.m.Ratman.worsenMood(-0.5, "Hurt someone without realising");
				_event.m.Bitten.worsenMood(-1.0, "Was bitten ");

				if (_event.m.Bitten.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Bitten.getMoodState()],
						text = _event.m.Bitten.getName() + this.Const.MoodStateEvent[_event.m.NightOwl.getMoodState()]
					});
				}

				_event.m.Bitten.TherianthropeInfection(_event.m.Ratman);
				local injury = this.new("scripts/skills/injury/split_hand_injury");
				_event.m.Ratman.getSkills().add(injury);
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		// todo delete it - chopeks
//		if (!this.LegendsMod.Configs().LegendTherianthropyEnabled())
//		{
			return;
//		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local ratman_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasTrait(::Legends.Trait.Player))
			{
				continue;
			}

			if (bro.getBackground().getID() == "injury.legend_vermesthropy")
			{
				ratman_candidates.push(bro);
			}
		}

		if (ratman_candidates.len() == 0)
		{
			return;
		}

		local bitten_candidates = [];

		foreach( bro in brothers )
		{
			if (!bro.getBackground().getID() == "injury.legend_vermesthropy")
			{
				bitten_candidates.push(bro);
			}
		}

		if (bitten_candidates.len() == 0)
		{
			return;
		}

		this.m.Ratman = ratman_candidates[this.Math.rand(0, hedge_knight_candidates.len() - 1)];
		this.m.Bitten = bitten_candidates[this.Math.rand(0, this.raider_candidates.len() - 1)];
		this.m.Score = ratman_candidates.len() * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"ratman",
			this.m.Ratman.getNameOnly()
		]);
		_vars.push([
			"bitten",
			this.m.Bitten.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Ratman = null;
		this.m.Bitten = null;
	}

});

