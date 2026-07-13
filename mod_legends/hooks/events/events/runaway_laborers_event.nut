::mods_hookExactClass("events/events/runaway_laborers_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "B", function(_screen) {
			_screen.List.push({
				id = 10,
				icon = "ui/icons/asset_moral_reputation.png",
				text = "The company\'s moral reputation decreases slightly"
			});
		});
		::Legends.Screens.hook(this, "C", function(_screen) {
			_screen.start <- function ( _event ) {
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion") {
					_event.m.Dude.getFlags().add("PlayerSkeleton");
					_event.m.Dude.getFlags().add("undead");
					_event.m.Dude.getFlags().add("skeleton");
					_event.m.Dude.setStartValuesEx(this.Const.CharacterLaborerBackgrounds);
					::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.RacialSkeleton);
					::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendFleshless);
				} else {
					_event.m.Dude.setStartValuesEx(this.Const.CharacterLaborerBackgrounds);
				}

				this.Characters.push(_event.m.Dude.getImagePath());
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases slightly"
				});
			}
		});
		::Legends.Screens.hook(this, "D", function(_screen) {
			_screen.List.push({
				id = 10,
				icon = "ui/icons/asset_moral_reputation.png",
				text = "The company\'s moral reputation increases slightly"
			});
		});
		::Legends.Screens.hook(this, "E", function(_screen) {
			_screen.List.push({
				id = 10,
				icon = "ui/icons/asset_moral_reputation.png",
				text = "The company\'s moral reputation increases slightly"
			});
		});
	}
})
