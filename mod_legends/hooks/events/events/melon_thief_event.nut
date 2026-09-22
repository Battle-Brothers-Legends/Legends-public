::mods_hookExactClass("events/events/melon_thief_event", function (o) {
	o.isValid <- function () {
		this.onClear();
		this.onUpdateScore();
		return this.m.Town != null;
	}

	local create = o.create;
	o.create = function () {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "E") {
				s.start <- function (_event) {
					_event.m.Dude = ::World.getTemporaryRoster().create("scripts/entity/tactical/" + (::World.Assets.getOrigin().getID() == "scenario.legend_risen_legion" ? "legend_player_legion" : "player"));
					_event.m.Dude.setStartValuesEx([::Legends.Background.Thief], true, 0);

					_event.m.Dude.setTitle("the Melon Mugger");
					_event.m.Dude.getSprite("head").setBrush("bust_head_03");
					_event.m.Dude.getBackground().m.RawDescription = "%name% is just a regular melon thief - is what you tell people who ask.";
					_event.m.Dude.getBackground().buildDescription(true);
					_event.m.Dude.improveMood(1.0, "Satisfied his needs with a melon");
					_event.m.Dude.worsenMood(0.5, "Almost got tarred and feathered");

					if (_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) != null) {
						_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand).removeSelf();
					}

					if (_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Offhand) != null) {
						_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Offhand).removeSelf();
					}

					if (_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Head) != null) {
						_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Head).removeSelf();
					}

					this.Characters.push(_event.m.Dude.getImagePath());
				}
			}
		}
	}
})
