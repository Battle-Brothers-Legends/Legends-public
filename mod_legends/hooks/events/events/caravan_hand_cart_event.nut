::mods_hookExactClass("events/events/caravan_hand_cart_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_55.png[/img]You come across the once-caravan hand, %caravanhand%, finicking with the company wagon. %They_caravanhand%\'s nailing a slat of board to the bed and using pins to put it on a roller. The board can then drop down into the belly of the wagon with a little bit of a pull and switch. Rather ingenious. This will allow you to load more onto the wagon.";
			local start = _screen.start;
			_screen.start <- function (_event) {
				start(_event);
				::World.Flags.set(::Legends.Stash.Flags.CaravanHandEvent, 9);
				::Legends.Stash.resize();
			}
		});
	}
});
