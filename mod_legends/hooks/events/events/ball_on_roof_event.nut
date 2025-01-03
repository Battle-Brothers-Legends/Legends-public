::mods_hookExactClass("events/events/ball_on_roof_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "Good") {
				s.Text = "[img]gfx/ui/events/event_97.png[/img]You send %otherbrother% to try and retrieve the ball. Using %otherother% as a stepstool, he launches himself onto the roof and gets the toy. The boy is ecstatic and the smile on his face warms even the most cynical of your mercenaries. \n\n [img]gfx/ui/icons/asset_moral_reputation.png[/img] The company\'s Moral reputation increases slightly";
			}
			if (s.ID == "Bad") {
				s.Text = "[img]gfx/ui/events/event_97.png[/img]You send %otherbrother% to try and retrieve the ball. He climbs the tree and jumps across a branch to land atop the roof. Mission complete, he tosses the ball to the kid. Unfortunately, the boy lets go of the tree branch to try and catch it. He slips off the branch and falls a good fifteen feet to the earth. The wallop of his landing has the whole company cringing. When you check on him he isn\'t moving and his back has taken a new shape. %otherother% yells at the idiot still standing in shock on the roof.%SPEECH_ON%What the hell were you thinking? Holy shit, man!%SPEECH_OFF%The mercenary climbs down off the roof. He looks at the kid and then nervously looks around.%SPEECH_ON%Well he, uh, he\'s got the ball. Let\'s get the hell out of here. Our... our work here is done.%SPEECH_OFF%What a goatfuck of a situation. You and the company quickly leave the scene before the parents get back. \n\n [img]gfx/ui/icons/asset_moral_reputation.png[/img] The company\'s Moral reputation decreases slightly";
			}
			if (s.ID == "Surefooted") {
				s.Text = "[img]gfx/ui/events/event_97.png[/img]%surefooted% clears his throat and steps forward.%SPEECH_ON%I\'ll be your hero, kid.%SPEECH_OFF%He opens his arms and the kid jumps down into them. The boy is set aside and the sellsword points a finger to the earth.%SPEECH_ON%Stay down here.%SPEECH_OFF%The surefooted mercenary easily clambers up the tree and jumps over to the roof. He picks the ball up and spins it on a finger before he pirouettes off the eave like a tornado, landing right on his toes with rather feminine grace. The boy claps excitedly and takes the toy and even the most cynical of men in the company are warmed by his happiness. \n\n [img]gfx/ui/icons/asset_moral_reputation.png[/img] The company\'s Moral reputation increases slightly";
			}
		}
	}
})
