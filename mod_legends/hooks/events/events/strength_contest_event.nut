::mods_hookExactClass("events/events/strength_contest_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_05.png[/img] %strong1% and %strong2% - the strongest mercenaries in the outfit by some measure - are apparently undertaking something of a competition to see who is the better. You watch as they carry enormous stones from one side of an ad hoc competitive ground to the other. Then they take turns seeing how far they can throw these very stones. And then they roll the stones up a nearby hill. And then they see who can completely bury a stone the fastest.\n\nAll in all, there are a lot of heavy stones being jostled about and by the end of the festive affair both sellswords are completely exhausted. Even without a winner, the time-honored tradition of moving rocks around to no real end has improved the company\'s morale.";
		});
	}
});
