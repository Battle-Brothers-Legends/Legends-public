::mods_hookExactClass("events/events/come_across_burial_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "C") {
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					this.List.push(::Legends.EventList.changeMoralReputation(-1, false));
				}
			}
			if (s.ID == "D") {
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					this.List.push(::Legends.EventList.changeMoralReputation(-3, false));
				}
			}
			if (s.ID == "E") {
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					this.List.push(::Legends.EventList.changeMoralReputation(5, false));
				}
			}
		}
	}
})
