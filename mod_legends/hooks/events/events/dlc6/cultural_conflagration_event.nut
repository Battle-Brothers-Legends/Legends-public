::mods_hookExactClass("events/events/dlc6/cultural_conflagration_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_175.png[/img]{Shouting and yelling drags you from counting inventory. You find a few of the mercenaries standing at opposite ends of the campfire pointing fingers and even a weapon or two. Seems there\'s a bit of a dustup over whose people are more beautiful: southerners or northerners. Ironically, the northerners are voting for the southerners and vice versa. A couple of stern commands brings order back to the company, but the tensions remain. | There\'s been a bit of fisticuffs between some of the company. Apparently, there was a disagreement about the marriage rites. The northerners believe it should be one and one, while the southerners prefer marrying as many as one can get their hands on. You tell the company to stop fighting like unmarried children and focus on the task at hand, which may or may not be to finish a job to get coin to then spend on a marriage, but that\'s neither here nor there. | A couple of the mercenaries get into it over some religious differences. Some conflict over the old gods and the Gilder, each mercenary a little ambassador of their faith, diplomatically putting fists into the opposition\'s faces. You tell them all to quit it and get their heads straight. If they want to argue over which gods are best, they can do it in the afterlife. | A couple of the mercenaries get into it over matters of... sand? It seems the northerners in the company are poking fun at the southerners, asking how stupid one would have to be to settle in a land with nothing but sand.%SPEECH_ON%Who looks around in a hot arse sandy dune and thinks, aye, this\'ll be my home. Bet you wish yer forefathers had a proper mind to realize there\'s more to the world than a gods damned forever sunburn.%SPEECH_OFF%This garners the first punch thrown. The scuffle has a few injured, but you get the company back to order, commanding them to keep their geographic opinions to themselves. | An argument breaks out when southerners in the company start poking fun at their northern\'s lack of articulation. One mimics with their hands splayed out at ears.%SPEECH_ON%We\'s all talks like this, aye, yessir, ain\'t y\'all ready to come on to somesuch sumbitch thing, aye? Ain\'t ain\'t ain-%SPEECH_OFF%Fisticuffs end the jestering. A few are bruised in the exchange, but you manage to break it up before it gets more serious. | Though normally dismissive of their overlords, the northerners and the southerners take to defending the lords and Viziers of their lands respectively. It seems the foil of having some cultural opposition has spurred heretofore unseen fealties. The arguments unwind into an actual fist fight, with not a lord around to be impressed, mind. You break it up, telling them the only one they should look to impress is either you or each other as comrades in battle.}";
			}
		}
	}
})
