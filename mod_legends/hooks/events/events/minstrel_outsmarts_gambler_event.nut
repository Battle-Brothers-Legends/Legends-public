::mods_hookExactClass("events/events/minstrel_outsmarts_gambler_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img] %gambler%, the mercenary with a gambling problem, has apparently gone around camp asking folk to play a game of horseshoes - with a few crowns on the line, of course. It appears that %minstrel%, the wily minstrel, has obliged and taken the bet. The musician claims to be pretty good at the game to which the gambler claims to be the best. \n\n The two heave horseshoes until their arms tire and the sun wanes. Nobody is the winner as the game can\'t move off of a tie. After another indecisive round, %minstrel% calls for a double-or-nothing round if they go left-handed. %gambler% agrees and goes first, throwing three horseshoes. The first two go haywire, but the third manages to spin around the ring. The gambler grins and wishes the minstrel good luck. %minstrel% nods and rolls up their sleeves, sticks out their tongue out and slims the eyes, lining up the shot. The minstrel's feet do a little tap-dance and just before throwing looks back and says,%SPEECH_ON%I should probably let you know that I *am* left-handed.%SPEECH_OFF%Without even looking forward, the minstrel lets loose a horseshoe. The throw is perfect, landing dead center about the stake, and the next two are tossed so quickly and so seamlessly that anybody watching erupts in hooting laughter. The gambler\'s mouth can only drop in disbelief.";
			}
		}
	}
})
