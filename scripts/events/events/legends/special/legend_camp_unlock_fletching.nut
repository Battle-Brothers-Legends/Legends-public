this.legend_camp_unlock_fletching <- this.inherit("scripts/events/event", {
	m = {
		TownName = ""
	},
	function create()
	{
		this.m.ID = "event.legend_camp_unlock_fletching";
		this.m.Title = "Along the way...";
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_camp_fletcher.png[/img]",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Fletching unlocked in camp",
					function getResult( _event )
					{
						this.World.Flags.set("HasLegendCampFletching", true);
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
		local text = "Lolling around town in a bored stupor, you find yourself at the fletcher\'s shack. A few of the fletchers are toiling away at some dozen arrows and bolts, their movements almost hypnotic. One of them notices your staring and takes an opportunity to begin a conversation. You nod your head like a trained animal as he prattles on and on, your focus soley on his work. This too, he notices, and the droll chat turns to an impromptu lesson. Before you know it, he\'s finished his work and your head is full to bursting with facts about feathers and shafts.";
		text = text + "\n\n";
		text = text + this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Fletcher).getDescription();
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

