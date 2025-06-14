::mods_hookExactClass("events/events/flagellants_wounds_heal_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_39.png[/img]%flagellant% the flagellant is found sitting cross-legged before a campfire. %They_flagellant%\'s all alone save the millmoths fluttering dangerously close to the flames. Sensing your presence, %they_flagellant% calls you over. You take a seat beside %them_flagellant% and %they_flagellant% smiles at you.%SPEECH_ON%I\'ve become a better %person_flagellant% since joining this company.%SPEECH_OFF%You nod as %they_flagellant% surely has. %They_flagellant% continues.%SPEECH_ON%I\'ve bled for the gods a great deal, but my wounds... they are but scars now. I feel stronger than ever.%SPEECH_OFF%Again you nod, but then quickly ask if %they_flagellant% is going to stop hurting %themselves_flagellant%. The %person_flagellant%\'s eyes stare into the red-brimming embers. %They_flagellant% shakes %their_flagellant% head no.%SPEECH_ON%I will bleed for the gods until they say no more.%SPEECH_OFF%Wondering aloud, you ask if the gods have spoken to %them_flagellant% at all. Without a pause the %person_flagellant% shakes %their_flagellant% head no again.%SPEECH_ON%They have not and so I shall bleed until their silence is broken or until I join them in the forever quiet.%SPEECH_OFF%";
			}
		}
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function ( _vars )
	{
		onPrepareVariables(_vars);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Flagellant.getGender(), "flagellant");
	}
})
