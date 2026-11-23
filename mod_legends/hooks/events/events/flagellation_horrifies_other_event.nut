::mods_hookExactClass("events/events/flagellation_horrifies_other_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_38.png[/img]Flesh torn asunder. Parts of %person_flagellant% rendered unfamiliar. A copper stench in the air. These are the things you find when beckoned by a %sibling_flagellant%\'s call.\n\n %flagellant% the flagellant stooped over on a stump, %their_flagellant% whole body unmoving save for %their_flagellant% arm which flicks a glass and thorn-peppered whip against %their_flagellant% own back. A gargling belch draws your eyes to %weakbro% who is bent over in the tall grass losing %their_otherguy% lunch. Sensing that %they_flagellant% is disturbing the others, %flagellant% cracks something of a smile that doesn\'t falter an inch to the horror %they're_flagellant% committing to %their_flagellant% own hide.%SPEECH_ON%Fear not the reaper, %weakbro%, I shall bleed even more in favor of saving your soul.%SPEECH_OFF%";
		});
	}
});
