::mods_hookExactClass("events/events/dlc4/raiders_origin_redemption_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/relations.png",
						text = "Your relations to " + _event.m.NobleHouse.getName() + " improve"
					});
				}
			}
		}
	}
})
