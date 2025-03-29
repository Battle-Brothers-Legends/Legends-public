this.legend_berserker_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_berserker_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
	   		Text = "[img]gfx/ui/events/event_12.png[/img]So tired. You have been walking for weeks and haven't slept in... too long. You stop and rest a moment, and the thoughts return. The wooden hut you built together. The plot of yams she had planted. The evening you returned from a hunt. They had come. Burned it all. The stores, the hut, the woman, the child. Their screams echo in your blood, calling you to avenge them. You should have been there in time. Her tortured last moments fill your mind. What they did to her was...  too unspeakable. The disgust and loathing well up again. What kind of filth could rape and kill a mother in front of her child? Your heart pounds now, cold sweat, the froth forms at the edge of your mouth. What kind of monster could then do those things to an infant child?  Your mind snaps at the memory of their broken bodies. You scream with unbridled rage. Your muscles push you on again, running blindly into another day. You must find the killers, those swine will know vengeance",
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
				this.logInfo("Unlocking hunting");
				this.World.Flags.set("HasLegendCampHunting", true);
				this.logInfo("Unlocking scouting");
				this.World.Flags.set("HasLegendCampScouting", true);
				this.logInfo("Unlocking gathering");
				this.World.Flags.set("HasLegendCampGathering", true);
			}
		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "Legend Berserker";
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