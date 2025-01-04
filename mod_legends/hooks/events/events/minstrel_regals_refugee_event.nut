::mods_hookExactClass("events/events/minstrel_regals_refugee_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img] The company sits around a fire when %minstrel% the minstrel notices the refugee, %refugee%, sitting solemnly alone. Within but a moment, the minstrel is up, standing high on a stump, and waving arms wide.%SPEECH_ON%Lo\', the town of %refugee% was small, its place quaint, and its food, well, a little on the \'eh\' side. But ho\'! Were its people big! For here sits amongst our company one of its kin, the world after their spirit, death on their heels, yet here they be, and we\'ve but only thanks - and crowns! - to offer! Such is the price of this company, and such we are willing to give.%SPEECH_OFF%The minstrel sits back down and bows to the refugee. All of the %companyname% stands up and cheers, bringing a rare smile to %refugee%\'s face.";
			}
		}
	}
})
