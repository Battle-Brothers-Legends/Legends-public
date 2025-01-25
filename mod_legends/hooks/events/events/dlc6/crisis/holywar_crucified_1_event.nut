::mods_hookExactClass("events/events/dlc6/crisis/holywar_crucified_1_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "{[img]gfx/ui/events/event_161.png[/img]{In the middle of the desert wastes one has to be somewhat suspicious of anything they come across, especially if it\'s a lone figure on the road. The stranger sways from side to side as they drink the last of their water to talk. %SPEECH_ON%Although it may not look it, crownlings, I am one of the best healers and limb-hackers in these parts...%SPEECH_OFF% They sway a little more and take one last drink. %SPEECH_ON%My camp was overrun by knights from the north — I refused to abandon those in need but after they were killed in their beds, I had no choice but to run.%SPEECH_OFF%}";
				s.Options[0].Text = "And what now?";
			}
			if (s.ID == "B") {
				s.Text = "{[img]gfx/ui/events/event_161.png[/img]{The stranger nods.%SPEECH_ON%I know a few things about medicine — I know it is not in a crownling\'s nature to help others but I would surely be able to help you in the coming days of this war and beyond.%SPEECH_OFF%}";
				s.Options[1].Text = "I don\'t believe you. Keep walking.";
			}
			if (s.ID == "C") {
				s.Text = "{[img]gfx/ui/events/event_161.png[/img]{You reach for your belt and toss your waterskin to the half cooked stranger. They file in but will need some time to recover.}";
				s.Options[0].Text = "We could use someone who knows how to attach limbs for once.";
				s.start <- function ( _event )
				{
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					_event.m.Dude.setStartValuesEx([
						"legend_surgeon_background"
					]);

					::Legends.Effects.grant(_event.m.Dude, ::Legends.Effect.Exhausted);

					_event.m.Dude.setHitpointsPct(0.33);
					_event.m.Dude.improveMood(3.0, "Was rescued from the desert");
					this.Characters.push(_event.m.Dude.getImagePath());
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (bro.getEthnicity() == 0 && this.Math.rand(1, 100) <= 66) {
							bro.improveMood(1.0, "Saved a dying surgeon from the desert");

							if (bro.getMoodState() < this.Const.MoodState.Neutral) {
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						}
					}
				}
			}
			if (s.ID == "D") {
				s.Text = "{[img]gfx/ui/events/event_150.png[/img]{You tell the stranger to keep walking, casually thumbing the direction behind you from where you came. The stranger, half cooked in the heat mutters something under the breath and continues in the direction you came from.}";
				s.Options[0].Text = "A real surgeon? Not likely.";

			}
		}
	}
})
