::mods_hookExactClass("events/events/more_action_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_64.png[/img]You\'re sitting in your tent enjoying the peace and quiet which, like some increasable quantity, seemingly has accrued in such a way that each day is more enjoyable than the last. Suddenly, %combatbro1% and %combatbro2% enter. They demand you have a talk. You oblige, fanning your hands across your table and inviting them to sit. They do and quickly state that it has been a long while since they last saw combat. Taken aback, you quite literally lean back in your chair.%SPEECH_ON%Isn\'t that a good thing?%SPEECH_OFF%%combatbro1%\'s head shakes and cuts a determined hand through the air.%SPEECH_ON%No. We were hired to fight, and fighting is what we want. We want battles, we want carnage, and we want the glory that comes with both.%SPEECH_OFF%";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_64.png[/img]You nod.%SPEECH_ON%I understand. You are two battle-earnest mercenaries. You even remind me of myself though, with your skills, I can assure you that only I come out looking better by such a comparison. You are fine warriors, but is it not true that you will be paid the same regardless of this battle or that? Why be so worried about battles? They will come. I\'ve not paid you to sit. I\'ve paid you to be ready to stand.%SPEECH_OFF%The mercenaries exchange a glance and then shrug and nod. They stand up in unison.%SPEECH_ON%You are right, sir. And, when the time comes, we will be ready to stand and fight for you!%SPEECH_OFF%";
				s.Options[0].Text = "Good to have the company burn for battle like this.";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_64.png[/img]You try and explain to the mercenaries that, regardless of whether or not they\'re fighting, they are going to be getting paid. But money is not their primary concern. They truly wish to fight and you words have little effect on their rather earnest attitudes.";
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_64.png[/img]You stand up and flatten your knuckles on the table.%SPEECH_ON%Is it fighting you want?%SPEECH_OFF%The mercenaries exchange a glance then quickly nod at you.%SPEECH_ON%Then it is fighting you shall have! Fear not the sheathed sword, mercenaries. I will find you a good battle in due time!%SPEECH_OFF%Rising to their feet, the mercenaries shake your hand. They thank you as they leave the tent. Once they\'re gone, you go to your maps and look for the nearest ass to kick.";
				s.Options[0].Text = "Good to have the company burn for battle like this.";
			}
		}
	}
})
