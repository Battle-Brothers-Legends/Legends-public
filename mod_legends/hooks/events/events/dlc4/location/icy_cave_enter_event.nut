::mods_hookExactClass("events/events/dlc4/location/icy_cave_enter_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A1", function (_screen) {
			_screen.start <- function (_event) {
				_event.m.Title = "As you approach...";
				local raw_roster = this.World.getPlayerRoster().getAll();
				local roster = [];

				foreach (bro in raw_roster) {
					if (!bro.isInReserves()) {
						roster.push(bro);
					}
				}

				roster.sort(function (_a, _b) {
					if (_a.getXP() > _b.getXP()) {
						return -1;
					} else if (_a.getXP() < _b.getXP()) {
						return 1;
					}
					return 0;
				});
				local e = this.Math.min(4, roster.len());

				for (local i = 0; i < e; i++) {
					local bro = roster[i];
					this.Options.push({
						Text = "I need you to scout ahead, " + bro.getName() + ".",

						function getResult(_event) {
							_event.m.Champion = bro;
							return "B";
						}
					});
				}
				this.Options.push({
					Text = "We should leave this place.",

					function getResult(_event) {
						if (this.World.State.getLastLocation() != null) {
							this.World.State.getLastLocation().setVisited(false);
						}
						return 0;
					}
				});
			}
		});
		::Legends.Screens.hook(this, "B", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_144.png[/img]{%chosen% heads off while you and the rest work on the front of the cave. You knock a few of the thick icicles out letting you see into the cave with better eyes. Just as you do, %chosen% comes tumbling down an adjacent slope and lands right in the middle of the cave and slides across the frozen river and rides up its embankment. %They_champion% hops to %their_champion% feet and dusts %themselves_champion% off with a childish grin.\n\n In a flash the huddled man slams the pickaxe into the ice with unhinted power and the shards splinter from one side of the embankment to the other. The clank of the metal and shattered ice reverberates as though lightning itself had struck. Now you can finally see the stranger: he is a barbarian shelled in broken armor that rattles as he moves. The icy walls mirror his steps, scattering his presence all around the cave in transient sheens. Jittery and jutting, his walk is seemingly going backwards despite his advance as though his shadow were his true self and his flesh the afterimage. Despite being in a cave, his loud voice echoes not at all.%SPEECH_ON%An interloper in my midst, a mere moment from the mist, these things I shall not miss.%SPEECH_OFF%He approaches the sellsword like a cold spider unfurling from its trapdoor. You see that his face is half-frozen, and a wry smile squeezes across the half that could still be called flesh.%SPEECH_ON%I long to leave this body, my dear fighter. Will you help guide me out and to something higher?%SPEECH_OFF%}";
		});
		::Legends.Screens.hook(this, "Victory", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_144.png[/img]{%chosen% cuts the madman down. His chest armor shatters and flies off his body, chunks of plate spinning and warbling into the air and yet tethered together by some strange blue tendrils.\n\n Your men finally break through the icy cavern\'s entrance and slide down the declination. %chosen% is quite alright, nodding smugly as %they_champion% sheathes %their_champion% weapon.%SPEECH_ON%Just a crazy fuck, captain.%SPEECH_OFF%You crouch beside the body. Ice contorts half the flesh, twisting it into nubs of black, and what isn\'t frozen is flaked by strangely sparkling rime. Despite his grisly state, the mad man died with a wild grin still on his face. The eyes are a bright blue and you see yourself in their gaze, a faceless silhouette. And then the color slowly slips away, not like you\'ve seen before, but as though someone were dragging a curtain through a window, slowly sucking all color right into the sockets. The corpse grins at you, but you refuse to believe that is what you saw.\n\n One of the mercenaries picks up the mad man\'s bizarre armor and holds it at length.%SPEECH_ON%What do you figure this is?%SPEECH_OFF%The plates dangle from one another by some strange blue gelatin, and the insides of the metal slats are coated in bubbling, twirling blues as though it were the work of some celestial blacksmith. It is cool to the touch and gives beneath the slightest push of your finger. You\'ve never seen or felt anything like it, but the armor itself is currently in an unusable state. You have the goop and armor put into inventory, scour the cave for more goods which there are none. Before you leave the cave, you glance at the corpse one last time. You think you saw it move again, but surely it is the cold of the frozen north that is playing tricks on you.}";
		});
		::Legends.Screens.hook(this, "Defeat", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_144.png[/img]{Through the icicles you can see the madman cutting down %chosen%. Even as %they_champion% lies dead on the ground, the stranger continues to hack away at %them_champion%, and each time a muffled thump echoes through the cave. What will you do now?}";
		});
	}
})
