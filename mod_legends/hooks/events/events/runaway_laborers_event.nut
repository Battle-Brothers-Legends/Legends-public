::mods_hookExactClass("events/events/runaway_laborers_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "B", function (_screen) {
			_screen.List.push(::Legends.EventList.changeMoralReputation(-1, false));
		});
		::Legends.Screens.hook(this, "C", function (_screen) {
			_screen.start <- function (_event) {
				_event.m.Dude = ::World.getTemporaryRoster().create("scripts/entity/tactical/" + (::World.Assets.getOrigin().getID() == "scenario.legend_risen_legion" ? "legend_player_legion" : "player"));
				_event.m.Dude.setStartValuesEx(::Const.CharacterLaborerBackgrounds);

				this.Characters.push(_event.m.Dude.getImagePath());
				this.List.push(::Legends.EventList.changeMoralReputation(1, false));
			}
		});
		::Legends.Screens.hook(this, "D", function (_screen) {
			_screen.List.push(::Legends.EventList.changeMoralReputation(1, false));
		});
		::Legends.Screens.hook(this, "E", function (_screen) {
			_screen.List.push(::Legends.EventList.changeMoralReputation(1, false));
		});
	}
})
