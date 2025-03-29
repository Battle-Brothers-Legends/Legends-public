::mods_hookExactClass("events/events/crisis/civilwar_conscription_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "C") {
				local start = s.start;
				s.start <- function(_event) {
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases"
					});
					start(_event);
				}
			}
		}
	}
})
