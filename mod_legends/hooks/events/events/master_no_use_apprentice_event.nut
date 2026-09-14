::mods_hookExactClass("events/events/master_no_use_apprentice_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "%townImage% While walking about %townname%, you run into an old man dragging a youthful %person_dude% by the ear.%SPEECH_ON%You want to be a master, it takes time! Blood! Sweat! Tears if yer of the cryin\' sort and there\'s no shame in that if ya are. Here, look! A sellsword! If you want to fight so bad, why not go to him?%SPEECH_OFF%You hold your hands out and ask for an explanation before getting offloaded some annoying git. The elderly man calms himself and lets the kid\'s ear go.%SPEECH_ON%Aye, I suppose you are owed more of an explanation. I\'m the fencing master of this town, but I teach discipline and patience before anyone so much can touch a sword! And this damned student of mine has neither! So I told %them_dude%, if you want to fight so bad, get the hell out!%SPEECH_OFF%You look at the kid. %They're_dude% got a fresh face, but there is in fact some impatient eagerness in %their_dude% eyes. You ask %them_dude% if what the swordmaster says is true. The kid nods.%SPEECH_ON%Yessir. And I\'d be more than happy to fight for you, too.%SPEECH_OFF%";
				s.Options[0].Text = "Alright, we\'ll take %them_dude%.";
				s.Options[1].Text = "No, thanks. %They're_dude% all yours.";
				s.start <- function ( _event ) {
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
					{
						_event.m.Dude.getFlags().add("PlayerSkeleton");
						_event.m.Dude.getFlags().add("undead");
						_event.m.Dude.getFlags().add("skeleton");
						_event.m.Dude.setStartValuesEx([::Legends.Background.Apprentice]);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.RacialSkeleton);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendFleshless);
					}
					else
					{
						_event.m.Dude.setStartValuesEx([::Legends.Background.Apprentice]);
					}

					_event.m.Dude.getBackground().m.RawDescription = "An impatient student of a Swordmaster, %name% didn\'t have the mental aptitude to stick with the trials and tribulations of becoming a master of the blade %themselves%. But what %they% lacks in mental fortitude %they% more than makes up for in effort. You \'hired\' %them% simply by taking %them% off the old man\'s hands.";
					_event.m.Dude.getBackground().buildDescription(true);
					this.Characters.push(_event.m.Dude.getImagePath());
				}
			}
		}
	}
});
