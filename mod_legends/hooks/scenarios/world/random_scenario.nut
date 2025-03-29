::mods_hookExactClass("scenarios/world/random_scenario", function (o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "[p=c][img]gfx/ui/events/event_74.png[/img][/p][p]Start a campaign with a randomly picked origin. How exciting![/p] [p]Tip: move the scroll bar slowly to view all scenarios[/p]";
	}
});

