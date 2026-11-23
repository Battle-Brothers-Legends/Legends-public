::mods_hookExactClass("events/events/dlc2/lose_fear_greenskins_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_26.png[/img]{%fearful% is staring into the campfire and nodding as %they_casualty% mumbles to %themselves_casualty%. It\'s a worrisome sight, but almost on cue of that thought %they_casualty% speaks up.%SPEECH_ON%You know what? The greenskins ain\'t shit.%SPEECH_OFF%}";
		});
	}
});