::mods_hookExactClass("events/events/dlc4/barbarian_tells_story_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img]{%barbarian% shares tales around the campfire of northern heroics and monsters. There can\'t be much said of the dialogue, given that brute isn\'t the most eloquent, but the story is well conveyed through miming and drawing in the ground. {One tale seems to be that of a huge warrior defeating a much larger warrior, or perhaps even defeating an ogre. It\'s hard to tell, but the barbarian makes a fascinating display of combat which the company applauds. | One tale is of two lovers, and with great use of waving hands, makes a riveting show of what it is to plough and be ploughed. And, apparently, what it is to be betrayed and stabbed in the back. You\'re not sure who is stabbing whom, nor when or in what sense, but the tale has the mercenaries on the edges of their seats and ends with applause. | One tale speaks to a friendly unhold. The company gasp at the very notion of it, but the barbarian slaps at wrists and wags a finger. This, you assume, is a way of telling you it\'s all true, every word or grunt. The idea of a friendly monster unsettles the mercenaries initially, but by the end of the story they clap and nod as though they wish it really were the truth.}";
			}
		}
	}
})
