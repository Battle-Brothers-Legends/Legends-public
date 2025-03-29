this.legend_inquisition_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_inquisition_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_68.png[/img]A dark fog reigns over these lands. Petty nobility corrupted by the whispers of corrupting magics. Men driven to madness by the touch of forces beyond comprehension. As a youngling you never took the bishops word seriously, a day of seclusion in prayer ended with a return to the charred remains of his chapel. The sin of man came apparent when you saw the bishops charred corpse paraded by a mob of peasants on top of a pike. \n\n   You fled as far as you could, hoping to alert the baron to the situation. You broke through the brush to see pillars of smoke that reached the heavens. Several soldiers laid slain at your feet, their guts torn out and devoured by some unknown beast. Seeing no hope for salvation, you continued to run, and never stopped. You warned whoever would listen, but few heeded your call. Only the most devout and pious took your words seriously, and joined you on your new journey to continue what the bishop preached in a more \'hands on\' approach. \n\n You now find yourself in a new land, engulfed in a shadow war between heretical powers above comprehension. You and your band will drive out the darkness, rallying the faithful to your call. The pyres shall light with righteous flame, and you will help usher in a golden age of faith and purity amongst this realm.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Set Forth!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("HasLegendCampHealing", true);
			}
		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "The Inquisition";
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