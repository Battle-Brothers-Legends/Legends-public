::mods_hookNewObject("events/events/offp_oathtaker_vs_cultist_event", function(oovce) {
	foreach(screen in oovce.m.Screens) {
		if (screen.ID == "A")
			screen.Text = "[img]gfx/ui/events/event_05.png[/img]{To your surprise, you find %cultist% and %oathtaker% engaged in discussion. While your understanding of the oathtaker's religion is shaky at best, you do understand it to be at least loosely aligned with the tenants of the old gods, whereas the cultist's almost seems to revel in its defiance of those same tenants.\n\nYou wonder if perhaps you should break this off before they discover they have less common ground than they might think.}";

		if (screen.ID == "B") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);
				Text = "[img]gfx/ui/events/event_05.png[/img]{You decide to let them hash things out without your supervision. After some time passes you come back to check on them, and just as you do %oathtaker% leaps up with a jubilant cry.%SPEECH_ON%I knew it! You speak of the Oath of Death! My brothers doubted me, but what you have said gives me all the confirmation I need! Wait for me, Young Anselm, this servant shall follow you! I must go re-examine the scriptures right away!%SPEECH_OFF%%cultist% is, for the first time you can recall, caught off guard.%SPEECH_ON%No, that's not what I was saying at al-%SPEECH_OFF%The oathtaker careens off to " + Const.LegendMod.getPronoun(_event.m.Oathtaker.getGender(), "their") + " tent before the cultist can finish. Seeing you, the remaining " + Const.LegendMod.getPronoun(_event.m.Cultist.getGender(), "person") + " quickly regains " + Const.LegendMod.getPronoun(_event.m.Cultist.getGender(), "their") + " composure.%SPEECH_ON%Ah, captain. I'm confident " + Const.LegendMod.getPronoun(_event.m.Oathtaker.getGender(), "they") + "'ll come around to see that it is Davkul " + Const.LegendMod.getPronoun(_event.m.Oathtaker.getGender(), "they") + " has always sought to serve, not this 'Anselm' " + Const.LegendMod.getPronoun(_event.m.Oathtaker.getGender(), "they") + " clings to. " + Const.LegendMod.getPronoun(_event.m.Oathtaker.getGender(), "They") + " just needs some more time.%SPEECH_OFF%}"
			};
		}

		if (screen.ID == "C") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);
				Text = "[img]gfx/ui/events/event_05.png[/img]{You decide to let them have their conversation and go to count inventory. Within minutes you hear the sounds of shouting in camp. Groaning, you return to find the oathtaker bellowing at a confused %cultist%.%SPEECH_ON%I knew it, you swine. You wretch! You speak of the Oath of Death! I'll not suffer your heathen Oathbringer codices!%SPEECH_OFF%The cultist manages to utter,%SPEECH_ON%No, I-%SPEECH_OFF%Then the oathtaker is upon " + Const.LegendMod.getPronoun(_event.m.Cultist.getGender(), "them") + ", pummeling the " + Const.LegendMod.getPronoun(_event.m.Cultist.getGender(), "person") + " and screaming something about Young Anselm's valor. You and the rest of the company manage to pull them apart, and you try to explain to %oathtaker% that the cultist's religion is wholly separate from whatever creed the oathbringers follow. The " + Const.LegendMod.getPronoun(_event.m.Oathtaker.getGender(), "person") + " stares into the space in front of " + Const.LegendMod.getPronoun(_event.m.Oathtaker.getGender(), "them") + ", shaking.%SPEECH_ON%I...I see, captain. I apologize, I just couldn't bear the thought of someone peddling those awful men's false scriptures in camp. The horror of it!%SPEECH_OFF%}";
				Options[0].Text = "Keep it together, " + Const.LegendMod.getPronoun(_event.m.Oathtaker, "person") + ".";
			};
		}
	}

	// Recreate scoring with additional Legends cultist backgrounds
	oovce.onUpdateScore = function() {
		if (!Const.DLC.Paladins)
			return;

		// Disable for OFF+ v2.x Oathtakers
		if (World.Assets.getOrigin().getID() == "scenario.oathtakers" || World.Assets.getOrigin().getID() == "scenario.cultists")
			return;

		local brothers = World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local cultist_candidates = [];
		local oathtaker_candidates = [];
		local cultist_backgrounds = [
			"background.cultist"
			"background.converted_cultist"
			"background.legend_magister"
			"background.legend_husk"
			"background.legend_lurker"
		];

		foreach (bro in brothers) {
			if (cultist_backgrounds.find(bro.getBackground().getID()) != null)
				cultist_candidates.push(bro);
			else if (bro.getBackground().getID() == "background.paladin")
				oathtaker_candidates.push(bro);
		}

		if (cultist_candidates.len() == 0 || oathtaker_candidates.len() == 0)
			return;

		m.Cultist = cultist_candidates[Math.rand(0, cultist_candidates.len() - 1)];
		m.Oathtaker = oathtaker_candidates[Math.rand(0, oathtaker_candidates.len() - 1)];
		m.Score = 5;
	}
});