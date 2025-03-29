this.legend_camp_unlock_hunt <- this.inherit("scripts/events/event", {
	m = {
		TownName = ""
	},
	function create()
	{
		this.m.ID = "event.legend_camp_unlock_hunt";
		this.m.Title = "Along the way...";
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_camp_hunt.png[/img]",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Hunting unlocked in camp",
					function getResult( _event )
					{
						this.World.Flags.set("HasLegendCampHunting", true);
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
		local text = "You notice the food stocks are running low, perhaps it is time to camp and go hunting?";
		text = text + "\n\n";
		text = text + this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Hunter).getDescription();
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

