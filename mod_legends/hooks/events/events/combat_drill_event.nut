::mods_hookExactClass("events/events/combat_drill_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]You step out of your tent to survey the company. A great many of them are freshly hired grunts, nervously buddying up with one another or trying their hand at some of the weapons. %oldguard% comes to your side.%SPEECH_ON%I know what yer thinking. Yer thinking you\'d just hired a bunch of meat for a thresher. How about I whip these pups into shape so they don\'t eat an orcish blade their first go in the field?%SPEECH_OFF%";
				s.Options[0].Text = "Very well, see if you can teach them to fight one against one.";
			}
			if (s.ID == "B1") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]%oldguard% tells the recruits to take up weapons. When every single one of them picks up a sword, the old guard yells at them, stating that not every foe hankering for you being graveyard dead is gonna be wielding the exact same blade. A few nod before hurriedly exchanging their swords for axes and spears. With the crew equipped, the training begins. Mostly, %oldguard% teaches basics like how a formation makes it easier to defend not only one another, but also yourself.%SPEECH_ON%Ye need not watch corner-to-corner if ya know a brother is by yer side. But if yer separated, if yer all out there by yer lonesome, then ye might be proper farked lest ye got a heretofore unknown way with a blade which I\'ll go ahead and assume ye don\'t.%SPEECH_OFF%The training moves to offense where %oldguard% shows a few tricks with various weapons.%SPEECH_ON%With swords ye can slash, cut, stab, and riposte. Proper-hard to miss with a sword, given every side of it is a killin\' side. If I see any of you trying to cut down an arrow with a sword like the fairy tales told ya I\'mma beat ya down myself. It ain\'t true, so stop fancying it!\n\nSpears are good for keeping distance. They won\'t do much to armor, but they\'ll keep ya safe. Just point this sharp-end away from ya. If an armored brute gets past this pointy end here then yer probably proper farked so don\'t let that happen.\n\nFinally, there\'s the axe. Just pretend the enemy is a tree and cleave it so. Now let\'s practice!%SPEECH_OFF%";
			}
			if (s.ID == "B2") {
				s.Text = "[img]gfx/ui/events/event_50.png[/img]The training goes fairly well from there, though the mercenaries do come out the other side with a few bumps and bruises."
			}
			if (s.ID == "C2") {
				s.Text = "[img]gfx/ui/events/event_10.png[/img]The mercenaries take practiced shots downrange, the arrows peppering all around their targets, a scant few lucky ones going where they should. %oldguard% spends the rest of the day exhaustingly having the mercenaries shoot and shoot and shoot until luck is squeezed out of the equation altogether.";
			}
			if (s.ID == "D1") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]%oldguard% looses a sharp whistle, gathering the new recruits around. %oldguard% looks about, grinning, then nods.%SPEECH_ON%Alright ye limpwrist teatsucking noodlearm goatfarkers, we\'re going on a march!%SPEECH_OFF%The veteran spends the rest of the day ruthlessly running the recruits as far as possible until the last one drops from exhaustion.%SPEECH_ON%Breathe, little babe, breathe! Take it all in. There\'s plenty to go around for the rest of us, don\'t feel bad! Swallow it like yer mother should\'ve swallowed you. Now, I\'ve got stains that ran faster than the lot of ye, so I\'ll be seeing y\'all again tomorrow on good, proper time. That\'d be before the sun rises, shitsticks.%SPEECH_OFF%";
			}
			if (s.ID == "D2") {
				s.Text = "%oldguard% shows little mercy and has the mercenaries running again and again in the days to come. After all, %oldguard% says, it\'s for their own damn good.";
			}
		}
	}
})
