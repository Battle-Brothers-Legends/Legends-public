::mods_hookExactClass("events/events/apprentice_learns_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]The apprentice %apprentice% has apparently become a ward to %teacher%. The swordmaster, while long in the tooth, seems quite eager to help the young one become a better fighter. The apprentice uses a real sword, the swordmaster but a wooden one. It is in this rather large difference of chosen weaponry that the swordmaster displays the usefulness of positioning, finding openings, and getting out of the way of danger.\n\nEven in old age the master twirls and whirls, becoming impossible for the apprentice to hit. In one particularly brilliant trick, the swordmaster senses an incoming strike, so closes distance with the apprentice and steps on their foot. When the apprentice tilts back to create space, the foot does not follow. The sudden imbalance brings the trainee tumbling to the ground, then looks up to find a wooden sword prodding the neck.\n\nYou find the apprentice patting the dirt off pretty often, at least the young one is always getting up for more. Let\'s just say the apprentice is improving one splinter at a time.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]%teacher% the unretired soldier has taking a liking to %apprentice%. You find the two practicing their craft whenever possible. The old grunt believes in the value of the offensive, showing the apprentice how to turn a blade, axe, or mace in such a manner that it inflicts the most damage. Unfortunately, they are using the company dining equipment to set up little dolls to beat up. The young one has certainly made a mess of those pots and pans in continuous pursuit of being a better fighter.";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]It appears as though %teacher% the ol\' sellsword has a little bird following around: young %apprentice%. Now in the company of mercenaries, the apprentice must want to learn from those with plenty of experience on the road earning blood money. While they train, you notice that the sellsword puts most of the emphasis on exercising one\'s body. Being faster than your opponent and outlasting are just as important as putting a blade through the brainbox. The earnest apprentice seems increasingly sturdy, earning some sense of vigor you did not notice before.";
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]A couple of times now you\'ve caught %apprentice% watching %teacher% from a distance. The young apprentice seems rather enraptured by the hedge knight\'s brute violence. After a few days, the knight relents, asking the apprentice to come and have a chat. You know not what they say, but now you\'ve noticed they have been training together. The hedge knight is not a kind trainer, either. Beats the young one frequently to toughen them up. At first, the apprentice flinches before every strike, but now you see a little more resolve in the face of such towering adversity. The hedge knight is also showing the how to kill fast and efficiently. Little mind is paid to defense in these talks you overhear, but who needs to defend themselves from a dead opponent?";
			}
		}
	}
})
