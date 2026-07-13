::mods_hookExactClass("events/events/crisis/civilwar_conscription_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "C") {
				local start = s.start;
				s.start <- function(_event) {
					this.List.push(::Legends.EventList.changeMoralReputation(-3, false));
					start(_event);
				}
			}
		}
	}
})
