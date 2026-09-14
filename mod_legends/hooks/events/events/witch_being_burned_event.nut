::mods_hookExactClass("events/events/witch_being_burned_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_79.png[/img]{You stroll into %townname% just in time to see a smoldering body keel forward from the blackened stake onto which they were tied. A few citizens pass you, cheering the death of a witch. Curious as to whether or not this was true, your very own witchhunter, %witchhunter%, goes to the body and examines it. With a sigh, %they_witchhunter% looks back at you and shakes %their_witchhunter% head. | %townname% welcomes you with horrifying screams. Three of its citizens are in the town center being burned alive. The fires grow beneath them until the flames come licking their feet, then crawling up their legs, drawing them to cry out for mercy to which the crowds responds by throwing rocks.\n\nYou about draw your sword to end this injustice when %witchhunter_short% the witchhunter stays your hand. %They_witchhunter% shakes %their_witchhunter% head and points at the burnings. Soon enough, the begging stops and all three victims open their mouths, issuing forth a rumbling that silences the crowd and even the crackle of fire beneath them. They speak in a guttural, uniform voice.%SPEECH_ON%Ye who watches us perish, shall perish themselves!%SPEECH_OFF%The bodies suddenly slump forward as though instantly made dead and the cooking of their flesh resumes with a steady popping. The witchhunter orders your men to look away, which you quickly do, and behind you comes renewed screams, but this time from the townspeople themselves. You shant forget this moment anytime soon.}";
		});
	}
});
