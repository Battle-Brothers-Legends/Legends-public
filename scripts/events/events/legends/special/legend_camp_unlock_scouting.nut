this.legend_camp_unlock_scouting <- this.inherit("scripts/events/event", {
	m = {
		TownName = ""
	},
	function create()
	{
		this.m.ID = "event.legend_camp_unlock_scouting";
		this.m.Title = "At %townname%";
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_camp_scout.png[/img]",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Patrol unlocked in camp.",
					function getResult( _event )
					{
						this.World.Flags.set("HasLegendCampScouting", true);
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function getText()
	{
		local text = "{On the outskirts of %townname%, you pass a local guard force on patrol. ";
		text = text + "You over hear them talking about a camp they came upon where they found everyone slaughtered... ";
		text = text + "Something about how they were all caught unaware because they had no one on patrol.}";
		text = text + "\n\n";
		text = text + this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Scout).getDescription();
		return text;
	}

	function setTownName( _v )
	{
		this.m.TownName = _v;
		this.m.Screens[0].Text += this.getText();
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

