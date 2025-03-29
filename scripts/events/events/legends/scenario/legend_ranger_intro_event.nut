this.legend_ranger_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_ranger_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_44.png[/img]The council sent us out three months ago, in all directions from the grove. They wouldn't tell us what we were looking for exactly, only that we would know the signs of destruction when we saw them.\n\n Before you can finish your thoughts a snapping of twigs and branches precedes a hulking mass barreling from the treeline. A bear almost double the height of your own lunges at your body, only to knock you off balance and down the slope. Pinecones batter your clothes and sharp branches lance your body. As the bear clumsily gives chase you spy a broken wall built into the bottom of the slope and make a leap for the platform above it.\n\n A sudden creak and snap reveals its true nature. This is not flat ground, this is a roof. A very old one at that.\n\n You fall with the grace of a drunk bird through the roof and onto a table where a very angry wildman locks eyes with yours. You motion for silence and the bear peers through the hole.\n With a huff the beast turns and goes in search of an easier meal.\n\n After a heated argument that almost comes to blows, you offer the disgruntled druid information on your cause. With a similar huff and snort the druid wanders towards the door, gathering what little they have along the way. Perhaps more ground can be covered with two of nature\'s guardians?",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Where did that bear go...?",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.logInfo("Unlocking fletching");
				this.World.Flags.set("HasLegendCampFletching", true);
				this.logInfo("Unlocking hunting");
				this.World.Flags.set("HasLegendCampHunting", true);
				this.logInfo("Unlocking scouting");
				this.World.Flags.set("HasLegendCampScouting", true);
			}
		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "A chance meeting";
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"home",
			this.World.Flags.get("HomeVillage")
		]);
	}

	function onClear()
	{
	}

});