::mods_hookExactClass("events/events/dlc8/captured_oathbringer_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "C") {
				s.Text = "{[img]gfx/ui/events/event_05.png[/img]You nod.%SPEECH_ON%Torture him until his tongue points us to Young Anselm\'s jaw. I don\'t care how you do it, just do it.%SPEECH_OFF%Turning away, the prisoner screams out that Anselm would not approve. He then just starts screaming indiscriminately and eventually shouting out things that don\'t make a whole lot of sense. You retire to your tent, bouncing your foot to the screams that now take a rhythmic sort of wailing. Eventually, %randombrother% reappears. He has with him some weapons and armor you know weren\'t in inventory.%SPEECH_ON%He led us to a location that had these hidden away, but Anselm\'s jawbone is still missing. I\'m afraid the Oathbringers must have it in their own camp, but he wouldn\'t say where that was. We, uh, we had some difficulties communicating after we cut his tongue out.%SPEECH_OFF%Sighing, you ask where the prisoner is now. The man clears his throat.%SPEECH_ON%Oh he went all white and fell over. He\'s dead, sir.%SPEECH_OFF%We did right by Young Anselm, at least.}";
			}
		}
	}
})
