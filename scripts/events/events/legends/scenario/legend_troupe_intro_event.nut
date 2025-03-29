this.legend_troupe_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_troupe_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_92.png[/img]The slamming of the wagon door jolts you awake again. That is the fourth time tonight you fell asleep while waiting for your set. The long hours performing are only eclipsed by the days of practice beforehand.\n\nEach day you wake up and regret doing so. You practice, you eat, you practice some more and repeat until you either pass out or your set is up.\n\nAt the end of every week you shoulder together around a broken barrel and divide out the crowns. Comedians, dancers, musicians and playwrights are all degraded to beggars for a few moments as the coins tumble out of the purse of the theatre master.\n\nJust a few days ago you met a mercenary band on the road - their name slips your mind, but you remember sharing stories with one another. Your bravest moments and closest shaves on the stage paled in comparison to their battles.\n\nYou had spent what feels like a lifetime crafting stories to entertain the masses, but the greatest stories come not from sitting at a table perfecting your art, but from facing the darker side of the real world. How will you write about the first time you killed a man? What about the first beast you slew? How about a song of the loss of a friend in battle?\n\nAfter a night of staying wide awake you rise in the early hours of the morning, you have not slept at all, but you are more refreshed and inspired than you have felt in years.\nYou gather a few friends who wish to fuel their morbid and artistic curiosity. \n\nThe plan? Keep walking!\n\nAfter all, the mercenaries made it sound so simple. It surely can\'t be that hard...",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Set Forth!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("HasLegendCampHealing", true);
			}
		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "The Troupe";
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