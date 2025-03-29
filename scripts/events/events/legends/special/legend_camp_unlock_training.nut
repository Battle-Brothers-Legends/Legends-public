this.legend_camp_unlock_training <- this.inherit("scripts/events/event", {
	m = {
		TownName = ""
	},
	function create()
	{
		this.m.ID = "event.legend_camp_unlock_training";
		this.m.Title = "At %townname%";
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_camp_train.png[/img]",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Training unlocked in camp.",
					function getResult( _event )
					{
						this.World.Flags.set("HasLegendCampTraining", true);
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
		local text = "{As you leave %townname% the talk is of the training hall. Each mercenary claims they are more skilled than the next, ";
		text = text + "and will prove it in the training hall. Some claim they are more skilled than the trainer himself. ";
		text = text + "As you walk %randombrother% says %SPEECH_ON%Each time we come here I talk to the trainer. It don\'t take much to train, ";
		text = text + "the weight of your body and some sticks is enough. I bet we could train ourselves and save some coin.%SPEECH_OFF%}";
		text = text + "\n\n";
		text = text + this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Training).getDescription();
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

