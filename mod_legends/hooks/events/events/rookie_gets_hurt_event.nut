::mods_hookExactClass("events/events/rookie_gets_hurt_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_22.png[/img]After the battle is over, you find %noncombat% on their knees, body swaying back and forth, nursing a wound. You hear muffled cries in between all-too-loud moans. Approaching, you ask the if everything is alright. %noncombat%\'s head shakes and explains that this was the first taste of real, vicious combat. %SPEECH_ON%It was not what I expected and I am not sure if I can continue.%SPEECH_OFF%";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_22.png[/img]You tell the mercenary to harden up. When %noncombat% pauses, stifling a cry, you repeat it again. This time, %noncombat% brings a leg out and plants a foot, steadying. With true grit, the mercenary manages to get standing again. Shirt is bloodslaked, face covered in mud and crimson and other viscera battle makes of the living. But %noncombat%\'s eyes show a sign of resolve they did not before, the sellsword nods at you before walking back to join the rest of the men.";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_22.png[/img]Unfortunately, telling the mercenary to \'suck it up\' gets nowhere. %noncombat% turns to you, face covered in the blood and gore of battle, but before any words can come out, their lip quivers and they keel over again. You ask if %noncombat% wishes to be cut from the company, but the response comes back with a shaken head and a forceful no. I'll get better, he explains. You nod and walk off, but there\'s little doubt that this poor show of resolve has hurt the mercenary\'s pride.";
				s.Options[0].Text = "We will be steeled by combat, or we will be killed by it.";
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_22.png[/img]The mercenary looks around, at the bodies, at the land, at the sky. %noncombat% nods and gets to their feet. Before heading back to camp, thanking you for your words.%SPEECH_ON%Thankee, captain. I\'ll do a better job of hiding my fears.%SPEECH_OFF%You nod back with a terse smile before putting your fist to your chest.%SPEECH_ON%Bottle it all up right here and don\'t let anybody else see it. Half of any battle is convincing your opponent that you\'re crazier than they are. Being fearless is impossible, but faking it for a time is not.%SPEECH_OFF%The sellsword nods again and heads back to camp with head held a little bit higher.";
			}
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_22.png[/img]The mercenary turns to you, tears cutting through the crusts of bloody cheeks. %noncombat%\'s head is shaking and asking %SPEECH_ON%How is it that I\'m the only one out here crying?%SPEECH_OFF% You shrug and ask if the mercenary wishes to leave the company. %noncombat%\'s head shakes again.%SPEECH_ON%I\'ll get better. I just.. I just need some time to do it, that\'s all.%SPEECH_OFF%";
				s.Options[0].Text = "We will be steeled by combat, or we will be killed by it.";
			}
		}
	}

	o.onUpdateScore = function () {
		if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() > 10.0)
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local candidates = [];

		foreach( bro in brothers )
			if (bro.getLevel() == 1 && bro.getBackground().getID() != "background.slave" && !bro.getBackground().getID() == "background.slave" && !bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat) && bro.getPlaceInFormation() <= 17 && bro.getLifetimeStats().Battles >= 1)
				candidates.push(bro);

		if (candidates.len() < 1)
			return;

		this.m.Rookie = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 75;
	}
})
