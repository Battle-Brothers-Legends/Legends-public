::mods_hookExactClass("events/events/crisis/civilwar_trapped_soldiers_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				local startB = s.start;
				s.start <- function (_event) {
					startB(_event);
					this.List.push(::Legends.EventList.changeMoralReputation(1, false));
				}
			}
			if (s.ID == "C") {
				local startC = s.start;
				s.start <- function (_event) {
					startC(_event);
					this.List.push(::Legends.EventList.changeMoralReputation(-2, false));
				}
			}
			if (s.ID == "D") {
				local startD = s.start;
				s.start <- function (_event) {
					startD(_event);
					this.List.push(::Legends.EventList.changeMoralReputation(-1, false));
				}
			}
		}
	}
})
