::mods_hookExactClass("events/events/more_men_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]The entire company - a motley little crew if you say so yourself - enters your tent all at once. A troupe of sellswords appearing in such a fashion is not the friendliest of sights and so for a split-second you think to reach for your sword. But then you notice that none of them have their weapons out nor do they carry the faces of mercenaries about to commit a murder. While they don\'t seem to be forming a mutiny to take your head, you keep the thought in mind nonetheless.\n\n You are only further relieved when they don\'t immediately start talking, instead waiting for your words to come first. This is a show of respect, and so the thought of reaching for your sword grows more distant. Crossing your arms over the table, you ask them what is on their minds.\n\n They explain that the company is too thin. Everywhere they go there is danger and they are now concerned that every new battle shall be their last. Finally, they state their wants outright: if they are going to survive, they\'re going to need more sellswords by their side.";
				s.Options = [{
					Text = "I\'d hire more if only we could afford it.",
					function getResult( _event ) {
						if (this.World.Assets.getMoney() >= 4000) {
							return "D";
						} else {
							return this.Math.rand(1, 100) <= 50 ? "E" : "F";
						}
						return "E";
					}
				}, {
					Text = "We\'ll reinforce the company with new recruits soon - you have my word.",
					function getResult( _event ) {
						return "B";
					}
				}, {
					Text = "There is no need to hire more, we\'re doing fine this way.",
					function getResult( _event ) {
						return "C";
					}
				}]
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]You immediately stand up and rap the table with your knuckles.%SPEECH_ON%The best of minds truly must think alike for I have already set aside some crowns for hiring new comrades!%SPEECH_OFF%The anxious, almost sad faces on the mercenaries slowly begin to change. They smile and nod and say things like \'alright\' and \'that\'s good.\' When they turn to leave, you notice they\'ve got daggers sheathed behind their backs.";
				s.Options[0].Text = "Time to hire new recruits.";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]Unfortunately, you just don\'t agree.%SPEECH_ON%You are some of the finest soldiers I\'ve ever seen. I don\'t think you have anything to fear. Our enemies fear for their own lives when they see you!%SPEECH_OFF%But your words don\'t go over well. One mercanary leans forward with an arm behind his back, but another claps a hand on the shoulder and quickly shakes their head. They only looks at you and say.%SPEECH_ON%This is most concerning news, sir, but we shall carry on.%SPEECH_OFF%When they turn to leave, you notice the clasp on one man\'s sheathed dagger has been unlatched.";
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]Fanning your arms out and pressing forth a smile that couldn\'t sell water to a thirsty man, you lie.%SPEECH_ON%We\'ve simply not the coffers to take on more trainees.%SPEECH_OFF%The mercenaries don\'t take it well. One immediately turns around and exits the tent, a wake of curses and swears in the wake of his leaving. Another momentarily reaches behind their back. You glance at your sword again. Seeing you doing this, the mercenary puts hands back where you can see them. Finally, nodding, they state. %SPEECH_ON%We\'ll do as told, sir. For now.%SPEECH_OFF%";
			}
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]When you let the mercenaries know that you\'ve not enough crowns on hand to hire more recruits, they nod.%SPEECH_ON%We thought you might say that. So here\'s our suggestion, and we don\'t say this lightly, but each of us will give you part of what we saved up for retirement so that you may hire others. And you\'ll pay us back with our wages.%SPEECH_OFF%You quickly glance up, the suggestion seemingly coming out of nowhere.";
			}
			if (s.ID == "F") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]You let the mercenaries know that you\'ve not the crowns to take on more sellswords. They collectively sigh and nod.%SPEECH_ON%That\'s alright, sir. T\'was only a suggestion. As always, we shall march on your orders.%SPEECH_OFF%The warriors turn and leave, a little slouched over and quieter than before.";
			}
			if (s.ID == "G") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]You get up and shake the hands of each mercenary. While you loudly state that you wish it didn\'t come to this, you are secretly beaming at the fact you now have more crowns at your disposal.";
				s.Options[0].Text = "Let\'s go hire some more comrades for the company!";
			}
			if (s.ID == "H") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]You look the mercenaries over. They are solemn creatures, not the ones you last saw grinning and laughing over their latest victory or triumph. While you can\'t yet afford to get them more recruits, there really is no need to cut their pay.%SPEECH_ON%I appreciate the selflessness and bravery it must\'ve took to suggest such a thing, but I cannot possibly consider myself a leader of honor and grant you this request. Your savings shall remain untouched.%SPEECH_OFF%";
			}
		}
	}

	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.lone_wolf" || this.World.Assets.getOrigin().getID() == "scenario.gladiators" || this.World.Assets.getOrigin().getID() == "scenario.legends_beggar" || this.World.Assets.getOrigin().getID() == "scenario.legends_scaling_beggar")
			return;

		if (this.World.getTime().Days <= 10)
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() == 1 || brothers.len() > 5)
			return;

		this.m.Score = 10;
	}
})
