this.legend_camp_unlock_gather <- this.inherit("scripts/events/event", {
	m = {
		TownName = ""
	},
	function create()
	{
		this.m.ID = "event.legend_camp_unlock_gather";
		this.m.Title = "Along the way...";
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_camp_gather.png[/img]",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Gathering unlocked in camp",
					function getResult( _event )
					{
						this.World.Flags.set("HasLegendCampGathering", true);
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
		local text = "On your way out of town, you pass by the herbalist\'s grove. An impressive expanse of colorful flowers and herbs lay before you, the surrounding air made almost oppresively antiseptic. You recognize some of the plants, a few of them grow wild on the countryside. You pause to make firm mental notes of the various herbs; the smells, the colors, the sheen of the leaves in the sunlight. Even if you remember a select few, it would be enough to concoct a couple amateur curatives.";
		text = text + "\n\n";
		text = text + this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Gatherer).getDescription();
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

