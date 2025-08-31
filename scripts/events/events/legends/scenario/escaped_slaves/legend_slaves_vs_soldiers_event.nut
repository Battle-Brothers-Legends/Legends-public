this.legend_slaves_vs_soldiers_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_slaves_vs_soldiers";
		this.m.Title = "During camp...";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_06.png[/img]{Shouting and yelling pulls you away from counting inventory. You find the mercenaries scuffling among themselves, with former indebted on one side and the more combat-oriented freefolk of the company on the other. It seems both groups claim the other lacks commitment to the company. The sellswords say the former slaves only see the %companyname% as a means of staying alive, and that they\'d cut and run at a moment\'s notice.%SPEECH_ON%You don\'t care about the rest of us, or the company at all! All you lot ever have on your minds is your own skin. How am I supposed to trust you to watch my back in battle?%SPEECH_OFF%The Indebted, conversely, claim their counterpart\'s greed hinders them from true loyalty.%SPEECH_ON%You who\'ve never felt the lash in your lives will never understand what the company means to us! This is the only place we can truly be free, but you\'d all leave in a heartbeat if you were shorted a single crown\'s pay!%SPEECH_OFF%A fistfight cuts the argument short. You break up the mercenaries before it gets more serious, reminding them that they can show their true commitment by fighting the enemy, not each other. | The former Indebted are arguing with the more career-minded freefolk of the company over matters of loyalty.%SPEECH_ON%How can we trust you when the only thing you fight for is coin? The company is our path to freedom, but for you it\'s just a payday!%SPEECH_OFF%One of the soldiers counters.%SPEECH_ON%Aye, well the way I see it, you\'re just here for survival. For some of us, the company is more than a group of bodyguards keeping us alive, it\'s a way of life. Not that I\'d expect someone harping on and on about the evils of getting paid to do a job would understand.%SPEECH_OFF%A dustup ensues, and you have to pull the mercenaries away from each other before any serious injuries are inflicted. You\'re happy to have your company competing over who\'s more committed, but remind them that their actions on the battlefield will do more to impress you than fighting amongst themselves.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Why can\'t we all just get along?",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getSkills().hasTrait(::Legends.Trait.Loyal)) {
						bro.worsenMood(1.5, "Had his loyalty called into question");
					} else if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat)) {
						if (this.Math.rand(1, 100) <= 50) {
							bro.worsenMood(1.0, "Was accused of being too mercenary")
						}
					} else if (bro.getBackground().getID() == "background.slave") {
						if (this.Math.rand(1, 100) <= 50) {
							bro.worsenMood(1.0, "Was accused of using the company")
						}
					}

					if (bro.getMoodState() < this.Const.MoodState.Neutral) {
						this.List.push(::Legends.EventList.changeMood(bro));
					}

					if (this.Math.rand(1, 100) <= 40)
					{
						bro.addLightInjury();
						this.List.push({
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = bro.getName() + " suffers light wounds"
						});
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.legend_escaped_slaves")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() <= 5)
		{
			return;
		}

		local slaves = 0;
		local soldiers = 0;

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.slave")
			{
				slaves = ++slaves;
			}
			else if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat))
			{
				soldiers = ++soldiers;
			}
		}

		if (slaves <= 3 || soldiers <= 2)
		{
			return;
		}

		this.m.Score = this.Math.min(slaves, soldiers) * 2;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

