::mods_hookExactClass("events/events/dlc2/spooky_forest_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_25.png[/img]While camping in the woods, %randombrother% calls you out of the command tent. You ask what it is and you see a finger to lips in a silent shush. %randombrother% points up a tree which grows tall into the evening darkness. You hear cracks as though something were making a nest out of branches whole. The noisemaker only pauses to snort and chortle in a quick tittering of guttural chirps, like a bird crying for help from the belly of a snake. When you look back down, the company are staring at you, looking for an idea as to what to do about this event.";
			}
			if (s.ID == "Lumberjack") {
				s.Text = "[img]gfx/ui/events/event_25.png[/img]You order %lumberjack% the lumberjack to bring the tree down. The mercenary nods and gets to work, using a host of tools available, not all of which are axes. The lumberjack plies the wood open in a divot on one side and jams the gaps with the helves of weapons and then goes to the other side and chops away at its trunk. The mercenary works with the sort of speed you\'d love to see on the battlefield. It\'s the sort of authenticity one rarely sees in life, someone who is home at work, eyes settled on modeling an undeniable future, hands hardly assigned to the task so much as born for it.%SPEECH_ON%Ay-yo!%SPEECH_OFF%The lumberjack yells out and the tree is felled. It cracks and slumbers down the heft and tilts into the forest where its long stock falls through the wickets and slams the ground so hard it seems to ache the very earth. Drawing your sword, you go to investigate the felled treetop. You find a pair of Nachzehrers there, smashed flat, teeth skittered to the forest floor like capless shrooms. The company\'s fear is settled by the grisly sight.";
			}
			if (s.ID == "Brave") {
				s.Text = "[img]gfx/ui/events/event_25.png[/img]%bravebro%, the ever brave sellsword, clambers up the tree with speed not to be erred by fear or reluctance. You\'d think they spotted a fair flirt up in those parts the speed of ascent. It isn\'t long until the mercenary is gone, though the scratch \'n\' scratch of his noisy ascent is unmistakable. Finally you hear returning sounds, the clutter of descent coming in stops and starts as finding safe footing. You see the mercenary break back into view. with boots first to appear like butter trays dangling in the dark. The rest of the shadowy silhouette follows, sliding ever downward until making a last leap to the earth. The mercenary intentionally buckles at the knees and rolls back against the tree trunk with tired hands limp across knees.%SPEECH_ON%T\'was a black bear head deep in a honeycomb, but the beast been dead at least two days. I saw a group of bats skitter on out when I approached, I think they was eating its insides. This tumbled on out when they fled.%SPEECH_OFF% The tired mercenary turns and throws a sword upon the ground. It\'s covered in sticky honey and pinestraw, but otherwise looks like a remarkable blade.";
			}
			if (s.ID == "CutdownGood") {
				s.Text = "[img]gfx/ui/events/event_25.png[/img]You order the company to chop the tree down. They get to the task, though there\'s little experience in doing it and the end result is a frantic run for safety as the trunk comes barreling down in an unexpected direction. A very frightened black bear bolts off the treetop. It has a honeycomb for a snout and huffs its way into the dark of the forest.\n\n No one is crushed, but the chaos and debris leaves a few of the mercenaries worse for the wear.";
			}
			if (s.ID == "CutdownBad") {
				s.Text = "[img]gfx/ui/events/event_25.png[/img]You order the company to cut the tree down. %randombrother% starts in with a heavy thwack, planting a foot on the trunk to wrench the tool free and that\'s about the last you see as the mercenary goes flying away. A tree branch swings back into view with a long groan emanating from the trunk as though some ancient wood were being felled inside its very body. You watch as the wood cracks loose of the soil and uproots itself. Emerald eyes flare and widen, their stare blinkered by the twists of falling leaves.";
			}
			if (s.ID == "WalkOff") {
				s.Text = "[img]gfx/ui/events/event_25.png[/img]You can\'t be bothered by such trivial nonsense. It\'s likely to be a lynx or an eagle of some sort. If it\'s worse, it\'ll come on down and the company will deal with it then. This line of thinking doesn\'t sit well with some of the company.";
			}
		}
	}
});
