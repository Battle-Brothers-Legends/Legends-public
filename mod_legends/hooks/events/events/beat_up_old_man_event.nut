::mods_hookExactClass("events/events/beat_up_old_man_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					this.List.push(::Legends.EventList.changeMoralReputation(-1, false));
				}
			}
		}
	}
})
