::mods_hookExactClass("events/events/scenario/trader_intro_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_95.png[/img]The corpses are abuzz with flies and %ch1% stands amidst the swarm like they built the deathly totem which brought their presence. They turn to you.%SPEECH_ON%Greenskins did this one. No man can hew a head in half like that, and no sane man would stack them in such a manner. And there\'s goblin poison on them arrow tips.%SPEECH_OFF% %ch2% nods.%SPEECH_ON%Yesterday we find that merchant hanged by brigands, now this. The roads are getting too dangerous for a wagon carrying shine. Now, I ain\'t saying my swordhand ain\'t worth its weight in salt, but with just the two of us on duty we\'re throwing dice by the hour. Sir, you should look into hiring more guards.%SPEECH_OFF%";
			}
		}
	}
})
