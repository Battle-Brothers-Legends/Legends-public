::mods_hookExactClass("events/events/dlc2/monk_crafts_holy_water_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]{%monk% the modest holy figure enters your tent with a vial in hand. The flask is topped with a bark stopper and a wreath of greenery with berries hanging beneath the leaves. Inside the vial is a goldish liquid sloshing about. Whatever it is, it catches any glimpse of light and seems to capture it and swirl it around. It is held out.%SPEECH_ON%Blessed water, sir, to fight the dead that walk again.%SPEECH_OFF%You ask if it\'s a gift from the old gods and are greeted with a nod. You ask if it\'s really a gift from the old gods, though. Through pursed lips the reply comes .%SPEECH_ON%No, not exactly. The monasteries know how to make it, but it is an ancient recipe protected under penalty of death.%SPEECH_OFF%Of course. You offer thanks for taking such a risk to contribute and instruct it be put in the inventory.}";
				s.Options[0].Text = "Even the holy have tricks of the trade.";
			}
		}
	}
});
