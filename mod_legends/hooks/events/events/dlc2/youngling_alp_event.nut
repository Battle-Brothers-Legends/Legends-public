::mods_hookExactClass("events/events/dlc2/youngling_alp_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]{%callbrother% runs into your tent and says something is watching the camp. You come outside to see a silhouette in the distance, skulking behind brush and tree limbs. You know its staring when it hisses, for what else would it be looking at to elicit such a charge. Its arms are long and slender and end in claws. You take a torch and sling it toward the beast. Its slick skin winks a vibrant orange and it shrieks away from the cloud of embers and sparks as the torch lands and rolls past. The toothy maw is the last thing you see fading back into the darkness.%SPEECH_ON%I think it\'s an alp, sir. It\'s all by itself as far as we can tell.%SPEECH_OFF%You ask if the sellsword has had visions, and are met with shrugs.%SPEECH_ON%Yeah, some, but I also been drinking so there\'s that.%SPEECH_OFF%}";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_122.png[/img]{The alp is alone and possibly a youngling. Even monsters have to cut their cloth and put in the work to become truly horrible beasts, and this one just doesn\'t seem there yet. You send a pair of sellswords to slay the beast. They close in on it through the shroud of darkness. You see the silhouettes rising up in ambush and there\'s a clatter and a scream, and another scream which is nothing humanlike at all. Shrieking now. And this time a mercenary crying. Someone speaking. Quiet. A long, long quiet. Then the pair comes back. One is clutching their head as though taken by a terrific ache, the other looks at you and nods.%SPEECH_ON%We killed it and, uh, I think we need to lie down.%SPEECH_OFF%}";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]{You tell the company to ignore the alp. If it were of any danger it would have already proven so. Instead, it has let you know it is there, whether by ignorance or arrogance, neither of which bother you none. A few of the mercenaries do not agree with this decision and they stay up all night watching for the beast.}";
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_122.png[/img]{%beastslayer% the beast slayer comes over.%SPEECH_ON%It ain\'t dangerous, it\'s confused. I\'ll take care of this.%SPEECH_OFF%He\'s chewing on a dried biscuit and grunts and puts the biscuit in a pocket and sets off into the dark all alone. A moment later, the alp\'s silhouette suddenly falls away and disappears. A few minutes later and the slayer returns, mouth bulging with the last morsels of the biscuit. You ask why the alp didn\'t put up much of a fight. The beast slayer laughs.%SPEECH_ON%You said %callbrother% fetched you from your tent, right? Right. And where is %callbrother%?%SPEECH_OFF%The beast slayer points toward the campfire. The sellsword is there. Asleep. Deeply asleep. %beastslayer% gets another biscuit.%SPEECH_ON%Young alps are still learning how to pry into your mind. They\'re not good at it and often call attention to themselves while trying. They\'re like thieves who can\'t pick a lock, so they knock on the door instead.%SPEECH_OFF%A few of the company listen to this and are emboldened by the apparent flaws of these otherwise horrifying creatures.}";
			}
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]{%flagellant% the flagellant is at the rim of the camp self whipped raw. The soul cleansing tool is rigged with broken glass and cat claws, bound tight with leather rinsed taut in urine, and tassels of twisted horse hair. The mercenary walks out into the wilderness, hiding their own back with every step.%SPEECH_ON%It\'s not that I fear you, creature in the shadows. It\'s not that I fear you, shadows in my mind. It\'s not that I fear you, mind in my body.%SPEECH_OFF%The mercenary stops walking, but the urgency of the flagellation increases and you can see the flecks of blood winking in the moonlight.%SPEECH_ON%It is that I fear the old gods of which you are not! Of which you are but an insect!%SPEECH_OFF%The alp\'s silhouette shrinks away, shrieks, and then scurries off altogether. The mercenary returns and collapses into the camp. A few of the company are horrified, while others are emboldened by the courage and righteousness.}";
			}
		}
	}
});
