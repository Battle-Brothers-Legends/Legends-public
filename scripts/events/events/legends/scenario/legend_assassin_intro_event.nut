this.legend_assassin_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_assassin_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({ //—
			ID = "A",
	   		Text = "[img]gfx/ui/events/event_51.png[/img]When a dying man in the desert takes his first sip from an oasis, does he not feel anguish when the pool runs dry?\n Does a starving vagrant feel remorse when the last crumb of food has disappeared from their hands?\n Does a loyal soldier feel remorse for killing an evil man?\n\n No. Of course not. They feel anger — anger driven by ambition.\n\n Ambition and greed drives all things - from the trappings of nobility to the wolves that scavenge from the carcasses of the dead on the battlefield. As more hands grab and pull at what the land has to offer, the more it gives to appease the crowd.\n Above all, placid animals turn feral when desperate — which is a mistake you shall not make again.\n\n Your target lies dead, yes. But so does the second assassin sent by your employer to finish you off. With your payment likely in the wind, you take what you can from the hands of your target and the hidden pockets of your assassin. While work of your kind is hard to come by it crosses your mind that seeking a crowd is better than being stuck alone against the odds.\n\n You throw some chairs around the room and sweep the tables of their contents onto the hard floor. The one sent to displace you will pass for you at a glance, but it won't protect you forever — nothing ever will. ",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Onwards!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.logInfo("Unlocking training");
				this.World.Flags.set("HasLegendCampTraining", true);
				this.logInfo("Unlocking scouting");
				this.World.Flags.set("HasLegendCampScouting", true);
			}
		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "The Beginning Of The End";
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"home",
			this.World.Flags.get("HomeVillage")
		]);
	}

	function onClear()
	{
	}

});
