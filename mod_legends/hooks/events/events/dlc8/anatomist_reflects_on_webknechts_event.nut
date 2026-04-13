::mods_hookExactClass("events/events/dlc8/anatomist_reflects_on_webknechts_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_184.png[/img]{%anatomist% is holding out %their_anatomist% arm, watching a long-legged spider trundling across %their_anatomist% flesh. As the creature reaches the ends of its newfound earth, the anatomist turns %their_anatomist% arm, suggesting the spider continue on another way. %They_anatomist% does this for a time until putting %their_anatomist% fingers toward the ground and the spider shuffles off entirely, perhaps not ever once aware it was on a living being. The anatomist writes a few pages down in %their_anatomist% notes.%SPEECH_ON%The other day I watched a spider jump twenty-times its body length to snatch a fly. And this spider I\'ve let go would, upon seeing its prey, speed across the ground like a hunting dog. It seems that the old gods have taken pity on us, scapegrace, for neither of these creatures can be found in their larger, webknecht forms.%SPEECH_OFF%While being tackled and ripped apart would be quite terrible, you tell him that being wrapped in a cocoon before having your blood sucked out by fangs is undoubtedly worse. The anatomist raises a finger.%SPEECH_ON%A common misconception, scapegrace, for the webknecht actually prefers to feed long after you are deceased. We believe its toxins are designed to target the belly, opening it up and using its fluids to melt you from the inside out. This is presumably why they hang their prey upside down, so the toxins can slosh over the organs, turning you into a sort of sack of fluids. The consuming phase of the process is merely one of digesting whatever is left. The only time they don\'t eat you is if they\'re placing their brood inside you as the spiderlings will need sustenance upon hatching.%SPEECH_OFF%That still sounds infinitely worse than being shanked by a hunting spider, but either way you regret having the conversation and pursue it no further. Unfortunately, %otherbro% is nearby and has heard all too much...}";
			}
		}
	}
});
