::mods_hookNewObject("events/events/offp_anatomist_vs_oathtaker_event", function(oavoe) {
	foreach(screen in oavoe.m.Screens) {
		if (screen.ID == "A") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);
				Text = "[img]gfx/ui/events/event_05.png[/img]{You and the company are sitting around the fire when you catch %oathtaker% the oathtaker and %anatomist% the anatomist in heated debate.%SPEECH_ON%Don't you see? In such a harsh world as this, that which is without grows from within, yet also shields it from understanding. We must pursue the secrets inside that we may improve our fragile shells.%SPEECH_OFF%The oathtaker shakes " + Const.LegendMod.getPronoun(_event.m.Oathtaker.getGender(), "their") + " head.%SPEECH_ON%These experiments of yours only serve to rob the dead of their repose. 'Tis the pathway to necromancy and villainy, my friend, not self-betterment. Only the Oaths can offer that.%SPEECH_OFF%}";
			};
		}

		if (screen.ID == "B") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);
				Text = "[img]gfx/ui/events/event_05.png[/img]{%anatomist% sighs exasperatedly.%SPEECH_ON%Your oaths are no different from my research. You follow them to strive against the failures of your mind and body. And surely those failures exist in all of us, for was not even your own founder Anselm imperfect, and so-%SPEECH_OFF%The rest of the anatomist's rebuttal is cut short as a screeching %oathtaker% begins pummeling " + Const.LegendMod.getPronoun(_event.m.Anatomist, "them") + " for besmirching the name of " + Const.LegendMod.getPronoun(_event.m.Oathtaker, "their") + " cult's founder. You and the rest of the company hurry and split them up, but not before the more academic of the two has been badly beaten. You confront the oathtaker about " + Const.LegendMod.getPronoun(_event.m.Oathtaker, "their") + " outburst, but " + Const.LegendMod.getPronoun(_event.m.Oathtaker, "they") + " just shakes " + Const.LegendMod.getPronoun(_event.m.Oathtaker, "their") + " head sullenly.%SPEECH_ON%I'm sorry, captain, but there are simply some evils I cannot abide. I can look the other way when the anatomist scribbles in " + Const.LegendMod.getPronoun(_event.m.Anatomist, "their") + " notebooks or dissects corpses, but not- not that!%SPEECH_OFF%" + Const.LegendMod.getPronoun(_event.m.Oathtaker, "They") + " stomps off.}"
				Options[0].Text = "What the hell, " + Const.LegendMod.getPronoun(_event.m.Oathtaker, "person") + ".";
			};
		}

		if (screen.ID == "C") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);
				Text = "[img]gfx/ui/events/event_05.png[/img]{%anatomist% wracks " + Const.LegendMod.getPronoun(_event.m.Anatomist, "their") + " brain, trying to think of a way to get through to " + Const.LegendMod.getPronoun(_event.m.Anatomist, "their") + " stubborn counterpart.%SPEECH_ON%Your Young Anselm established the oaths as a means for men to better themselves, correct?%SPEECH_OFF%The oathtaker nods warily, " + Const.LegendMod.getPronoun(_event.m.Oathtaker, "their") + " fists tightening at the mention of " + Const.LegendMod.getPronoun(_event.m.Oathtaker, "their") + " order's founder. The anatomist continues.%SPEECH_ON%What better proof could there be of man's frailty than for it to be rallied against by such a prime specimen? Consider further, then, the invalid and the infirm. They cannot practically follow your more martial oaths; but what if they could? Consider the elderly man, whom circumstance deprived knowledge of your order until late in his life; does he not deserve the chance, nay the time, to pursue the oaths as fully as any other? It is them whom my research benefits, not I.%SPEECH_OFF% The oathtaker opens " + Const.LegendMod.getPronoun(_event.m.Oathtaker, "their") + " mouth to retort, then pauses, then opens " + Const.LegendMod.getPronoun(_event.m.Oathtaker, "their") + " mouth again, then pauses again and frowns. Then " + Const.LegendMod.getPronoun(_event.m.Oathtaker, "they") + " cracks a wide grin and gives the anatomist a friendly punch in the shoulder.%SPEECH_ON%I see you now to be of a firmer character than I thought, friend! Ha! Bringing the Oaths to even the elderly and crippled is truly a noble pursuit, worthy of a new title. What would befit a parchment man? Oathpreacher, perhaps? Hmm.%SPEECH_OFF%The paladin wonders off in good spirits, lost in thought. The anatomist, for " + Const.LegendMod.getPronoun(_event.m.Anatomist, "their") + " part, winces as " + Const.LegendMod.getPronoun(_event.m.Anatomist, "they") + " nurses a freshly bruised shoulder.}";
				_event.m.Oathtaker.getMoodChanges()[0].Text = "Convinced the others in the company are pursuing the oaths in their own way";
			};
		}
	}
});