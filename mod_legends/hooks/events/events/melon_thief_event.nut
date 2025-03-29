::mods_hookExactClass("events/events/melon_thief_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "E") {
				s.start <- function ( _event ) {
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
					{
						_event.m.Dude.getFlags().add("PlayerSkeleton");
						_event.m.Dude.getFlags().add("undead");
						_event.m.Dude.getFlags().add("skeleton");
						_event.m.Dude.setStartValuesEx([
							"thief_background"
						]);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.RacialSkeleton);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendFleshless);
					}
					else
					{
						_event.m.Dude.setStartValuesEx([
							"thief_background"
						]);
					}

					_event.m.Dude.setTitle("the Melon Mugger");
					_event.m.Dude.getSprite("head").setBrush("bust_head_03");
					_event.m.Dude.getBackground().m.RawDescription = "%name% is just a regular melon thief - is what you tell people who ask.";
					_event.m.Dude.getBackground().buildDescription(true);
					_event.m.Dude.improveMood(1.0, "Satisfied his needs with a melon");
					_event.m.Dude.worsenMood(0.5, "Almost got tarred and feathered");

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();

					this.Characters.push(_event.m.Dude.getImagePath());
				}
			}
		}
	}
})
