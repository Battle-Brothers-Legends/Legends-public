::mods_hookNewObject("events/events/offp_oathtaker_vs_flagellant_event", function(oovfe) {
	foreach(screen in oovfe.m.Screens) {
		if (screen.ID == "A")
			screen.Text = "[img]gfx/ui/events/event_05.png[/img]{Now here's something you didn't expect: %oathtaker% the oathtaker and %flagellant% the flagellant are engaged in a debate over the virtues of the others' chosen path in life.%SPEECH_ON%I know something of your 'oaths', and I've seen your brethren inflict self-torture far worse than my simple appeasements.%SPEECH_OFF%The oathtaker counters.%SPEECH_ON%Aye, but there is a goal to our ruination as laid out in the Oaths. We explore the weakness of the flesh to better know its strengths, not simply to endure the endless pain your flagellations bring.%SPEECH_OFF%And so the two continue back and forth. You're glad to see both sellswords engage in earnest discussion without the violence that characterizes both their pursuits, yet you have to wonder if its healthy for two the company's most extreme individuals to pit their ideologies against one another.}";

		if (screen.ID == "B") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);
				Text = "[img]gfx/ui/events/event_05.png[/img]{You decide to check in on them later and return to the sound of %oathtaker% screaming.%SPEECH_ON%I AM SORRY, YOUNG ANSELM! FORGIVE THIS MISERABLE WRETCH'S FAILURES!%SPEECH_OFF%Well then. The oathtaker is furiously whipping " + Const.LegendMod.getPronoun(_event.m.Oathtaker.getGender(), "their") + " naked back, which you take as indication that the flagellant won the debate. You turn to %flagellant%, however, and " + Const.LegendMod.getPronoun(_event.m.Flagellant.getGender(), "they") + " simply shakes " + Const.LegendMod.getPronoun(_event.m.Flagellant.getGender(), "their") + " head.%SPEECH_ON%This is no holy rite, captain. Just as I thought my words were getting through to " + Const.LegendMod.getPronoun(_event.m.Oathtaker.getGender(), "them") + ", " + Const.LegendMod.getPronoun(_event.m.Oathtaker.getGender(), "they") + " started going on about how it was all a sign of some new oath " + Const.LegendMod.getPronoun(_event.m.Oathtaker.getGender(), "they") + " needed to take on or some such. It's a shame to see such a devoted " + Const.LegendMod.getPronoun(_event.m.Oathtaker.getGender(), "person") + " eschew the old gods for such pursuits.%SPEECH_OFF%}";
			};
		}

		if (screen.ID == "C") {
			local start = screen.start;
			screen.start = function(_event) {
				start(_event);
				Text = "[img]gfx/ui/events/event_05.png[/img]{You decide to check in on them later and return to see %flagellant% softly weeping with a smile on " + Const.LegendMod.getPronoun(_event.m.Flagellant.getGender(), "their") + " face. %oathtaker% sees you and walks over excitedly.%SPEECH_ON%I think I finally got through to " + Const.LegendMod.getPronoun(_event.m.Flagellant.getGender(), "them") + ", captain! " + Const.LegendMod.getPronoun(_event.m.Flagellant.getGender(), "They") + " sees now the error of " + Const.LegendMod.getPronoun(_event.m.Flagellant.getGender(), "their") + " ways, and how following in Young Anselm's footsteps shall put " + Const.LegendMod.getPronoun(_event.m.Flagellant.getGender(), "them") + " on the Final Path! I must go now to ponder which Oaths " + Const.LegendMod.getPronoun(_event.m.Flagellant.getGender(), "they") + " should follow first. It would not do to let a new inductee meander through the holy teachings unguided.%SPEECH_OFF%" + Const.LegendMod.getPronoun(_event.m.Oathtaker.getGender(), "They") + " hurries off and you glance at the flagellant-turned-oathtaker. You think " + Const.LegendMod.getPronoun(_event.m.Flagellant.getGender(), "they") + " looks more defeated than enlightened, but perhaps this is all for the best if it stops the " + Const.LegendMod.getPronoun(_event.m.Flagellant.getGender(), "person") + "'s self-torture.}";
				_event.m.Flagellant.getBackground().m.RawDescription = "Once a flagellant, %name% has traded %their whip for the Oaths of Young Anselm. The %person% is as insufferable as the rest of %their% order, but at least you can be confident you won't wake up to find %they%'s killed %themselves% in some religious pursuit. By whip. Probably.";
				_event.m.Flagellant.getBackground().buildDescription(true);
			};
		}
	}

	local hasNonFlailWeaponMastery = ::mods_getMember(oovfe, "hasNonFlailWeaponMastery");

	// Add new Legends masteries to check to prevent
	oovfe.hasNonFlailWeaponMastery = function(bro) {
		local hasMastery = hasNonFlailWeaponMastery(bro);

		return hasMastery || bro.getCurrentProperties().IsSpecializedInSlings || bro.getCurrentProperties().IsSpecializedInStaffStun || bro.getCurrentProperties().IsSpecializedInStaves;
	}
});