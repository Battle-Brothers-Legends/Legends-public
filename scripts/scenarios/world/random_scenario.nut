this.random_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.random";
		this.m.Name = "(Random Pick)";
		this.m.Description = "[p=c][img]gfx/ui/events/event_74.png[/img][/p][p]Start a campaign with a randomly picked origin. How exciting![/p] [p]Tip: move the scroll bar slowly to view all scenarios[/p]";
		this.m.Difficulty = 0;
		this.m.Order = 0;
	}



});

