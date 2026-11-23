::mods_hookExactClass("events/events/shortsighted_shoots_bro_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_10.png[/img] You take a good, long look at the mercenaries, a gaze that flickers from one to the other and then back again, all the while shaking your head. %shortsightedtarget% is holding %their_otherguy% head, a rather large lump cresting at the hairline. %They_otherguy% looks at %shortsighted% then to you. Both sellswords shrug. You ask %shortsighted% what happened. %They_shortsighted% explains.%SPEECH_ON%Thought I saw somethin\' that wasn\'t there.%SPEECH_OFF%Incredulously, %shortsightedtarget% throws %their_otherguy% hand out.%SPEECH_ON%I said, \'Hey, it\'s me\' and you clocked me anyway.%SPEECH_OFF%Throwing out %their_shortsighted% own hands, %shortsighted% defends %themselves_shortsighted%.%SPEECH_ON%\'Hey it\'s me\' aren\'t words beholden to ya! Anyone can say them words! I reckon anyone ill-willed would say them very words before putting me to the sword, I bet ya!%SPEECH_OFF%It appears that %shortsighted%\'s poor eyesight has led to something of an accident.";
		});
	}
})