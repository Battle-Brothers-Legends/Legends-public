::mods_hookExactClass("events/events/deserter_in_forest_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_25.png[/img]While trundling through the forest, birds suddenly scatter into the sky, shaking the trees and branches with the very frightful urgency of their leaving. Not a moment later does a figure come barreling through a bush, looking more flash flood than flesh and blood. The frightened human seizes up, this dirty earthen golem, and begs you for a place to hide.%SPEECH_ON%Look, I\'ll be perfectly honest. I\'m a deserter. That\'s that. I didn\'t, I mean, alright I don\'t really have a defense. But look, what are you? Mercenaries? Great! Hide me and I\'ll fight for you to the end of time!%SPEECH_OFF%Halfway through the pleading spiel, you hear dogs barking in the distance. The deserter instinctively hides away into an arboreal cubby, quickly covering over with dirt. The dirt pile nods as if to say you\'ve already come to an agreement.\n\n Bounty hunters come through the tree line, their dogs already sniffing around. Their lieutenant looks around.%SPEECH_ON%Don\'t even try to fool me, sellsword. I know that deserter came this way. Two hundred crowns for the head. Where is the wretch?%SPEECH_OFF%";
				s.Options[0].Text = "Right there.";
			}
			if (s.ID == "B") {
				s.start <- function ( _event ) {
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
					{
						_event.m.Dude.getFlags().add("PlayerSkeleton");
						_event.m.Dude.getFlags().add("undead");
						_event.m.Dude.getFlags().add("skeleton");
						_event.m.Dude.setStartValuesEx([
							"legend_cannibal_background"
						]);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.RacialSkeleton);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendFleshless);
					}
					else
					{
						_event.m.Dude.setStartValuesEx([
							"deserter_background"
						]);
					}
					_event.m.Dude.getBackground().m.RawDescription = "You found %name% the deserter being chased through the forest. Though bounty hunters were hot on the trail, you elected to defend the fugitive and for that swore an oath to you.";
					_event.m.Dude.getBackground().buildDescription(true);
					this.Characters.push(_event.m.Dude.getImagePath());
				}
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_25.png[/img]You nod to where the deserter is hiding, who must have kept one distrusting eye on you because the mess of dirt immediately jumps out of the hole and goes fleeing. The dogs run the deserter down with ease, glomming on with caninal ferocity and dragging the screaming ass to the ground. Before you can even so much as laugh, the bounty hunter puts a bag of crowns into your palm.%SPEECH_ON%That\'s half my cut, but without the happenstance of your being here, I\'m not sure we would have caught that wily dastard.%SPEECH_OFF%";
			}
		}
	}
})
