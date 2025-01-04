::mods_hookExactClass("events/events/crisis/civilwar_trapped_soldiers_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				local startB = s.start;
				s.start <- function (_event) {
					startB(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
				}
			}
			if (s.ID == "C") {
				local startC = s.start;
				s.start <- function (_event) {
					startC(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases"
					});
				}
			}
			if (s.ID == "D") {
				local startD = s.start;
				s.start <- function (_event) {
					startD(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
				}
			}
		}
	}
})
