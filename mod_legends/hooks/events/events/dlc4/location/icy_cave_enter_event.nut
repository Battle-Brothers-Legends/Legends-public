::mods_hookExactClass("events/events/dlc4/location/icy_cave_enter_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A1") {
				s.start <- function ( _event ) {
					_event.m.Title = "As you approach...";
					local raw_roster = this.World.getPlayerRoster().getAll();
					local roster = [];

					foreach( bro in raw_roster )
						if (!bro.isInReserves())
							roster.push(bro);

					roster.sort(function ( _a, _b ) {
						if (_a.getXP() > _b.getXP())
							return -1;
						else if (_a.getXP() < _b.getXP())
							return 1;
						return 0;
					});
					local e = this.Math.min(4, roster.len());

					for (local i = 0; i < e; i++) {
						local bro = roster[i];
						this.Options.push({
							Text = "I need you to scout ahead, " + bro.getName() + ".",
							function getResult( _event ) {
								_event.m.Champion = bro;
								return "B";
							}
						});
					}
					this.Options.push({
						Text = "We should leave this place.",
						function getResult( _event ) {
							if (this.World.State.getLastLocation() != null)
								this.World.State.getLastLocation().setVisited(false);
							return 0;
						}
					});
				}
			}
		}
	}
})
