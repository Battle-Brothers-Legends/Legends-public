::mods_hookExactClass("events/events/crisis/undead_outro_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]You wake. A rough wind bends the tent, curling the leather and rolling tides across the ceiling. Faint candlelight flicks and dashes darkness and light all the same. %dude% is standing there, watching you, shadows crossing back and forth across his chest. He shifts on his feet, an uneasy look on his face.%SPEECH_ON%Who were you talking to?%SPEECH_OFF%Rolling out of bed, you put your boots to the ground, wanting to be sure of this reality before you dare parlay with it. Dirt rustles and crunches beneath your feet. You answer.%SPEECH_ON%I\'m not sure. I think... I think the invasion is over.%SPEECH_OFF%The mercenary nods and turns a hand to the tent\'s entrance.%SPEECH_ON%Aye, that\'s why I\'m here. A noble messenger arrived just a minute ago. He says the undead have ceased erupting from the ground. The scribes believe it is over. Are you alright, sir?%SPEECH_OFF%You rub your head. Is it time to retire? What can you make of this world now that you know what you do? It is either go live out the rest of your days in peace, or say damn it all and command the %companyname% to further glory.\n\n%OOC%Something burns down inside of you. Something that struggles to be free. Perhaps it is the success you have have had along the way, or the failings that you couldn\'t stop in time. Maybe there is more out there to see?%OOC_OFF%";
			}
		}
	}
})
