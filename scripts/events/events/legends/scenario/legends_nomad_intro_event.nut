this.legends_nomad_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legends_nomad_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({ // — 
			ID = "A",
			Text = "[img]gfx/ui/events/event_161.png[/img]{Life used to be more simple, as it should be — however, the outsider in your camp suggests otherwise. Clad in the fine robes and waxed armour of the city states, panting for water after days in the desert.\n It has been nine days since the ambush tore apart his caravan and send him meandering across the hostile land that gives you shelter. He has forgotten his path and made himself weak. The outsider drinks the second skin of water, almost choking himself in the process as the rest of the tribe unpitch their tents. The Viziers in their gleaming towers have taken much from you, and in return you will take much from them.\n You gaze outwards at the rising sun, grains of sand have passed through the hourglass, the desert shrinks.\n\nThe city states cling to their machines, explosives and inventions as if it will save them from the slow and steady assault of nature. Their inhabitants grow fat and listless like the goats they slaughter.\nThe way of the interloper is a simple one, but with such simplicity comes the risk that you\'d be branded outcasts and hunted by those who see you as a threat. As the stone creeps across the sands your people have begun to starve and the few hidden oasises that remain have been claimed by desperate beasts displaced from their homes.\n\nPerhaps it is time to accept your dwindling fate? Or will you foresake your traditions and submit to the work of the petty men atop their golden thrones and become a crownling? Or worse — turn away from your roots and move north to look for a better life?\nThe conscript snorts once more, and picks up his crude weapon. He will suffice, for now.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Much work to be done...",
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
		this.m.Title = "The Lost Tribe";
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}


});

