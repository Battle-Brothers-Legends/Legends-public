::mods_hookExactClass("events/events/farmer_old_tricks_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_82.png[/img]You find %farmhand% sitting beside the company wagon. Rolling some boomstraw between their teeth, gritting it here and there and spitting out the flakes. You ask what they're thinking about. The farmer shrugs.%SPEECH_ON%What my pa told me about baling hay. He had this method of turning the wrist at the catch and again at the release. Never could get the second part right.%SPEECH_OFF%The mercenary takes the straw out and flicks it. You ask.%SPEECH_ON%But you could get the first part right? Where ya stab the hay and yank?%SPEECH_OFF% They nod. You tell the mercenary they only need the first part of that technique to properly gut a man. You watch as their face glows with realization.%SPEECH_ON%Yeah... yeah that\'s right! Why didn\'t I think of that before? Yer a genius, sir! I\'ll try it our next go out! It\'ll just be like baling hay!%SPEECH_OFF%With a lot more screaming and bleeding, but sure.";
			}
		}
	}
})
