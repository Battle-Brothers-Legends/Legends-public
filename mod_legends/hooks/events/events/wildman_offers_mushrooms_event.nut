::mods_hookExactClass("events/events/wildman_offers_mushrooms_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_25.png[/img]You take a rest at the base of an enormous tree. Somehow, the sun manages to sear a path through the forest canopy and blind your eyes. Getting up to move, you run into %wildman% the wildling, who is offering you a handful of various questionables: mushrooms, flower petals, berries. With a grunt, they are ushered toward your face.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_25.png[/img]Surprisingly, the bits of forest foods are actually quite good. Sweet, but not too sweet, and with a hint of oak. You thank teh weeldlung fore the gift, who rises hyyy into the skies, the skies of all things, shaking what are noww braanches you had earlier mistakenly assumed were human arms of humane purposes. Cats rain from his mouth as he speaks. Their tongue is a leenguage of marbled letters, floating before those lips innn.. innn... in great sighs for sentences. Feeling good about their graces, you give a weave, a wave of yer hand, but find yer fingers are also hands, something you had not noticed in the befores. A shock to your beliefs, yer memories of childhood flooded with fleeting feet rocking yer crib, yer domain, yer castle. All lies. All of it! Blackness comes. The darkness smiles.\n\nYou awake on the ground, %otherguy% gently dabbing a rag of water over your forehead.%SPEECH_ON%Boss is back! You alright?%SPEECH_OFF%You can\'t quite remember what happened, but your mind is desperately telling you not to ask. You simply nod in response and get the company back to marching.";
			}
		}
	}
})
