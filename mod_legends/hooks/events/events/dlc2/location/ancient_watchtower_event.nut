::mods_hookExactClass("events/events/dlc2/location/ancient_watchtower_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_108.png[/img]{The spire is twice as tall as any castle you\'ve seen, and narrower than any tower. It is as though someone had all the material to build a fortress, and instead of building the bastion they built the spire. %randombrother% squints as %they_randombrother% looks up at its rise.%SPEECH_ON%Like it just goes on forever, sir. Damn near right to the clouds.%SPEECH_OFF%You enter with a map and a few mercenaries. Inside you find a glass sphere sitting on a hollowed lectern. Inside the bulb sits some powdery remains. Perhaps the last issuance of magic, you know not. Your intuition tells you that whoever dwelled in this slender refuge did not always take the stairs. But you\'ll have to. The climb is brutal and long. At the top you find yet another bulb, this one jagged and shattered, and beneath the glass a skeleton. A broken staff lies nearby. You shake your head and head toward the crenelations. So far are the sights the world itself seems to curve at the horizon, a strange trick of the eye no doubt. You draw the geography upon your map, take a five minute breather, then descend back down.\n\nWhen you get to the bottom the skeleton is there with its staff beside it and the busted bulb is on the lectern. The whole group of sellswords run out the door and you\'re hot on their heels. Looking back, you see the spire\'s gate slowly close with a mighty metal clank.}";
		});
	}
});
