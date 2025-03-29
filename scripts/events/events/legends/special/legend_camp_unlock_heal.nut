this.legend_camp_unlock_heal <- this.inherit("scripts/events/event", {
	m = {
		TownName = ""
	},
	function create()
	{
		this.m.ID = "event.legend_camp_unlock_heal";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_camp_heal.png[/img]There you were, minding your own business in the marketplace, shopping for supplies when two shop patrons started throwing fists over the last melon. One of the local monks was in the shop as well and took an unlucky elbow to the face. You picked up the monk and carried him to the local temple. In gratitude for your help, the monks showed you some basic skills for treating wounds that could come in handy!",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Healing unlocked in camp",
					function getResult( _event )
					{
						this.World.Flags.set("HasLegendCampHealing", true);
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function setTownName( _v )
	{
		this.m.TownName = _v;
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"townname",
			this.m.TownName
		]);
	}

});

