::mods_hookExactClass("events/events/minstrel_teases_deserter_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img] As the campfire crackles, %minstrel% the minstrel gets up and stands high on a stump. Beating their chest and pointing to %deserter%.%SPEECH_ON%Yo, yee man of such fleeting feet, feet that flee before you\'ve been beat! The deserter! Oh, the deserter! A dessert for the deserter! His courage he did curdle, his honor he did hurdle, his manliness he did murder! The deserter!%SPEECH_OFF%In one swift motion the minstrel claps hands and drops back down onto the seat. %minstrel%\'s only there for a moment before %deserter%\'s hands are around their neck. The company is an uproar, stuck somewhere between separating the two and succumbing to fits of manic laughter.";
			}
		}
	}
})
