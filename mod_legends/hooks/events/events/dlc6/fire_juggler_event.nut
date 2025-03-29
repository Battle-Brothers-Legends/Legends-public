::mods_hookExactClass("events/events/dlc6/fire_juggler_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_163.png[/img]{A fire juggler has the eyes of everyone in a plaza of %townname%. He\'s got a trip-set of torches with bronze handles. His routine goes fairly well, but he does drop a torch at one point which raises some jeers in return. The next act he is to place a board over an open barrel of oil and then juggle the torches, arms out at his sides, except now with five torches instead of three.\n\nIn summary, his next act seems to be one of suicide and he unsurprisingly looks reluctant to follow through with it. But the crowd continues to cheer and jeer, no doubt snorting and huffing like a wolf pressing a deer to the cliffside, and the juggler, wide-eyed looks around for some form of escape.}";
			}
		}
	}
})
