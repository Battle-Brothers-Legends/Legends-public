this.legends_minstrel_and_juggler_event <- this.inherit("scripts/events/event", {
	m = {
		Minstrel = null,
		Juggler = null
	},
	function create()
	{
		this.m.ID = "event.legends.minstrel_and_juggler";
		this.m.Title = "During camp...";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]Around the fire and among the drinks, %minstrel% the minstrel boasts to %juggler%.%SPEECH_ON%Oh ye tumbling fool, ye twirling baffoon! You claim to be so accurate to throw a knife betwixt the hairs on a poor sods head! You could never hit me! I, I have much experience dodging thrown objects, from rotten fruit to womens underwear, i've dodged it all in my time on stage. You could never hit me!%SPEECH_OFF% In one swift motion %minstrel% dodges as %juggler%\'s hands are quick to throw a knife. Another follows, and then another, before long the camp is strewn with thrown objects as they throw and dodge.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "An epic for all the wrong reasons!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Minstrel.getImagePath());
				this.Characters.push(_event.m.Juggler.getImagePath());
				local r = this.Math.rand(0, 20);
				local rdef = _event.m.Minstrel.getCurrentProperties().getRangedDefense();
				if (r > rdef)
				{
					local r;
					r = this.Math.rand(1, 2);
					if (r == 1)
					{
						this.List.push(::Legends.EventList.changeRangedDefense(_event.m.Minstrel, 1));
						_event.m.Minstrel.getSkills().update();
					}
					else
					{
						local injury = _event.m.Minstrel.addInjury(this.Const.Injury.Archery);
						this.List.push({
							id = 10,
							icon = injury.getIcon(),
							text = _event.m.Minstrel.getName() + " suffers " + injury.getNameOnly()
						});
					}
				}
				else
				{
					local r;
					r = this.Math.rand(1, 3);
					if (r == 1)
					{
						this.List.push(::Legends.EventList.changeRangedSkill(_event.m.Juggler, 1));
						_event.m.Juggler.getSkills().update();
					}

					local brothers = this.World.getPlayerRoster().getAll();
					foreach( bro in brothers )
					{
						if (bro.getID() == _event.m.Minstrel.getID() || bro.getID() == _event.m.Juggler.getID())
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

		local candidates_minstrel = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.minstrel" && bro.getGender() == 0)
			{
				candidates_minstrel.push(bro);
			}
		}

		if (candidates_minstrel.len() == 0)
		{
			return;
		}

		local candidates_juggler= [];

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

		this.m.Minstrel = candidates_minstrel[this.Math.rand(0, candidates_minstrel.len() - 1)];
		this.m.Juggler = candidates_juggler[this.Math.rand(0, candidates_juggler.len() - 1)];
		this.m.Score = (candidates_minstrel.len() + candidates_juggler.len()) * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"minstrel",
			this.m.Minstrel.getNameOnly()
		]);
		_vars.push([
			"juggler",
			this.m.Juggler.getName()
		]);
	}

	function onClear()
	{
		this.m.Minstrel = null;
		this.m.Juggler = null;
	}

});
