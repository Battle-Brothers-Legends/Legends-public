::mods_hookExactClass("events/events/dead_lumberjack_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_25.png[/img]The forest is home to many curiosities and dead bodies, really, aren\'t even the most curious of those. So when you stumble upon a litter of dead lumberjacks the only thing that piques your interest is the lump of a direwolf slain beside them. %randombrother% eyes the tracks going back and forth across a cutting field so abruptly interrupted that some axes were left hewn into tree trunks. %They_randombrother% spits and nods.%SPEECH_ON%Poor fellas. Looks like some direwolves bushwhacked them something fierce.%SPEECH_OFF%You have the men collect what\'s left to be recovered and make your leave.";
		});
	}
});
