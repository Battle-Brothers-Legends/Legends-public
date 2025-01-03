::mods_hookExactClass("events/events/gambler_vs_other_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_06.png[/img]{%gambler% and %nongambler% walk up to mottled with bruises. It appears they\'ve been in a bit of a scuffle. Seeing as how neither one is dead, you don\'t really care what it was over, but they tell you anyway.\n\nApparently the gambler took some money in a bit of sly cardsmanship. You ask either one if the company\'s money was involved. They say no. You ask what the hell they want from you then. | A game of cards comes to a table-flipping end when %nongambler% jumps off a stool and launches a tirade at %gambler%. The professional gambler looks around with sheepish incredulity. How could such a person come into so much money over a game of cards, the gambler asks, but when raising hands to feign confusion a few \'extra\' cards slip out of the gambler\'s sleeves. The ensuing battle is amusing, but you put a stop to it before anyone gets hurt.}";
			}
		}
	}
})
