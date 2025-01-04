::mods_hookExactClass("events/events/crisis/greenskins_caravan_ambush_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "AftermathB") {
				local startB = s.start;
				s.start <- function (_event) {
					startB(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases"
					});
				}
			}
			if (s.ID == "AftermathC") {
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
		}
	}
})
