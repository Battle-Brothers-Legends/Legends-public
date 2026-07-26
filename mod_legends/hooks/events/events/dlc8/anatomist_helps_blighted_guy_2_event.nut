::mods_hookExactClass("events/events/dlc8/anatomist_helps_blighted_guy_2_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_58.png[/img]{The supposedly diseased %person_militiacaptain% the anatomists had rescued from the literal grave comes forward. %They_militiacaptain%\'s looking better than ever. %They_militiacaptain% thanks the anatomists for their work, though they regard %them_militiacaptain% with barely any notice at all. It seems %they_militiacaptain% was of more interest to them when %they_militiacaptain% was ill, and they could poke and prod and learn from that which ailed %them_militiacaptain%, and there was some unspoken hope that %they_militiacaptain% would in fact die so they could learn even more. Seeing this, the %person_militiacaptain% then turns to you.%SPEECH_ON%It\'s all much appreciated, I hope at least you know that. You don\'t know what hells I\'ve been through with that lot who tried to bury me alive. I think they knew I wasn\'t no blight, they just wanted my property. See, I used to head the local militia, but that position comes with the weight of conspiracy and jealousy.%SPEECH_OFF%%They_militiacaptain% rubs the back of %their_militiacaptain% head, then comes out with it.%SPEECH_ON%I\'ve nothing else after those gravediggers done taken it all so regardless of whether I\'m alive or dead, I may well be of the latter. So, well, let me just say I\'m glad to be fighting for you and making myself a new living out here.%SPEECH_OFF%}";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.MilitiaCaptain.getImagePath());
					local bg = ::Legends.Backgrounds.new(::Legends.Background.Militia);
					bg.m.IsNew = false;
					local oldPerkTree = _event.m.MilitiaCaptain.getBackground().m.CustomPerkTree;
					_event.m.MilitiaCaptain.getSkills().removeByID(::Legends.Backgrounds.getID(::Legends.Background.Vagabond));
					_event.m.MilitiaCaptain.getSkills().add(bg);
					_event.m.MilitiaCaptain.getBackground().m.RawDescription = "You found %name% being buried alive for carrying some unknown blight. The anatomists took interest in %them% and rescued %them%, nursing %them% back to health. Now, %they% fights for you, putting to use the skills that made %them% captain of the guard in a previous life.";
					_event.m.MilitiaCaptain.getBackground().buildDescription(true);
					_event.m.MilitiaCaptain.getBackground().rebuildPerkTree(oldPerkTree);
					_event.m.MilitiaCaptain.resetPerks();
					_event.m.MilitiaCaptain.improveMood(1.0, "Recovered from the blight afflicting him");

					if (_event.m.MilitiaCaptain.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.MilitiaCaptain.getMoodState()],
							text = _event.m.MilitiaCaptain.getName() + this.Const.MoodStateEvent[_event.m.MilitiaCaptain.getMoodState()]
						});
					}

					this.List.push(::Legends.EventList.changeMeleeDefense(_event.m.MilitiaCaptain, 4));
					this.List.push(::Legends.EventList.changeRangedDefense(_event.m.MilitiaCaptain, 4));
					this.List.push(::Legends.EventList.changeMeleeSkill(_event.m.MilitiaCaptain, 8));
					this.List.push(::Legends.EventList.changeRangedSkill(_event.m.MilitiaCaptain, 7));
					this.List.push(::Legends.EventList.changeFatigue(_event.m.MilitiaCaptain, 3));
					this.List.push(::Legends.EventList.changeInitiative(_event.m.MilitiaCaptain, 6));
					this.List.push(::Legends.EventList.changeResolve(_event.m.MilitiaCaptain, 12));
					this.List.push(::Legends.EventList.changeHitpoints(_event.m.MilitiaCaptain, 5));
				}
			}
		}
	}
})
