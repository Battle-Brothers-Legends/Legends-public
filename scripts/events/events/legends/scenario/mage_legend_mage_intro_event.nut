this.mage_legend_mage_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_seer_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_24.png[/img]The omens were in the stew, those giblets were roiling in the bubbles the way only a bad omen can. You tried to tell the farmers that the spirits had demanded a sacrifice, if only to reduce how many mouths there were to feed, but in the end they all blamed you when the crops failed. It is not your fault the gods are angry, there are bigger things at play here than your admidetly poor rain dancing, some daft fool has gone and poked their nose in that old deep magic. The wheel has turned, the cycles are in motion, there will be a lot more trouble in the world before the stars bode well again. In the meantime you might need to keep moving, you might not have a whole village bringing you sweet meat, but you made it out with enough coppers to at least find some apprentices to chop the wood and make tea",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Arise!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.logInfo("Unlocking gathering");
				this.World.Flags.set("HasLegendCampGathering", true);
				this.logInfo("Unlocking training");
				this.World.Flags.set("HasLegendCampTraining", true);
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "Legend Mage";
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

