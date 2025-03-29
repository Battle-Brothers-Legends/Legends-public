::mods_hookExactClass("events/events/hedge_knight_vs_raider_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img]%raider% is sitting out beside the campfire, eyes set deep into the flames. A few moments ago, a couple of the company were heard yelling. A past as a raider isn\'t winning the mercenary many friends. The hedge knight, %hedgeknight%, walks over and stands there beside. As the two exchange glances, you\'re suddenly worried a fight you can\'t stop is going to break out. Instead, the hedge knight takes a seat and speaks calmly, with a deep voice that is still soundly scary.%SPEECH_ON%You raided coasts, yes? Killed women and children? Stole from the clergy?%SPEECH_OFF%The raider nods.%SPEECH_ON%Aye, and worse.%SPEECH_OFF%%hedgeknight% picks up a chunk of smoldering wood from the fire. The knight crushes it in their hand, the flames hissing into ash and smoke, then lets it crumble out of a calloused palm.%SPEECH_ON%You shouldn\'t mind what others say, raider. This is a nasty, hungry world, and you mind its teeth well. Let the weak cry out and die. We can only armor ourselves by our very being, wreathed in the envy of the dead who would gladly crush an infant\'s skull for a mere sip of the breath our lungs draw.%SPEECH_OFF%The raider grabs his own chunk of firewood and grinds it up. They shake hands and say nothing more.";
			}
		}
	}
})
