::mods_hookExactClass("events/events/dlc4/crisis/undead_boy_who_cried_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "Accept1A") {
				local startA = s.start;
				s.start <- function (_event) {
					startA(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
				}
			}
			if (s.ID == "Accept2A") {
				local start2A = s.start;
				s.start <- function (_event) {
					start2A(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
				}
			}
			if (s.ID == "Accept3B") {
				local start3B = s.start;
				s.start <- function (_event) {
					start3B(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
				}
			}
		}
	}
})
