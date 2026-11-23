::mods_hookExactClass("events/events/crisis/civilwar_hungry_hamlet_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_79.png[/img]{Against typical mercenary judgment, you elect to give the poor villagers some food. %randombrother% is told to disperse what %they_randombrother% can, although obviously not too much. The people are forever grateful, swarming the sellsword as though %they_randombrother% was about to whisper an immense and unforgettable truth. The leader of the small town says he will spread word of your goodwill. You\'re actually not sure if news of altruism is good for a mercenary band... | Shocking the villagers, you order %randombrother% to hand out some food. Not too much, just enough that these people can eat. And obviously, don\'t give away anything too good!\n\n The leader of the town comes to you, shaking hands clapping your shoulders.%SPEECH_ON%You\'ve no idea what this means to us! All shall hear of the good in the...%SPEECH_OFF%He glances at you and then your banner. You nod.%SPEECH_ON%The %companyname%.%SPEECH_OFF%The man laughs.%SPEECH_ON%Of course! Everyone shall hear of the %companyname%!%SPEECH_OFF%}";
			}
			if(s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_79.png[/img]{Goodness gets the better of you: you order %randombrother% to start handing out food. %They_randombrother% complies, but as soon as %they_randombrother% starts handing it out, the crowd goes nearly rabid, snatching it from one another. Fiery tempers are quickly fed by the air of empty bellies. The mercenary tries to maintain order, but anything %they_randombrother% says only spurs the hungry masses into thinking it\'s all %their_randombrother% fault. The violence spills over, ironically spilling all the food into the mud. Your brothers have to draw swords and by the end of it some peasants lay dead while the survivors look at the corpses with cannibalistic eyes.\n\nYou quickly order the %companyname% to move on before this gets any worse. | For some reason, perhaps to sleep better at night, you order %randombrother% to hand out parcels of food. %They're_randombrother% just getting started on the process when a villager quickly snatches a sack of food. Another peasant stoves that man\'s head in and takes the sack for himself. This quickly erupts into a total free-for-all and your mercenaries have to draw weapons to protect the rest of the stores. By the end of the scuffle a few laymen lay dead and your brothers are a little marked up. Seeing no reason to hang around, you order the company to get back on the road. The leader who asked for your help is spotted in the distance, staring out at the horizon as a bitter wind curls his thin pantaloons about his shins.}";
			}
			if(s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_79.png[/img]Well. This world is a terrible place and if you can do a little to relieve it of its horrid nature, why not? You order %randombrother% to start doling out food, but not too much, and nothing that your tastes will miss. But as %they_randombrother% goes about the business, a few soldiers waving the %noblehouse% banner show up. They sift through the hungry crowd, taking food and drawing swords whenever someone resists. Their supposed leader speaks out.%SPEECH_ON%This food is needed by the arm of %noblehouse%. Do not resist its seizure.%SPEECH_OFF%You explain to the man that it is in fact your food and you just handed it out.%SPEECH_ON%If it\'s your food, why is it in their hands? Go along, men, take all that you can! And don\'t try anything, sellsword, or there will be violence.%SPEECH_OFF%%randombrother% glances at you as if to say, what should we do?";
			}
			if (s.ID == "E") {
				local startE = s.start;
				s.start <- function (_event) {
					startE(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases"
					});
				}
			}
			if (s.ID == "F") {
				local startF = s.start;
				s.start <- function (_event) {
					startF(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases"
					});
				}
			}
		}
	}
})
