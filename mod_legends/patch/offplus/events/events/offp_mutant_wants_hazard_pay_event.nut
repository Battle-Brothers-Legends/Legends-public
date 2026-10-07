::mods_hookNewObject("events/events/offp_mutant_wants_hazard_pay_event", function(omwhpe) {
	foreach(screen in omwhpe.m.Screens) {
		if (screen.ID == "A") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);
				local gender = _event.m.Mutant.getGender();
				Text = "[img]gfx/ui/events/event_64.png[/img]{%mutant% steps into your tent and crosses " + Const.LegendMod.getPronoun(gender, "their") + " arms, " + Const.LegendMod.getPronoun(gender, "their") + " many mutations causing him to cut a figure as intimidating as it is comical. The look on " + Const.LegendMod.getPronoun(gender, "their") + " face suggests this isn't just a social visit.%SPEECH_ON%I want more.%SPEECH_OFF%You raise an eyebrow.%SPEECH_ON%Oh, come off it, captain. You know what I mean and you know I've earned it twofold. Look at me. I'm barely human anymore. No one could ask of another man what the company has asked of me, but I've done it. I've taken every one of those damned mutations, fought through the fever and the pains I never even knew the body could make, and I'm still here. Now it's the company's turn to do right by me. We both know you can't afford to lose me at this point.%SPEECH_OFF%The " + Const.LegendMod.getPronoun(gender, "person") + ", unfortunately, has a point. If " + Const.LegendMod.getPronoun(gender, "they") + " left, if would be a severe setback to the company's research, not to mention it's battle strength. You ask the " + Const.LegendMod.getPronoun(gender, "person") + " how much.%SPEECH_ON%1,000 crowns of hazard pay now, and 10 more a day going forward.%SPEECH_OFF%}";
			};
		}

		if (screen.ID == "B") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);
				local gender = _event.m.Mutant.getGender();
				Text = "[img]gfx/ui/events/event_64.png[/img]{You sigh and acquiesce, tossing the " + Const.LegendMod.getPronoun(gender, "person") + " a hefty pouch of gold.%SPEECH_ON%That's a lot of crowns. What exactly are you planning on even doing with it?%SPEECH_OFF%The " + Const.LegendMod.getPronoun(gender, "person") + " shrugs.%SPEECH_ON%Was thinking I might see myself to a whorehouse. You'd be surprised how much they cost when you're, well, like this.%SPEECH_OFF%" + Const.LegendMod.getPronoun(gender, "They") + " spreads " + Const.LegendMod.getPronoun(gender, "their") + " arms and motions to " + Const.LegendMod.getPronoun(gender, "their") + " bizarre assemblage.}";
			};
		}

		if (screen.ID == "C") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);
				local gender = _event.m.Mutant.getGender();
				Text = "[img]gfx/ui/events/event_64.png[/img]{The " + Const.LegendMod.getPronoun(gender, "person") + "'s a valuable part of the company, but you can't exactly cave to " + Const.LegendMod.getPronoun(gender, "their") + " demands; if the rest of the company followed the precedent it would set, you'd be bankrupt in no time.\n\nYou tell %mutant% " + Const.LegendMod.getPronoun(gender, "they") + "'ll receive more pay when " + Const.LegendMod.getPronoun(gender, "their") + " experience demands it, not when " + Const.LegendMod.getPronoun(gender, "they") + " does. " + Const.LegendMod.getPronoun(gender, "They") + " wordlessly fumes and stomps out. You check in later and discover " + Const.LegendMod.getPronoun(gender, "their") + " tent empty, the mutated mercenary nowhere to be found.}";
			};
		}
	}
});