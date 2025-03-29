this.legend_camp_unlock_scrap <- this.inherit("scripts/events/event", {
	m = {
		TownName = ""
	},
	function create()
	{
		this.m.ID = "event.legend_camp_unlock_scrap";
		this.m.Title = "At %townname%";
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_camp_scrap.png[/img]",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Scrapping unlocked in camp",
					function getResult( _event )
					{
						this.World.Flags.set("HasLegendCampScraping", true);
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
		local text = "While perusing some equipment you could only hope to afford in your dreams, the smith enters the room carrying a large crate. ";
		text = text + "He lugs it to the counter and drops it with a heavy wooden thud and a cacophony of metal clatters. ";
		text = text + "You wonder aloud about what is inside and the smith, seemingly taken aback by your curiosity, ";
		text = text + "explains that the market was trying to pass off a bunch of junk as weapons and armor. ";
		text = text + "He goes on to say that he bought it with intent to salvage so he could use the scraps to repair some equipment brought in by another patron. ";
		text = text + "With your curiosity sated, you leave with new ideas in your head.";
		text = text + "\n\n";
		text = text + this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Workshop).getDescription();
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

