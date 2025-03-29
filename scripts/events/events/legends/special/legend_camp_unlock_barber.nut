this.legend_camp_unlock_barber <- this.inherit("scripts/events/event", {
	m = {
		TownName = ""
	},
	function create()
	{
		this.m.ID = "event.legend_camp_unlock_barber";
		this.m.Title = "At %townname%";
		this.m.Cooldown = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_camp_barber.png[/img]As you approach %townname% all thoughts turn to the barber. Life on the road makes it hard to keep beard and hair in check and everyone is looking forward to a trim. As you walk by %randombrother% says,%SPEECH_ON%Barbering ain\'t so hard, we chop up more difficult things every day. I was asking the barber about it last time and he showed me some tricks. I bet with a chair and some scissors I could at least keep the hair from matting together.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Barbering unlocked in camp.",
					function getResult( _event )
					{
						this.World.Flags.set("HasLegendCampBarber", true);
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

