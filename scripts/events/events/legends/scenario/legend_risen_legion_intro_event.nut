this.legend_risen_legion_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_risen_legion_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_73.png[/img]You firmly pinch the weathered page in your hands.%SPEECH_ON%The Empire is rising once more, you must lead them to glory...%SPEECH_OFF% Your socketless eyes rise from the the top of the letter, fixing themselves on the messenger. You look through them, in both a literal and figurative sense — despite being unable to show emotion, he shifts uneasily.\nYour attention draws back to the page.\n %SPEECH_ON%Your orders are as follows:\n Lay waste to any and all works of the enemy.\n Seek out and cut down their scouts.\n Sow confusion where possible.\n\n We will be expecting news of your success soon, we assume you have not already engaged the enemy.\n\n Glory to the Emperor. %SPEECH_OFF% The screams come back into focus once again. The pyres burn higher into the sky as more chairs, tables and corpses are added. Some still live, weeping and frozen in fear as you pass by. The messenger primes a quill and paper, ready to take a message back.\n\n You kneel at the fire, a distant feeling of warmth is expected, but does not materialise. Hacking at a burnt body, you take the child's arm — blistered and marked by the fire, and wrap it in the original letter as a butcher does for meat. The messenger shows a grim understanding, and makes their journey back to the north.\n\n You need everyone to see this — and they will.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Orders are orders...",
				function getResult( _event ) {
					local locations = ::World.EntityManager.getLocations().filter(@(idx, loc) loc.getTypeID() == "location.black_monolith");
					if (locations.len() > 0) {
						local monolith = locations[0];
						this.World.uncoverFogOfWar(monolith.getTile().Pos, 700.0);
						monolith.getFlags().set("IsEventLocation", true);
						monolith.setDiscovered(true);
						this.World.getCamera().moveTo(monolith);
					}
					return 0;
				}
			}],
			function start( _event ) {
				this.Banner = "ui/banners/" + ::World.Assets.getBanner() + "s.png";
			}

		});
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
		this.m.Title = "The Endless March";
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});
