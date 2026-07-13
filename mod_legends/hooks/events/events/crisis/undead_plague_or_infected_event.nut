::mods_hookExactClass("events/events/crisis/undead_plague_or_infected_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "C") {
				local startC = s.start;
				s.start <- function (_event) {
					startC(_event);
					this.List.push(::Legends.EventList.changeMoralReputation(3, false));
				}
			}
		}
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
			return;
		onUpdateScore();
	}
})
