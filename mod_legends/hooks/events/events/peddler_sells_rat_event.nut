::mods_hookExactClass("events/events/peddler_sells_rat_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]%SPEECH_ON%For the last time, no, I won\'t buy a rat.%SPEECH_OFF%You see %ratcatcher% the ratcatcher turn a corner with the skeevy peddler %peddler% in pursuit. The salesman throws another pitch.%SPEECH_ON%\'Course you won\'t buy one! You\'re a ratcatcher, why would you buy one? But what if...%SPEECH_OFF%The ratcatcher stops and turns, planting a firm finger into the peddler\'s chest.%SPEECH_ON%Pet rats don\'t go grow on trees, %peddler%! They\'re born of a different stock! If I need a rat by my side I\'ll find it myself! Now, if you got a rat you need killin\', that\'s a different matter.%SPEECH_OFF%%peddler%\'s eyes fall to the ground, thinking for a moment. Suddenly, their gaze lifts along with their spirits and a pointing finger.%SPEECH_ON%Ah, a goldfish then? Would you buy a goldfish?%SPEECH_OFF%";
			}
		}
	}
})
