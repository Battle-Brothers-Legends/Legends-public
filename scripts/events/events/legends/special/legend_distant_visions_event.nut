this.legend_distant_visions_event <- this.inherit("scripts/events/event", {
	m = {
		Bro = null
	},
	function create()
	{
		this.m.ID = "event.legend_distant_visions";
		this.m.Title = "Along the road...";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "This event is currently missing flavor text. Your brother %bro% has granted you 1 use of Distant Visions. The next town you hover your mouse over will display the current town events in the tooltip, regardless if you\'ve visited the town or not.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Be careful with the cursor!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		local Characters = [];

		foreach( bro in this.brothers )
		{
			if (bro.getSkills().hasPerk(::Legends.Perk.LegendDistantVisions))
			{
				Characters.push(bro);
			}
		}

		if (Characters.len() != 0)
		{
			this.m.Bro = Characters[this.Math.rand(0, Characters.len() - 1)];
		}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"bro",
			this.m.Bro.getName()
		]);
	}

	function onClear()
	{
	}

});

