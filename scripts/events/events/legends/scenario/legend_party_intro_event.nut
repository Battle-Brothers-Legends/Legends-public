this.legend_party_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_party_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_80.png[/img]The valley ahead lies wide and open, the breeze seems to carry the scent of opportunity. This unlikely crew was brought together out of a lust for gold, adventure, fame and power. With you are %bro1%, %bro2%, %bro3%, %bro4%, %bro5% and %bro6%, an unlikely group. There were tensions from the start, but each could respect the power the others held, and together you can take on bigger contracts and tougher enemies. Together they formed %companyname%.\n\n The lands are dangerous these times. Robbers and pillagers lay in ambush by the roads, wild beasts roam the dark forests and orc tribes are restless beyond the boundaries of civilization. There are rumors even of dark magic being at work, the dead rising from their graves and walking again. There is plenty of opportunity to earn good money, whether by taking on contracts you can find in the villages and cities all over the land, or by venturing out on your own to explore and raid.\n\nYour men look to you to give a command. They live and die for the %companyname% now.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "For glory!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "The " + this.World.Assets.getName();
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		_vars.push([
			"bro1",
			brothers[0].getName()
		]);
		_vars.push([
			"bro2",
			brothers[1].getName()
		]);
		_vars.push([
			"bro3",
			brothers[2].getName()
		]);
				_vars.push([
			"bro4",
			brothers[3].getName()
		]);
				_vars.push([
			"bro5",
			brothers[4].getName()
		]);
				_vars.push([
			"bro6",
			brothers[5].getName()
		]);
	}

	function onClear()
	{
	}

});

