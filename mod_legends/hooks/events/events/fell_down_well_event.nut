::mods_hookExactClass("events/events/fell_down_well_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "Good") {
				s.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases"
				});
			}
			if (s.ID == "Bad") {
				s.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases slightly"
				});
			}
			if (s.ID == "Strong") {
				s.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases"
				});
			}
		}
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		local brothers = this.World.getPlayerRoster().getAll();
		if (brothers.len() == 1)
			return;
		onUpdateScore();
	}
})
