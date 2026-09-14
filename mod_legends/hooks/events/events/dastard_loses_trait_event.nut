::mods_hookExactClass("events/events/dastard_loses_trait_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_58.png[/img]You come across %braveman1% and %braveman2% sitting with %dastard%. The two mercenaries are pepping up the rather skittish %sibling_dastard%, letting %them_dastard% know that there is nothing to fear in battle. %dastard% explains that %they_dastard% is fearful of a painful death. %braveman1% says %they_braveman1% has seen many people die and by the sword, truly, is one of the fastest. %braveman2% raises %their_braveman2% hand.%SPEECH_ON%Unless it gets you in the stomach.%SPEECH_OFF%%braveman1% nods.%SPEECH_ON%Right. But other than that, you have nothing to fear!%SPEECH_OFF%";
			}
		}
	}
})
