::mods_hookExactClass("ambitions/ambitions/win_against_y_ambition", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.SuccessText = "[img]gfx/ui/events/event_22.png[/img]After the fight, %lowesthp_brother% sits gazing at %their_lowesthp% feet, looking completely knackered, as do the others. %SPEECH_ON%That was the battle I was born to fight! Now if I die, it will be alongside the bravest and deadliest bunch of men I\'ve ever known, and I\'m proud to call them my brothers!%SPEECH_OFF%This is met with a chorus of weary assent all round.%SPEECH_ON%Peasants talk of sweat, blood and tears but the men of the %companyname% have walked through fire and prevailed!%SPEECH_OFF%Three times the men shout the company name, tired but victorious.\n\nIn the days to come you find that wherever civilized people gather, they point you out and whisper, whether in fear or admiration you do not know. Everywhere you go, word of your mighty victory has traveled the land before you.";
	}
});
