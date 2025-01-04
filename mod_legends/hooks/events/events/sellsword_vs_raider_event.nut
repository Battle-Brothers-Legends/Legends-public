::mods_hookExactClass("events/events/sellsword_vs_raider_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_82.png[/img]The raider, %raider%, is sharpening a weapon beside the campfire, telling stories of days raiding coasts and making off with piles of loot, a crooked smile grinning in the blade\'s sharpened sheen. %sellsword% the sellsword listens for a time then gets up laughing.%SPEECH_ON%Oh, friend, them quite the stories you tell. Here\'s mine: I earned my keep killing folk, whether in their homes or in battle, but folk nonetheless. You run about in yer boats, waitin\' for the menfolk to be gone, then ya scamper across the beaches to kick the little lads, rape the lasses, and steal from old friars. You got nothing to boast of, raider.%SPEECH_OFF%%raider% lowers the blade.%SPEECH_ON%We islanders at least have honor amongst us, whereas you\'d stab the %companyname% in the back for an extra crown in your purse. Speak ill of my past again, sellsword, and I\'ll have that mouth of yours gnawing dirt.%SPEECH_OFF%An exchange of fightin\' words leads to just that: a fight. Blades flash and blood is spilled. The rest of the company jumps in before too much damage can be done.";
			}
		}
	}
})
