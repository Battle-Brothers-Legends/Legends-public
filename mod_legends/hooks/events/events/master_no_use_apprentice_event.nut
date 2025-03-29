::mods_hookExactClass("events/events/master_no_use_apprentice_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.start <- function ( _event ) {
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
					{
						_event.m.Dude.getFlags().add("PlayerSkeleton");
						_event.m.Dude.getFlags().add("undead");
						_event.m.Dude.getFlags().add("skeleton");
						_event.m.Dude.setStartValuesEx([
							"apprentice_background"
						]);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.RacialSkeleton);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendFleshless);
					}
					else
					{
						_event.m.Dude.setStartValuesEx([
							"apprentice_background"
						]);
					}

					_event.m.Dude.getBackground().m.RawDescription = "An impatient student of a Swordmaster, %name% didn\'t have the mental aptitude to stick with the trials and tribulations of becoming a master of the blade %themselves%. But what %they% lacks in mental fortitude %they% more than makes up for in effort. You \'hired\' %them% simply by taking %them% off the old man\'s hands.";
					_event.m.Dude.getBackground().buildDescription(true);
					this.Characters.push(_event.m.Dude.getImagePath());
				}
			}
		}
	}
});
