::mods_hookExactClass("events/events/raid_farmstead_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "C", function(_screen) {
			_screen.List.push(::Legends.EventList.changeMoralReputation(-1, false));
		});
		::Legends.Screens.hook(this, "D", function(_screen) {
			_screen.List.push(::Legends.EventList.changeMoralReputation(-2, false));
		});
		::Legends.Screens.hook(this, "E", function(_screen) {
			_screen.List.push(::Legends.EventList.changeMoralReputation(-5, false));
		});
	}
})
