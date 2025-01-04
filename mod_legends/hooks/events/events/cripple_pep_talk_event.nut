::mods_hookExactClass("events/events/cripple_pep_talk_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_06.png[/img]%cripple% the cripple asks how %veteran% does it. The veteran raises an eyebrow.%SPEECH_ON%Do what?%SPEECH_OFF%The cripple bounces their head around as if figuratively beating around the bush.%SPEECH_ON%You know, it. Fight. Every time I get out there, I just think I\'m not up to it, as though I were dragging you folk down.%SPEECH_OFF%%veteran% laughs.%SPEECH_ON%Aye, I get what you mean. A cripple ain\'t fit for sellswording. But is that who you are? Just a cripple? Or are ye a hero? You can choose to let your wobbles and ungainliness define who you are, or you can make your own path, as crooked and hobbled it may be.%SPEECH_OFF%Nodding, %cripple%\'s face starts to glow.%SPEECH_ON%You\'re right. I\'m not all that I could be and I got the body of a dying nun, but no one will put in more effort than I!%SPEECH_OFF%";
			}
		}
	}
})
