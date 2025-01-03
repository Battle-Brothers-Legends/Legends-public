this.legends_free_company_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legends_free_company_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({ // — 
			ID = "A",
			Text = "[img]gfx/ui/events/event_79.png[/img]{You have come far in the recent years — what started as a party of battlefield scavengers grew into a capable militia, which blossomed into a professional mercenary outfit. You were not around when the company started or knew who started it. But all the same you were there in the frontline, bloody spear in hand fighting side by side.\n\n The nobility has started whispering the name of %companyname% in corridors and war rooms across the provinces — but just as you were about to break into bigger work, the company commander announced their retirement after one too many visits from the same woman at %randomtown% during camp.\n\n The company sits together over the dimming fire as dawn breaks from the horizon — what was intended to be a splitting of the wealth turned into longer, more complex talks about the future. After some time, everyone began to agree that with the work of nobles so close a new commander needed to be chosen.\n Votes were cast and you have unwittingly found yourself in charge of %companyname% and its holdings.\n\n Likely because nobody else can count or read as well as you can.}",
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
		this.m.Title = "The Free Company";
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}


});

