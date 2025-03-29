this.legend_crusader_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_crusader_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({ //•
			ID = "A",
			Text = "[img]gfx/ui/events/event_24.png[/img]The bishop had told you the world was dying due to the sins of man, that the end of days is upon us. The dark ones come and only the furious justice of piety can hold it back. Since then you have journeyed across the lands to find the root of the infection, to stem the tide of the plague.\n The more of the world you see, the worse it looks. The corruption is spreading, you've followed its tendrils back to its source, here in these lands you will find the cause.\n\n Your faith cannot falter, for you bear the torch into the yawning darkness. The day of reckoning approaches, you must finish your preparations.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "What awaits humanity in the darkest corners of the world?",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
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
		this.m.Title = "The Dying Light";
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
