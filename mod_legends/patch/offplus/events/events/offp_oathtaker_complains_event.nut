::mods_hookNewObject("events/events/offp_oathtaker_complains_event", function(ooce) {
	local screen = ooce.m.Screens.filter(function(index, screen) {
		return screen.ID == "A";
	})[0];

	local start = screen.start;
	screen.start = function(_event) {
		start(_event);
		local gender = _event.m.Oathtaker.getGender();
		Text = "[img]gfx/ui/events/event_183.png[/img]{%oathtaker% enters your tent abruptly. The oathtaker is high strung at the best of times, but " + Const.LegendMod.getPronoun(gender, "they") + " looks especially put out. You ask what it is " + Const.LegendMod.getPronoun(gender, "they") + " wants.%SPEECH_ON%Captain, I'm afraid I must protest the conditions in camp! I know that a life on the road comes with concessions, but there are some matters on which I simply cannot bear to compromise!%SPEECH_OFF%You arch an eyebrow and ask the " + Const.LegendMod.getPronoun(gender, "person") + " to elaborate.%SPEECH_ON%Well, for starters, the Oath of Meditation requires me to reflect on Young Anselm's glory in silence at least thrice daily, but the camp is too small and I cannot get far enough away from the others to concentrate. Then there's the Oath of Purification, which calls for the imbibing of a clergy-blessed libation with at least every fourth meal, and we simply do not find ourselves in adequately holy towns frequently enough for me to keep my stock. And that's to say nothing of the Oath of Celi-%SPEECH_OFF%You cut the " + Const.LegendMod.getPronoun(gender, "person") + " off and remind " + Const.LegendMod.getPronoun(gender, "them") + " that " + Const.LegendMod.getPronoun(gender, "their") + " religious duties are " + Const.LegendMod.getPronoun(gender, "their") + " own responsibility, and make it quite clear you won't be altering camp practices or company destinations. " + Const.LegendMod.getPronoun(gender, "Their") + " entire face flushes at the scandal of your refusal and " + Const.LegendMod.getPronoun(gender, "they") + " stomps out of your tent without another word.}"
		_event.m.Oathtaker.getMoodChanges()[0].Text = "Finds it difficult to follow " + Const.LegendMod.getPronoun(gender, "their") + " religious oaths as a mercenary";
	}
});