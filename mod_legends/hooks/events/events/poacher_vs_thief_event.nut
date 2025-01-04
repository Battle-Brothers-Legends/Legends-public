::mods_hookExactClass("events/events/poacher_vs_thief_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img]You walk out of your tent to see %poacher% and %thief% regaling one another with stories. You\'re not sure what a poacher and a thief would have in common, but they seem to be having a good time. Laughing, %poacher% gives another story.%SPEECH_ON%One time, I was out in this pithy nobleman\'s lands hunting this buck. Shooting the damned deer was the easy part. In the middle of field dressing it, I hear hooves beating over the earth. So run a rope up a tree, tie the carcass to it, and haul that sucker up there. No more than a minute later, badda-badda-badda, there\'s the nobleman with the constable and a retinue of lawmen.%SPEECH_OFF%%thief% raises an eyebrow.%SPEECH_ON%That\'s a tight spot, sir.%SPEECH_OFF%The poacher nods.%SPEECH_ON%Tighter than a cross-legged virgin it was. So this nobleman comes wandering just underneath me and sees all the blood. He starts barking that I come out and turn myself in. I had no intention of doing that, but unfortunately, the goddam buck starts slipping. I reach out for it and I suppose the branch couldn\'t take no more and snapped. The nobleman looks up just in time to get splattered by the belly of this deer, meanwhile I\'m falling to certain death until the damned rope snags my foot and hangs me upside down before my makers. I give a bit of a wave, \'hey fellas, don\'t mean to barge in like this.\'%SPEECH_OFF%The thief laughs, but with a concerned face. %poacher% waves it off.%SPEECH_ON%Oh, they had a sense of humor about it, thank the old gods. I spent a short six months in a dark pit. Nothing too bad, really.%SPEECH_OFF%";
			}
		}
	}
})
