::mods_hookExactClass("ambitions/ambitions/hire_follower_ambition", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.ButtonText = "There are cauldrons, maps and many more things that can support us off the battlefield.\nWe\'ll buy tools that suit our needs best!";
		this.m.UIText = "Buy an upgrade for your camp";
		this.m.TooltipText = "Gain a renown of at least \'Recognized\' (250). You can increase your renown by completing contracts and winning battles. Then, purchase a camp upgrade in the camp upgrade screen.";
		this.m.SuccessText = "[img]gfx/ui/events/event_82.png[/img]%SPEECH_ON%So these are not for fighting?%SPEECH_OFF%One of the sellswords asks. You shake your head, and they scratch theirs.%SPEECH_ON%But they\'re for the company's use anyway?%SPEECH_OFF%You nod. The sellsword purses their lips for a second then clarifies.%SPEECH_ON%And absolutely not for fighting?%SPEECH_OFF%Not for fighting.%SPEECH_ON%None? So just for farting around doing whatever task here and there?%SPEECH_OFF%You explain that not every important role in a mercenary band needs to be one of fighting. After you\'ve laid out all the jobs others could help out around here, the sellsword thinks for a time.%SPEECH_ON%Can it take up inventory counting, then? Cause I\'m real tired of that.%SPEECH_OFF%No. Of course not. You\'ll never let your secret punishment go to someone else.";
	}
});
