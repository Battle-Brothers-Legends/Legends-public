this.legend_sisterhood_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_sisterhood_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
	   		Text = "[img]gfx/ui/events/event_24.png[/img] The world is a brutal and unfair place, to that we all agree.\n\nBut during times of war, some have it worse than others.\n\nWhen the levyman came to the village last Spring the excuses of broken farmers and lazy craftsman fell on deaf ears. The tax had to be paid - if not in gold, then in produce!\n\nBut what happens when the produce fails? When the grain rots in the silos? When the artisans clumsily spoil one too many weapons?\n\nWhen the noble society sees no gold or offerings from the levymen, a price of blood must be paid.\n\nThis price is a fate far worse than death or execution - they take the men from their homes, some as young as fifteen, and march them to the nearest fort to be trained to kill another man.\n\nThey give us crowns, of course, to placate us for the loss of our sons, brothers and husbands. But the levyman always returns to take the crowns back weeks later as \'tribute\'.\n\nThe crowns and men never come back...\n\nOur husbands, brothers and children rot in ditches or are cut to pieces by wild animals. The ones that try to return home end up hanging from some nobleman\'s gallows.\n\nNo more.\n\nThe countless widows and wise women will see our banner and flock to it. No more will we simply wait for raiders and noblemen to come for us - we will come to them, and they will not find us wanting!",
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
		this.m.Title = "The Sisterhood";
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