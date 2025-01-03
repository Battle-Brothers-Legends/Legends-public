this.legend_greenskins_town_razed_event <- this.inherit("scripts/events/event", {
	m = {
		News = null
	},
	function create()
	{
		this.m.ID = "event.crisis.greenskins_town_razed";
		this.m.Title = "Along the road...";
		this.m.Cooldown = 7.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_94.png[/img]{Somber news on the road. Refugees and traders are reporting that %city% has been razed to the ground by the greenskins! If this keeps up, there shan\'t be a land to call home when it\'s all said and done. | You find a noble messenger watering his horse beside the path. He states that the greenskins have annihilated the human armies around %city% and razed the town itself! | You come across a cartographer and a trader with an empty cart. They\'re updating a map and there\'s something curious about it: the mapmaker is redrawing %city% on the paper. When you ask why, he raises an eyebrow.%SPEECH_ON%Oh, you haven\'t heard? %city%\'s been razed to the ground. Greenskins overran the defenses and killed everyone they got their hands on.%SPEECH_OFF% | You come across a trader on the path. His cart is emptied and missing some draught animals. There\'s blood on his face and clothes. You ask the man for his story. He straightens up.%SPEECH_ON%My story? No, it ain\'t my story. I was on my way to %city% only to find it overrun by greenskins. I barely escaped with my life. The town itself is done for. If that\'s the way you was headed, don\'t bother. It\'s gone. Completely gone.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Are we losing this war?",
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
	}

	function onUpdateScore()
	{
		if (!this.World.State.getPlayer().getTile().HasRoad)
		{
			return;
		}

		if (this.World.Statistics.hasNews("crisis_greenskins_town_razed"))
		{
			this.m.Score = 2000;
		}
	}

	function onPrepare()
	{
		this.m.News = this.World.Statistics.popNews("crisis_greenskins_town_razed");
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"city",
			this.m.News.get("City")
		]);
	}

	function onClear()
	{
		this.m.News = null;
	}

});

