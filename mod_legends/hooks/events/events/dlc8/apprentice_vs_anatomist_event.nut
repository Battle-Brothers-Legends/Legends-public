::mods_hookExactClass("events/events/dlc8/apprentice_vs_anatomist_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_05.png[/img]{You find %apprentice% the apprentice under the wings of %anatomist% the anatomist. It\'s a bit of a frightful sight, as you briefly wonder if the egghead is planning something nefarious. But %apprentice% is only learning things from %them_anatomist%, as %they_apprentice% is wont to do with most in the company. This time around it is not martial matters to which the anatomist is privy and the apprentice not, but instead methods of how to think, how to remember, and how to recall. You see %anatomist% tap %their_anatomist% own head.%SPEECH_ON%Now remember, the faintest of inks is infinitely stronger than the most incredible of minds. All that you remember, you write down, but also recall this: your mind shall remember things you think you\'ve forgotten. If in a moment of need, do not dwell on your thoughts, but let them come to the fore on their own, as they will usher themselves into the light without aid, but if sought they will only go deeper, and wish to be forgotten.%SPEECH_OFF%The apprentice nods attentively and takes notes. So long as these conversations stay within the bounds of not dissecting animals and questioning the old gods, you\'ve no real qualm about it.}";
		});
	}
});
