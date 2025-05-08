::mods_hookExactClass("events/events/fell_down_well_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "Good") {
				s.Text = "[img]gfx/ui/events/event_91.png[/img]You decide it\'s worth your time and go and take a look. The old man was doing repairs on the wellhead, a wooden framework meant to cover its opening, when it broke apart and sent him plunging down. Staring into the well, you find the man staring back up. He gives a wave.%SPEECH_ON%Oy\' there, fellas. I\'m in a bit of a pickle. I\'m actually being pickled, now that I think about it...%SPEECH_OFF%Eh, right. %otherbrother% throws down a rope and the old man ties it around himself. You and the sellsword pull the woman\'s grandfather up and back onto dry land. He shakes your hand and thanks you cordially.%SPEECH_ON%Farkin\' hell, glad you came when you did, I was about to shit and piss like no other. Let me tell ya, this ain\'t my first time going down a well. Five years ago I\'d done it while repairing the wellhead, because the wellhead breaks often, you see. And it\'s not really a wellhead, we just call it that cause we\'re lazy. Back in my day we called it a... well, heh well, I actually done forgot. I guess a \'wellhead\' makes sense now, as I\'m not well in the head! Ho! Still got it. I was quite the charmer in my days, you see, and it\'s not often I get to put the practice in. M\'wife died ten years ago, and the one prior to her left me twenty winters ago! I say winters, because that\'s when she left me, in the winter. It was a brutal one and I had asked her to help chop the wood lest we all freeze. She said she wasn\'t doing that shit and taking care of the kids at the same time. I had kids with her as well as with the second wife. Five total. One died. Measles. Another disappeared, so he\'s probably dead. I try to be honest to myself about it, but you know, there\'s hope. If a random stranger can be found in the forest to save me in the nick of time, then maybe my son survived that battle with the greenskins. Ain\'t heard of him, though. I pray to the old gods and even that Davkul fella every now and again. Do you know of Davkul? I\'m not sure what to make of it. One time this man came by with a scar on his forehead, said he\'d show me the way of darkness. I said I see darkness everytime I nap. This scarred fella said one day I won\'t wake and I said good! Ha! So then this scarred bastard starts getting upset with me...%SPEECH_OFF%As he drones on, you look around for %otherbrother% only to find %them_otherbrother% stepping out of the woman\'s home, the lady herself carrying a bit of... obvious warmth on her face. You retrieve your sellsword and leave before the old man lops your head with the most longwinded and one-sided conversation ever.";
				s.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases"
				});
			}
			if (s.ID == "Bad") {
				s.Text = "[img]gfx/ui/events/event_91.png[/img]The old man was doing repairs atop the wooden wellhead when it broke apart. Unfortunately, if you\'re standing atop a wellhead when it goes bust there\'s only one place to go: down. Very, very far down. As you look over the edge of the well, you can see the old man floating in a matter that is most unlively. %otherbrother% sidles up next to you and whispers, using a hand to keep %their_otherbrother% words from being heard.%SPEECH_ON%Uh, he\'s not moving.%SPEECH_OFF%An expertly observation, truly. You inform the lady of the man\'s passing. She purses her lips and asks that you remove the body anyway, explaning her reasoning rather succinctly.%SPEECH_ON%We can\'t be drinking his filth after all.%SPEECH_OFF%Fair enough. %otherbrother% manages to hook a rope-loop around the corpse and pull it up, its limbs dangling loosely like white washrags. %They_otherbrother% asks if she needs you to bury it, too. The woman wipes a tear and shakes her head.%SPEECH_ON%Nah. I\'ll bury that feller myself, weep over his grave tomorrow, and then get on with living.%SPEECH_OFF%";
				s.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases slightly"
				});
			}
			if (s.ID == "Strong") {
				s.Text = "[img]gfx/ui/events/event_91.png[/img]You decide it\'s worth your time and go and take a look. The wellhead, a wooden framework meant to cover its opening, has broken apart. Apparently, the old man was doing repairs atop it when this happened and so he plunged down into the well. He looks up at you.%SPEECH_ON%Oy\' there, fellas. I\'m in a bit of a pickle. I\'m actually being pickled now that I think about it...%SPEECH_OFF%Eh, right. %strongbrother% throws down a rope. The old man ties it around himself. You and the sellsword pull the woman\'s grandfather up and back onto dry land. He shakes your hand and thanks you cordially.%SPEECH_ON%Farkin\' hell, glad you came when you did, I was about to shit and piss like no other.%SPEECH_OFF%You talk with the old fella for a time, learning a lot about him. A while later, you realize %strongbrother% is nowhere in sight. Just as you think to start looking for %them_strongbrother% %they_strongbrother% steps out of the woman\'s home. She\'s glomming onto %their_strongbrother% muscles and being rather touchy feely.";
				s.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases"
				});
			}
		}
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function ( _vars )
	{
		onPrepareVariables(_vars);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Other.getGender(), "otherbrother");
		if (this.m.Strong != null)
			::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Strong.getGender(), "strongbrother");
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		local brothers = this.World.getPlayerRoster().getAll();
		if (brothers.len() == 1)
			return;
		onUpdateScore();
	}
})
