::mods_hookExactClass("events/events/dlc6/gladiators_food_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_155.png[/img]{The Gladiators demand better food.%SPEECH_ON%I\'m sorry, \'captain\', but what would you have me do with this?%SPEECH_OFF%%gl% holds up a loaf of bread.%SPEECH_ON%Where\'s the meat? Look at it. LOOK. At it. Who made this? A baker? You want me to a baker\'s loaf? I want to eat that which fights back. Does bread fight back? I don\'t think so.%SPEECH_OFF%It seems the Gladiators might be far from the arena, but not far from the coddled treatment the chefs there gave day in and day out. Perhaps you should seek a variety of high quality food to keep them quelled. | %SPEECH_START%Where is the good stuff, huh?%SPEECH_OFF%%gl% holds up a piece of a meal. It is stringy and flops around in his hand.%SPEECH_ON%This is not the food of gladiators, it is the food of wimps!%SPEECH_OFF%With a turn the food is thrown and it slaps against the side of the company wagon where it unsticks and then curls over like an upside down hook.%SPEECH_ON%We demand good food, captain! None of this gamey shit.%SPEECH_OFF%You should probably look into getting the gladiators food that is more to their standards. | %SPEECH_START%Where\'s the wine? Where are the delicatessens!%SPEECH_OFF%%gl% takes a plate of food and throws it like a disc. It goes impressively far, bits of food spraying off in a cone of caloric debris.%SPEECH_ON%I demand delicatessens, captain! Where are my delicatessens?%SPEECH_OFF%It seems the gladiators require food of finer qualities.}";
			}
		}
	}
})
