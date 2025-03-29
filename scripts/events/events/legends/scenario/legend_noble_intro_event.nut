this.legend_noble_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_noble_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_24.png[/img]You were born to be a leader, raised in the company of the greatest men of our day. Somehow though, inheriting power doesn't feel as satisfying as seizing it for yourself. No, if one is to be king, it must be earned through battle and through the blood of one's subjects. Now, off to find some subjects willing to die for their betters.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "To arms!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				// this.logInfo("Making you well known");
				// this.World.Assets.addBusinessReputation(1000);
				this.logInfo("Making a noble house like you");
				//this.World.FactionManager.makeRandomNoblesFriendlyToPlayer();
				this.logInfo("Making a noble house hate you");
				//this.World.FactionManager.makeRandomNoblesUnfriendlyToPlayer();
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
		this.m.Title = "Legend Noble";
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