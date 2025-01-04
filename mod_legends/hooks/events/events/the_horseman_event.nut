::mods_hookExactClass("events/events/the_horseman_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "C") {
				s.start = function ( _event ) {
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion") {
						_event.m.Dude.getFlags().add("PlayerSkeleton");
						_event.m.Dude.getFlags().add("undead");
						_event.m.Dude.getFlags().add("skeleton");
						_event.m.Dude.setStartValuesEx([
							"vagabond_background"
						]);
						_event.m.Dude.getSkills().add(this.new("scripts/skills/racial/skeleton_racial"));
						_event.m.Dude.getSkills().add(this.new("scripts/skills/traits/legend_fleshless_trait"));
					} else {
						_event.m.Dude.setStartValuesEx([
							"vagabond_background"
						]);
					}

					_event.m.Dude.setTitle("the Filly Fiddler");
					_event.m.Dude.getBackground().m.RawDescription = "You found %name% being whipped for \'involving\' himself with a dead horse. Hopefully that past is, er, behind him now.";
					_event.m.Dude.getBackground().buildDescription(true);
					_event.m.Dude.setHitpoints(30);
					_event.m.Dude.improveMood(1.0, "Satisfied his needs with a dead horse");
					_event.m.Dude.worsenMood(1.0, "Got whipped");

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
