::mods_hookExactClass("events/events/travelling_monk_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "E", function(_screen) {
			_screen.List.push(::Legends.EventList.changeMoralReputation(-2, false));
		});
	}
})
